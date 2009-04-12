//
//  CAFlickrPlugin.m
//  Clips Flickr Plug-in
//
//  Created by Nicholas Penree on 6/6/08.
//  Copyright 2008 Conceited Software. All rights reserved.
//

#import "CAAmazonPlugin.h"
#import "CAAmazonProductGrabber.h"

@implementation CAAmazonPlugin

@synthesize currentClip;

+ (CARelevance)relevanceForPivot:(CAPivot *)pivot
{
	CADatatype *dt = [pivot getDatatype:NSStringPboardType];
	
	if ([CAAmazonProductGrabber hasExpectedPrefix:dt.string]) {
		return CAVeryHighlyRelevant;
	}
	
	return CAIrrelevant;
}

+ (NSSet *)requiredTypes
{
	// We don't require any specific pasteboard types for our plugin to work
	return [NSSet setWithObject:NSStringPboardType];
}

- (void)copyClip:(CAClip *)clip
{
	CADatatype *dt = [clip.pivot getDatatype:NSStringPboardType];
	CAAmazonProductGrabber *grabber = [[CAAmazonProductGrabber alloc] initWithString:dt.string];
	
	grabber.delegate = self;
	self.currentClip = clip;
	
	[grabber grabData];
}

- (void)pasteClip:(CAClip *)clip
{
	// Nothing to do here: default behavior when pasting a clip is to use the full range of pasteboards it generated in the first palce and let OS X handle it.
}

- (void)grabberDidGrabData:(NSDictionary *)data
{	
	NSDictionary *dict = data;
	
	//NSLog(@"%@", dict);
	
	NSError *err = [dict objectForKey:@"error"];
	
	if (err != nil) {
		NSLog(@"oembed error: %@", [err.userInfo objectForKey:@"NSLocalizedDescription"]);
	} else {
		//NSLog(@"%@", dict);
		
		self.currentClip.pivot.type = [NSNumber numberWithInt:CAImagePivotType];
		
		// Let's create an image object for our new clip
		CAImageObject *imageObject = [self.currentClip imageObject];
		
		// The full-size image of the clip will be Clips' icon in our case
		imageObject.fullImage = [[[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"url"]]] autorelease];
		
		// The thumbnail mode tells Clips how to compute the various thumbnails from the full image.
		// In our case, it'll be scaled.
		imageObject.thumbnailMode = [NSNumber numberWithShort:CAScaleThumbnailMode];
		
		// Is the image opaque? In our case, yes. If the value was NO, Clips would add an opaque background to the image whenever needed.
		imageObject.isOpaque = [NSNumber numberWithBool:YES];
		
		//Let's set the name of our clip
		self.currentClip.name = [dict objectForKey:@"title"];
		
		// The name and image are all set up, there is nothing more for us to do: let's validate the clip.
		[self.currentClip validate:self];
		
	}
}


@end
