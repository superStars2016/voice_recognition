//
//  langueButton.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/27.
//  Copyright © 2016年 lander. All rights reserved.
//自定义选择语言的button

#import "langueButton.h"

@implementation langueButton
-(void)awakeFromNib{
    //设置imageView titleLabel对齐方式
    self.imageView.contentMode=UIViewContentModeRight;
    self.titleLabel.textAlignment=NSTextAlignmentRight;
}
/**
 *  调整imageView的位置
 *
 *  @param contentRect 当前button的CGrect
 *
 *  @return 返回imageView的Rect
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(contentRect.size.width*0.7, 0, contentRect.size.width*0.3, contentRect.size.height);
}
/**
 *  调整titleLabel的位置
 *
 *  @param contentRect 当前label的CGrect
 *
 *  @return 返回label的Rect
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
return CGRectMake(0, 0, contentRect.size.width*0.8, contentRect.size.height);
}


@end
