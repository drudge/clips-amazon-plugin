//
//  FlickrImageGrabber.m
//  Test oembed
//
//  Created by Nicholas Penree on 9/27/08.
//  Copyright 2008 Conceited Software. All rights reserved.
//

#import "CAAmazonProductGrabber.h"

@implementation CAAmazonProductGrabber

@synthesize apiEndpointURL;

+ (BOOL) hasExpectedPrefix:(NSString *)anURL
{
	NSString *someURL = [anURL lowercaseString];
	
	//http://*.amazon.(com|co.uk|de|ca|jp)
	BOOL hasPrefix = (([someURL hasPrefix:@"http://amazon.com/"] || [someURL hasPrefix:@"http://www.amazon.com/"] ||
					  [someURL hasPrefix:@"http://amazon.co.uk/"] || [someURL hasPrefix:@"http://www.amazon.co.uk/"] ||
					  [someURL hasPrefix:@"http://amazon.de/"] || [someURL hasPrefix:@"http://www.amazon.de/"] ||
					  [someURL hasPrefix:@"http://amazon.ca/"] || [someURL hasPrefix:@"http://www.amazon.ca/"] ||
					  [someURL hasPrefix:@"http://amazon.jp/"] || [someURL hasPrefix:@"http://www.amazon.jp/"]) &&
					  (([someURL rangeOfString:@"gp/product/"].location != NSNotFound) ||  ([someURL rangeOfString:@"dp/"].location != NSNotFound) ||
						([someURL rangeOfString:@"o/ASIN/"].location != NSNotFound) ||  ([someURL rangeOfString:@"obidos/ASIN/"].location != NSNotFound) ));

	return hasPrefix;
}

- (NSString *)apiEndpointURL
{
	return @"http://oohembed.com/oohembed/";
}

@end
