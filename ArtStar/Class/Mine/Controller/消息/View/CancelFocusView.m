//
//  FocusView.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CancelFocusView.h"
#import "FocusViewNickNameCell.h"
#import "FocusViewTopCell.h"
#import "FocusViewChatInfoCell.h"
#import "FocusViewChatPermissionsCell.h"
#import "FocusViewChatFocusCell.h"
#import "MsgTapNoteVC.h"

@interface CancelFocusView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) KGSearchChatHistoryView *searchView;
@property (nonatomic,strong) ReportView *reportView;

@end

@implementation CancelFocusModel
@end

@implementation CancelFocusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.backgroundColor = Color_fafafa;
    _listView.scrollEnabled = NO;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewChatInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewChatInfoCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FocusViewChatFocusCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusViewChatFocusCell"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 60;
    }else{
        return 50;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerForSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    headerForSection.backgroundColor = Color_fafafa;
    return headerForSection;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
        cell.titleLab.text = @"查找聊天记录";
        return cell;
    }else if (indexPath.section == 1){
        FocusViewChatInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatInfoCell"];
        cell.titleLab.text = @"举报";
        return cell;
    }else{
        FocusViewChatFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusViewChatFocusCell"];
        cell.titleLab.text = @"关注";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.searchView.hidden = YES;
    }else if (indexPath.section == 1){
        self.reportView.hidden = NO;
    }else{
        if (self.focusOn) {
            self.focusOn();
        }
    }
}

- (KGSearchChatHistoryView *)searchView{
    if (!_searchView) {
        _searchView = [[KGSearchChatHistoryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [[self rootViewCintroller].navigationController.view addSubview:_searchView];
    }
    return _searchView;
}
- (ReportView *)reportView{
    if (!_reportView) {
        _reportView = [[ReportView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [[self rootViewCintroller].navigationController.view addSubview:_reportView];
    }
    return _reportView;
}
- (UIViewController *)rootViewCintroller{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
