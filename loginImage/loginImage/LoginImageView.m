//
//  LoginImageView.m
//  loginImage
//
//  Created by Meeno04 on 15/6/12.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import "LoginImageView.h"
#include "UIImage+animatedGIF.h"

@interface LoginImageView()
@end

@implementation LoginImageView

-(instancetype)initWithString:(NSString *)str
{
    //connot use the if(!self)
    self = [super init];
    
    NSRange rang0 = [str rangeOfString:@"http://"];
    NSRange rang1 = [str rangeOfString:@".gif"];
    
    if (rang0.length != 0) { //if a
        NSURL *url = [NSURL URLWithString:str];
        self.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    }else if(rang1.length != 0){
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:str ofType:nil]];
        self.image = [UIImage animatedImageWithAnimatedGIFData:data];
    }else{
        self.image = [UIImage imageNamed:str];
    }
    self.frame = [UIScreen mainScreen].bounds;
    
    return self;
}

-(void)disapearInDelay:(CGFloat)delay
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeFromSuperview];
        [self.delegate loadImageViewDidDisappear];
    });
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//http://s10.sinaimg.cn/bmiddle/49803905tb77de727e479&690
@end
