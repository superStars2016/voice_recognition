//
//  VoiceWebJsCore.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/2.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "VoiceWebJsCore.h"

@implementation VoiceWebJsCore
//-(void)dealloc{
//    NSLog(@"已销毁");
//}
-(void)showVoiceView{
    if ([self.delegate respondsToSelector:@selector(showVoiceView)]) {
        [self.delegate performSelector:@selector(showVoiceView) withObject:nil];
    }

}
-(void)dissMissVoiceView{

    if ([self.delegate respondsToSelector:@selector(dissMissVoiceView)]) {
        [self.delegate performSelector:@selector(dissMissVoiceView) withObject:nil];
    }

}
@end
