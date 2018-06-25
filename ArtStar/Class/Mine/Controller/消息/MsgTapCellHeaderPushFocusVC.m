//
//  MsgTapCellHeaderPushFocusVC.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MsgTapCellHeaderPushFocusVC.h"
#import "FocusView.h"
#import "CancelFocusView.h"

@interface MsgTapCellHeaderPushFocusVC ()

@property (nonatomic,strong) FocusView *focus;
@property (nonatomic,strong) CancelFocusView *cancelFocus;

@end

@implementation MsgTapCellHeaderPushFocusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"欧阳若曦" image:Image(@"back")];
    self.view.backgroundColor = Color_fafafa;
    
    _focus = [[FocusView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    __weak typeof(self) mySelf = self;
    _focus.cancelFocus = ^{
        [mySelf.view bringSubviewToFront:mySelf.cancelFocus];
    };
    [self.view addSubview:_focus];
}

- (CancelFocusView *)cancelFocus{
    if (!_cancelFocus) {
        _cancelFocus = [[CancelFocusView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
        __weak typeof(self) mySelf = self;
        _cancelFocus.focusOn = ^{
            [mySelf.view bringSubviewToFront:mySelf.focus];
        };
        [self.view addSubview:_cancelFocus];
    }
    return _cancelFocus;
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
