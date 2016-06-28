//
//  langueButton.m
//  VoiceRecognitio
//
//  Created by lander on 16/6/27.
//  Copyright © 2016年 lander. All rights reserved.
//

#import "langueButton.h"

@implementation langueButton
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self=[super initWithFrame:frame]) {
//        
//    }
//
//    return self;
//}
-(void)awakeFromNib{

    self.imageView.contentMode=UIViewContentModeRight;
    self.titleLabel.textAlignment=NSTextAlignmentRight;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(contentRect.size.width*0.7, 0, contentRect.size.width*0.3, contentRect.size.height);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
return CGRectMake(0, 0, contentRect.size.width*0.8, contentRect.size.height);

}


@end
