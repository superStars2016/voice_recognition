//
//  NDResultViewController.h
//  naverdicapp
//
//  Created by naver on 16/8/18.
//  Copyright © 2016年 Naver_China. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  NDResultViewController;
@protocol NDResultViewControllerDelegate<NSObject>
@optional
/**
 *  点击了textView上的超链接 返回结果给web
 *
 *  @param RecognizeResultTextView textiew
 *  @param resulatString           翻译结果一并返回
 */
-(void)ResultViewController:(NDResultViewController *)ResultViewController  resultString:(NSString *)resulatString;
@end
@interface NDResultViewController : UIViewController

@property (strong,nonatomic) NSDictionary * resultDcit;

@property (nonatomic,weak) id<NDResultViewControllerDelegate> delegate;
- (void)rotateViews:(CGFloat)angle withDeviceOrientation:(UIDeviceOrientation)orientation ;
@end
