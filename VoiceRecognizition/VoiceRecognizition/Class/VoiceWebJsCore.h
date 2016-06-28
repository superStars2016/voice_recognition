//
//  VoiceWebJsCore.h
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol VoiceWebJsCoreDelegate <NSObject>
@optional
-(void)ShowVoiceView;
-(void)dissMissVoiceView;

@end
@protocol VoiceWebJsCoreProtocol <JSExport>

-(void)showVoiceView;

-(void)dissMissVoiceView;

@end
@interface VoiceWebJsCore : NSObject<VoiceWebJsCoreProtocol>
@property (nonatomic,weak) id<VoiceWebJsCoreDelegate> delegate;

@end
