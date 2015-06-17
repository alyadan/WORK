//
//  FirstLaunchController.m
//  loginImage
//
//  Created by Meeno04 on 15/6/12.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import "FirstLaunchView.h"
#import "UIImage+animatedGIF.h"
#import "LoginImageView.h"
#import "TestViewController.h"

@interface FirstLaunchView ()<UIScrollViewDelegate>{
    long _page; //flag using for compara with PageControl.currentPage to control the scroll opportunity
    CGFloat _delay;
}
@property(nonatomic,strong)UIScrollView* scroll;
@property(nonatomic,strong)UIPageControl *pageCtl;
@property(nonatomic, strong)UIButton *disappearBtn;

@end
@implementation FirstLaunchView

@synthesize imageViewArray = _imageViewArray;

#pragma mark- input the NSString array init the array of LoginImageView


/**
 *  lazyload imageViewArray
 */
-(NSArray *)imageViewArray
{
    if (!_imageViewArray) {
        _imageViewArray = [NSArray array];
    }
    return _imageViewArray;
}


/**
 *  lazyload scroll and setting scroll
 */
-(UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.frame = [UIScreen mainScreen].bounds;
        _scroll.frame = self.frame;
        
        //setting the total ContentSize
        CGRect screenBound = [UIScreen mainScreen].bounds;
        _scroll.contentSize = CGSizeMake(screenBound.size.width * self.imageViewArray.count,
                                         screenBound.size.height);
        for(LoginImageView *view in self.imageViewArray)
            [_scroll addSubview:view];
        
        [self addSubview:_scroll];
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
    }
    
    //是否能超出横向边框
    _scroll.bounces = NO;
    _scroll.alwaysBounceHorizontal = NO;
    
    //是否显示滚动条
    _scroll.showsHorizontalScrollIndicator = NO;
    
    return _scroll;
}


/**
 *  lazyload pageCtl and setting pageCtl
 */
-(UIPageControl *)pageCtl
{
    CGFloat pageW = 60;
    CGFloat pageH = 10;
    CGFloat pageY = self.frame.size.height * 0.8;
    CGFloat pageX = self.frame.size.width * 0.5 - pageW / 2;
    
    if (!_pageCtl) {
        _pageCtl = [[UIPageControl alloc] initWithFrame:
                    CGRectMake(pageX,
                               pageY,
                               pageW,
                               pageH)];
        self.pageCtl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
        _pageCtl.numberOfPages = self.imageViewArray.count;
        [self addSubview:_pageCtl];
    }
    return _pageCtl;
}


/*
 *  init and setting LoginImageView
 */
-(void)setImageViewArray:(NSArray *)imageViewArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    

    for(int i = 0; i < imageViewArray.count ; i++){
        NSString * string = imageViewArray[i];
        LoginImageView *imageView = [[LoginImageView alloc] init];
        

        if ([self isStaticPicture:string]) { // if is static photo
            imageView.type = STATIC;
            imageView.image = [UIImage imageNamed:string];
            
        }else{                              // not a static photo
            imageView.type = DYNAMIC;
            NSURL *url = [[NSBundle mainBundle] URLForResource:string withExtension:nil];
            imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        }
        
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        CGFloat H = [UIScreen mainScreen].bounds.size.height;
        
        imageView.frame = CGRectMake(i * W, 0, W, H);
        [tempArray addObject:imageView];
    }
    
    //add the disappear button on the last ImageView
    
    LoginImageView *lastView = [tempArray lastObject];
    lastView.userInteractionEnabled = YES;
    
    self.disappearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.disappearBtn= [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50,
                                                               [UIScreen mainScreen].bounds.size.height * 0.9,
                                                               100,
                                                               20)];
    [self.disappearBtn setTitle:@"disappear" forState:UIControlStateNormal];
    [self.disappearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [lastView addSubview:self.disappearBtn];
    [self.disappearBtn addTarget:self action:@selector(disappearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    _imageViewArray = [NSArray arrayWithArray:tempArray];
}


-(void)disappearBtnClicked
{
    [self.delegate HideBtnClicked];
}

/*
 *judge is it static picture?
 */
-(BOOL)isStaticPicture:(NSString *)str
{
    NSRange rang = [str rangeOfString:@".gif"];
    if (rang.length == 0) {
        return 1;
    }else{
        return 0;
    }
}





/**
 *  scroll's Delegate function
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scroll.contentOffset.x / pageWidth;
    self.pageCtl.currentPage = roundf(pageFraction);
}

/**
 *  autoScroll
 */
-(void)autoScroll
{
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf scrollNext];
        });
}

-(void)scrollNext
{
    _page++;
    CGFloat X = (self.scroll.contentOffset.x + 376) > 750 ? 750:(self.scroll.contentOffset.x + 376);
  
    if (_page == self.pageCtl.currentPage + 1) {
        [UIView animateWithDuration:0.3f animations:^(){
            [self.scroll setContentOffset: CGPointMake(X, 0)];
        }];
    }else{
        if (self.scroll.contentOffset.x == 750) {
            [self disappearBtnClicked];
            return;
        }
        _page = self.pageCtl.currentPage;
        [self autoScroll];
        return;
    }
    __weak typeof(self) weakSelf =self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf scrollNext];
    });
    
}

/**
 *  arrayOfPhote 的每一个元素都应该是图片完整名字，可以动态图和静态图混合排列在一起。
 */
+(instancetype)ViewWithArray:(NSArray *)arrayOfPhoto AutoScroll:(BOOL)isAuto Delay:(CGFloat)delay
{
    
    FirstLaunchView *view = [[self alloc] initWithDelay: delay];
    
    [view setImageViewArray:arrayOfPhoto];
    
    //set the scroll
    
    [view scroll];
    
    //set the pageCtl
    [view pageCtl];
    
    
    if (isAuto) {
        [view autoScroll];
    }
    return view;
}


-(instancetype)initWithDelay:(CGFloat)delay
{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        _delay = delay;
    }
    
    return self;
}







@end
