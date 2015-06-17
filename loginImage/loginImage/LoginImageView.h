//
//  LoginImageView.h
//  loginImage
//
//  Created by Meeno04 on 15/6/12.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    STATIC,
    DYNAMIC
}PICTURETYPE;

@protocol LoginImageViewDelegate <NSObject>

-(void)loadImageViewDidDisappear;

@end

@interface LoginImageView : UIImageView
@property(nonatomic, assign)PICTURETYPE type;
@property(nonatomic, weak)id<LoginImageViewDelegate> delegate;

/**
 *  图片持续的时间（效果为）
 */
-(void)disapearInDelay:(CGFloat)delay;
/**
 *  str可以时图片的url地址（无论gif动态图或者png jpg静态图
    如果时本地的图片，就直接赋值为图片的名称（必须带后缀）
 */
-(instancetype)initWithString:(NSString *)str;

@end
