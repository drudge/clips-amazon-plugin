//
//  CAAmazonPlugin.h
//  Clips Amazon Plug-in
//
//  Created by Nico on 6/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Clips Kit/Clips Kit.h>
#import <NLKit/CSOEmbedGrabberDelegate.h>

@interface CAAmazonPlugin : NSObject <CAPluginProtocol, CSOEmbedGrabberDelegate>
{
	CAClip *currentClip;
}

@property (nonatomic, retain) CAClip *currentClip;

@end
