//
//  NDResultViewController.m
//  naverdicapp
//
//  Created by naver on 16/8/18.
//  Copyright © 2016年 Naver_China. All rights reserved.
//

#import "NDResultViewController.h"
#import <PureLayout/PureLayout.h>

#import "NDRecognizeResultTextView.h"


#define HEX_COLOR(c,a)          \
[UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:(a)]
#define UIColorWithRGB(r, g, b) \
[UIColor colorWithRed:1.0*(r)/0xff green:1.0*(g)/0xff blue:1.0*(b)/0xff alpha:1.0]

#define IS_IOS9_OR_HEIGHER      \
(([[UIDevice currentDevice].systemVersion floatValue] >=9.0) ? YES:NO)

#define IS_HEIGHER_Version(version)     \
(([[UIDevice currentDevice].systemVersion floatValue] >=(version)) ? YES:NO)
@interface NDResultViewController ()<NDRecognizeResultTextViewDelegate>
/** resultView */
@property (nonatomic, strong) UIView        *resultView;

/** 顶部view */
@property (nonatomic,strong) UIView         *topView;

/** 底部view */
@property (nonatomic,strong) UIView         *bottomView;

/** 顶部折叠按钮 */
@property (nonatomic,strong) UIButton       *foldBtn;

@property (nonatomic,strong) UIView         *seprateLine;
/** 中间scrollView */
@property (nonatomic,strong) UIScrollView   *scrollView;

/** scrollViewz中de contentView */
@property (nonatomic, strong) UIView        *contentView;
/** 底部在翻译中显示结果 */
@property (nonatomic,strong) UIButton       *showInTranslateResultBtn;
/**右侧图片*/
@property (nonatomic,strong) UIImageView    *showInTranslateImgIndicater;

/** 记录self.view 高度的约束 */
@property (nonatomic, strong) NSLayoutConstraint *ResultViewNDLayoutHeight;

/** 是否已经执行约束初始化  */
@property (nonatomic,assign) BOOL didSetupConstraints;;

/** scorllView-contentView中最后一个view */
@property (nonatomic,strong) UIView * lastView;

@property (nonatomic,assign) UIDeviceOrientation interface;

@property (nonatomic,strong) NSLayoutConstraint *selfViewNDlayoutTop;
@property (nonatomic,strong) NSLayoutConstraint *selfViewNDlayoutLeft;
@property (nonatomic,strong) NSLayoutConstraint *selfViewNDlayoutRight;

@property (nonatomic,strong) NSLayoutConstraint *selfViewNDlayoutbottom;
@property (nonatomic,strong) NSLayoutConstraint *selfViewNDLayoutHeight;
@property (nonatomic,strong) NSLayoutConstraint *selfViewNDlayoutWidth;


@property (nonatomic,strong) NSLayoutConstraint *LastViewNDlayout;


@end

@implementation NDResultViewController
#pragma mark 懒加载
/**
 *  topView
 *
 *  @return <#return value description#>
 */
-(UIView *)resultView{
    if (!_resultView) {
        _resultView=[UIView newAutoLayoutView];
        _resultView.backgroundColor=[UIColor clearColor];
        //_resultView.backgroundColor=HEX_COLOR(0xEFEFEF, 1.0);
    }
    
    return _resultView;
}
/**
 *  topView
 *
 *  @return <#return value description#>
 */
-(UIView *)topView{
    if (!_topView) {
        _topView=[UIView newAutoLayoutView];
        _topView.backgroundColor=HEX_COLOR(0xEFEFEF, 1.0);
    }
    
    return _topView;
}
/**
 *  底部
 *
 *  @return <#return value description#>
 */
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[UIView newAutoLayoutView];
        _bottomView.backgroundColor=HEX_COLOR(0xEFEFEF, 1.0);
    }
    
    return _bottomView;
    
}
/**
 *  顶部展开 &关闭 折叠按钮
 *
 *  @return <#return value description#>
 */
-(UIButton *)foldBtn{
    if (!_foldBtn) {
        _foldBtn=[UIButton newAutoLayoutView];
        [_foldBtn setImage:[UIImage imageNamed:@"folding_btn.png"] forState:UIControlStateNormal];
        
        [_foldBtn addTarget:self action:@selector(foldBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foldBtn;
    
}
/**
 *  分割线
 *
 *  @return <#return value description#>
 */
-(UIView *)seprateLine{
    if (!_seprateLine) {
        _seprateLine=[UIView newAutoLayoutView];
        _seprateLine.backgroundColor=HEX_COLOR(0xEAEAEA, 1.0);
    }
    return _seprateLine;
}
/**
 *  底部-在翻译中查看按钮
 *
 *  @return <#return value description#>
 */
-(UIButton *)showInTranslateResultBtn{
    if (!_showInTranslateResultBtn) {
        _showInTranslateResultBtn=[UIButton newAutoLayoutView];
        _showInTranslateResultBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_showInTranslateResultBtn setTitleColor:HEX_COLOR(0x999999, 1.0) forState:UIControlStateNormal];
        [_showInTranslateResultBtn setTitle:@"在水电费水电费查看" forState:UIControlStateNormal];
        [_showInTranslateResultBtn addTarget:self action:@selector(openInTranslatetion:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _showInTranslateResultBtn;
    
}
/**
 *  右侧箭头
 *
 *  @return <#return value description#>
 */
-(UIImageView *)showInTranslateImgIndicater{
    if (!_showInTranslateImgIndicater) {
        _showInTranslateImgIndicater=[UIImageView newAutoLayoutView];
        _showInTranslateImgIndicater.image=[UIImage imageNamed:@"bullet_img.png"];
    }
    
    return _showInTranslateImgIndicater;
}
/**
 *  result ScrollView
 *
 *  @return <#return value description#>
 */
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[UIScrollView newAutoLayoutView];
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.bounces=NO;
    }
    return _scrollView;
    
}
/**
 *  scrollView中的contentView
 *
 *  @return <#return value description#>
 */
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [UIView newAutoLayoutView];
    }
    return _contentView;
}
#pragma mark view的方法
- (void)loadView {
    self.view = [UIView newAutoLayoutView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.resultView];
    self.view.hidden=YES;
    
    self.resultView.layer.cornerRadius=3;
    self.resultView.clipsToBounds=YES;
   
    
    [self.resultView addSubview:self.topView];
    [self.resultView addSubview:self.bottomView];
    [self.resultView addSubview: self.scrollView];
    
    [self.topView  addSubview:self.foldBtn];
    [self.topView addSubview:self.seprateLine];
    
    [self.bottomView addSubview:self.showInTranslateResultBtn];
    [self.bottomView addSubview:self.showInTranslateImgIndicater];
    
    [self.scrollView addSubview:self.contentView];
    
    
    [self.view setNeedsUpdateConstraints];
}
- (void)updateViewConstraints {
    
//    [self.selfViewNDlayoutTop autoRemove];
//    [self.selfViewNDlayoutRight autoRemove];
//    [self.selfViewNDlayoutLeft autoRemove];
//    [self.selfViewNDlayoutbottom autoRemove];
//    
//    if (self.interface) {
//        self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:200.0f];
//        self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        self.selfViewNDlayoutRight= [self.view autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        self.selfViewNDlayoutbottom =[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:100];
//    } else {
//        self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f];
//        self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        self.selfViewNDlayoutRight= [self.view autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        self.selfViewNDlayoutbottom =[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:85];
//
//    }
//    
    //CGSize screenSize= [UIScreen mainScreen].bounds.size;
    
    [self.selfViewNDlayoutTop autoRemove];
    [self.selfViewNDlayoutRight autoRemove];
    [self.selfViewNDlayoutLeft autoRemove];
    [self.selfViewNDlayoutWidth autoRemove];
    [self.selfViewNDLayoutHeight autoRemove];
    [self.selfViewNDlayoutbottom autoRemove];
   
    if (self.interface) {
        CGSize screenSize=[UIScreen mainScreen].bounds.size;
    
        CGFloat sddf=(screenSize.height-46-85-screenSize.width)/2;
        switch (self.interface) {
            case UIDeviceOrientationLandscapeLeft:
                self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f+sddf];
                self.selfViewNDlayoutbottom=[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:(85+sddf)];
                self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-sddf];
                self.selfViewNDlayoutWidth=  [self.view autoSetDimension:ALDimensionWidth toSize:screenSize.height-46-85];
                //self.selfViewNDLayoutHeight=  [self.view autoSetDimension:ALDimensionHeight toSize:screenSize.width];
                break;
            case UIDeviceOrientationLandscapeRight:
                self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f+sddf];
                self.selfViewNDlayoutbottom=[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:(85+sddf)];
                self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-sddf];
                self.selfViewNDlayoutWidth=  [self.view autoSetDimension:ALDimensionWidth toSize:screenSize.height-46-85];
                break;
            default:
                self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f];
                self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                self.selfViewNDlayoutRight= [self.view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                self.selfViewNDlayoutbottom=[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:85];
                
                break;
        }
        
    }else{
    
                self.selfViewNDlayoutTop = [self.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:47.0f];
                self.selfViewNDlayoutLeft= [self.view autoPinEdgeToSuperviewEdge:ALEdgeLeft];
                self.selfViewNDlayoutRight= [self.view autoPinEdgeToSuperviewEdge:ALEdgeRight];
                self.selfViewNDlayoutbottom =[self.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:85];
    
    }

    
    if (!self.didSetupConstraints) {
        [self.resultView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0];
        [self.resultView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0];
        [self.resultView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0];
       self.ResultViewNDLayoutHeight= [self.resultView autoSetDimension:ALDimensionHeight toSize:61.0f];
        
        [self.topView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.topView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.topView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.topView autoSetDimension:ALDimensionHeight toSize:24.0f];
        
        [self.scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topView ];
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.bottomView autoSetDimension:ALDimensionHeight toSize:37.0f];
        
        [self.scrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomView];
        //[self.scrollView autoPinEdgesToSuperviewEdges];
        
        [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        [self.contentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
        
        [self.foldBtn autoCenterInSuperviewMargins];
        [self.foldBtn autoSetDimensionsToSize:CGSizeMake(23, 23)];
        //seprateLine
        [self.seprateLine autoSetDimension:ALDimensionHeight toSize:1.0f];
        [self.seprateLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.seprateLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.seprateLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.topView];
        
        
        [self.showInTranslateImgIndicater autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
        [self.showInTranslateImgIndicater autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.showInTranslateResultBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.showInTranslateImgIndicater withOffset:-6.0f];
        [self.showInTranslateResultBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.showInTranslateImgIndicater];
        
        self.didSetupConstraints=YES;
    }
    [super updateViewConstraints];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  添加一条识别和翻译结果
 *
 *  @param recogResult OCR识别的结果
 *  @param transResult 翻译的结果
 */
-(void)AddOneRecognizionResultAndTransLateResult:(NSString *)recogResult transResult:(NSString *)transResult{
    //OCR识别结果
    NDRecognizeResultTextView *RecognizeResultTextView=[[NDRecognizeResultTextView alloc]init];
    RecognizeResultTextView.RecognizeResultTextViewDelegate=self;
    [self.contentView addSubview:RecognizeResultTextView];
    
    if (self.lastView) {
        //如果lastview不为空，先创建分割线。
        UIView *lineView=[UIView newAutoLayoutView];
        lineView.backgroundColor=HEX_COLOR(0xEAEAEA, 1.0);
        [self.contentView addSubview:lineView];
        [lineView autoSetDimension:ALDimensionHeight toSize:1.0];
        [lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lastView withOffset:17.0];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0f];
        
        //设置距离分隔线间距
        [RecognizeResultTextView  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineView withOffset:17.0f];
    }else{
        [RecognizeResultTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:17.0f];
    }
    
    
    [RecognizeResultTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
    [RecognizeResultTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    RecognizeResultTextView.singleResultText=recogResult;
    
    //翻译识别结果
    UILabel *translateResultLabel=[self createTranslateResultLabel];
    translateResultLabel.text=transResult;
    [self.contentView addSubview:translateResultLabel];
    
    [translateResultLabel  autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:RecognizeResultTextView withOffset:8.0f];
    [translateResultLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
    [translateResultLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    
    self.lastView=translateResultLabel;
}

-(UILabel *)createTranslateResultLabel{
    UILabel *translateResultLabel=[UILabel newAutoLayoutView];
    translateResultLabel.numberOfLines=0;
    translateResultLabel.backgroundColor=[UIColor clearColor];
    translateResultLabel.font=[UIFont systemFontOfSize:17.0];
    translateResultLabel.textColor=HEX_COLOR(0x000000, 1.0);
    
    return translateResultLabel;
}
/**
 *  展开 &合并
 *
 *  @param btn <#btn description#>
 */
-(void)foldBtnClicked:(UIButton *)btn{
    btn.selected=!btn.isSelected;
    if (btn.isSelected) {//选中进行折叠
        self.ResultViewNDLayoutHeight.constant=24.0f;
        self.view.alpha=0.5;
        self.bottomView.hidden=YES;
        self.scrollView.hidden=YES;
    }else{
        CGSize size=self.scrollView.contentSize;
        CGFloat height=size.height;
        if (height<=175) {
            self.ResultViewNDLayoutHeight.constant=height+24+37;
        }else{
            self.ResultViewNDLayoutHeight.constant=175+24+37;
        }
        
        self.view.alpha=1.0;
        self.bottomView.hidden=NO;
        self.scrollView.hidden=NO;
    }
}

- (void)rotateViews:(CGFloat)angle withDeviceOrientation:(UIDeviceOrientation)orientation {
    [UIView animateWithDuration:0.5f animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
        self.view.transform = transform;
        self.view.hidden=YES;
        
        //self.didSetupConstraints =NO;
        self.interface=orientation;
        [self.view setNeedsUpdateConstraints];
        
    }];
}
-(void)setResultDcit:(NSDictionary *)resultDcit{
    _resultDcit=resultDcit;
    self.view.hidden=NO;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    self.lastView=nil;
    
    self.bottomView.hidden=NO;
    self.scrollView.hidden=NO;
    
    NSArray *resultArray=self.resultDcit[@"ocrs"];
    if (resultArray && resultArray.count) {
        for (int i=0; i<resultArray.count; i++) {
            NSDictionary * OneResult=resultArray[i];
            NSString *OCRtext=OneResult[@"text"];
            
            [self AddOneRecognizionResultAndTransLateResult:OCRtext transResult:OCRtext];
            
            //最后一个控件设置距离底部间距(决定scrollContentSize高度)
            if (i==(resultArray.count-1)) {
               [self.lastView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:17.0f];
            }
        }
    }
   
    [self.view layoutIfNeeded];
    
    //拿到最终的contentSize,重新计算self.view的高度
    CGSize size=self.scrollView.contentSize;
    CGFloat height=size.height;
    if (height<=175) {
        self.ResultViewNDLayoutHeight.constant=height+24+37;
    }else{
        self.ResultViewNDLayoutHeight.constant=175+24+37;
    }
   
}

#pragma mark 点击了在翻译中查看按钮
-(void)openInTranslatetion:(id)sender{
    if([self.delegate respondsToSelector:@selector(ResultViewController:resultString:)]){
        [self.delegate ResultViewController:self resultString:@"您说的方式的方式的范德萨发的点点滴滴"];
    }
}
#pragma mark RecognizeResultTextViewDelegate
-(BOOL)RecognizeResultTextViewPlaySoundOnTTS:(NDRecognizeResultTextView *)RecognizeResultTextView{
    
    return YES;
}
-(void)RecognizeResultTextViewClickedTypeLinks:(NDRecognizeResultTextView *)RecognizeResultTextView resultString:(NSString *)resulatString{
    if([self.delegate respondsToSelector:@selector(ResultViewController:resultString:)]){
        [self.delegate ResultViewController:self resultString:resulatString];
    }
}
@end