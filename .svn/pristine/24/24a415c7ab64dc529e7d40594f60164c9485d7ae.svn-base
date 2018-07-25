//
//  MineLoadCoverVC.m
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineLoadCoverVC.h"
#import "MineCardLoadFriendCoverView.h"

@interface MineLoadCoverVC ()

@end

@implementation MineLoadCoverVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_fafafa;
    
    MineCardLoadFriendCoverView *coverView = [[MineCardLoadFriendCoverView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/750*580 + 70)];
    __weak typeof(self) mySelf = self;
    coverView.coverImage = _coverImage;
    coverView.popRootViewController = ^{
        [mySelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:coverView];
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
