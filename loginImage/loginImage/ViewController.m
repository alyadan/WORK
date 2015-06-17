//
//  ViewController.m
//  loginImage
//
//  Created by Meeno04 on 15/6/12.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import "ViewController.h"
#import "LoginImageView.h"

@interface ViewController (){
BOOL isFirstLaunch;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isFirstLaunch = [[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstLaunch"];
    if(isFirstLaunch){
        UIImageView *imageView = [[LoginImageView alloc] init];
        [self.view addSubview: imageView];
        [[NSUserDefaults standardUserDefaults] setValue:@(0) forKey:@"isFirstLaunch"];
    }
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
