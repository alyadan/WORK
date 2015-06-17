//
//  TestViewController.m
//  loginImage
//
//  Created by Meeno04 on 15/6/15.
//  Copyright (c) 2015年 Meeno04. All rights reserved.
//

#import "TestViewController.h"
#import "firstLaunchView.h"
#import "LoginImageView.h"
#import "DMPasscode.h"


@interface TestViewController ()<FirstLaunchViewDelegate,LoginImageViewDelegate>{
    CGFloat _loadImagedelay;
}

@property(nonatomic, strong)FirstLaunchView *firstLaunchView;
@property(nonatomic, strong)LoginImageView *loadView1;
@property(nonatomic, weak)TestViewController* weakSelf;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loadImagedelay = 2.0f;
    
//     Do any additional setup after loading the view.
    self.loadView1 = [[LoginImageView alloc] initWithString:@"1.jpg"];
    self.loadView1.delegate = self;
    [self.loadView1 disapearInDelay:_loadImagedelay];
    [self.view addSubview:self.loadView1];
    _weakSelf = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"AppleLauages"]);
}


/*
 *  FirstLaunchView's Delegate function
 */
-(void)HideBtnClicked
{
    [UIView animateWithDuration:1 animations:^(){
        self.firstLaunchView.alpha = 0;
    } completion:^(BOOL finished){
        [self.firstLaunchView removeFromSuperview];
    }];
    [DMPasscode setupPasscodeInViewController:self completion:^(BOOL success){
        NSLog(@"success");
    }];
}

/**
 *  当加载页消失之后
 */
-(void)loadImageViewDidDisappear
{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]){
        self.firstLaunchView = [FirstLaunchView ViewWithArray:@[@"loginImage.png",@"nature.gif",@"gun.gif"] AutoScroll: NO Delay:3.0f];
        self.firstLaunchView.delegate = self;
        [self.view addSubview: self.firstLaunchView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLaunched"];
        [DMPasscode setupPasscodeInViewController:self completion:^(BOOL success){
            NSLog(@"success");
        }];
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
