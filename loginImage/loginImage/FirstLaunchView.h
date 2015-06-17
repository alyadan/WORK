//
//  FirstLaunchController.h
//  loginImage
//
//  Created by Meeno04 on 15/6/12.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstLaunchView;
@protocol FirstLaunchViewDelegate <NSObject>
-(void)HideBtnClicked;

@end

@interface FirstLaunchView : UIView
@property(nonatomic,strong)NSArray *imageViewArray; // arroy of UIImageView
@property(nonatomic,weak)id<FirstLaunchViewDelegate> delegate;


/**
 * arrayOfPhote 的每一个元素都应该是图片完整名字，可以动态图和静态图混合排列在一起。
 */
+(instancetype)ViewWithArray:(NSArray *)arrayOfPhoto AutoScroll:(BOOL) isAuto Delay:(CGFloat)delay;

@end
