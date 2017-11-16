//
//  NDTextAttcahment.m
//  VoiceRecognizition
//
//  Created by naver on 16/8/24.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "NDTextAttcahment.h"

@implementation NDTextAttcahment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, -(lineFrag.size.height/4), lineFrag.size.height , lineFrag.size.height);
}
@end
