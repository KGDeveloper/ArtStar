//
//  MIneMessageVC.m
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MIneMessageVC.h"
#import "MineMessageHeaderView.h"
#import "MineSystemVC.h"
#import "MineSystemMessageListCell.h"
#import "MineChatDetaialViewController.h"

@interface MIneMessageVC ()<RCIMReceiveMessageDelegate>

@property (nonatomic,strong) MineMessageHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *newsArr;

@end

@implementation MIneMessageVC
//MARK:--左侧按钮--
- (void)setLeftButton{
    UIButton *leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtu.frame = CGRectMake(15, 0, 120, 15);
    [leftBtu setImage:Image(@"back") forState:UIControlStateNormal];
    [leftBtu setTitle:@"消息" forState:UIControlStateNormal];
    [leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    leftBtu.titleLabel.font = SYBFont(15);
    leftBtu.imageEdgeInsets = UIEdgeInsetsMake(8, 0, 8, leftBtu.bounds.size.width - 10);
    leftBtu.titleEdgeInsets = UIEdgeInsetsMake(0, leftBtu.imageView.frame.size.width + 20, 0, 0);
    leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtu addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtu];
    self.navigationItem.leftBarButtonItem = leftItem;
}
//MARK:--右侧按钮--
- (void)setRightButton{
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake(15, 0, 120, 15);
    [rightBtu setImage:Image(@"搜索") forState:UIControlStateNormal];
    rightBtu.imageEdgeInsets = UIEdgeInsetsMake(0, rightBtu.bounds.size.width - 15, 0, 0);
    rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtu addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtu];
    self.navigationItem.rightBarButtonItem = rightItem;
}
//MARK:--左侧按钮点击事件--
- (void)leftClick{
    UIApplication *app = [UIApplication sharedApplication];
    app.keyWindow.rootViewController = [[TabBarVC alloc]init];
}
//MARK:--右侧按钮点击事件--
- (void)rightClick{
    [[RCIMClient sharedRCIMClient] sendMessage:ConversationType_PRIVATE targetId:@"54" content:[RCTextMessage messageWithContent:@"你好啊，赛利亚"] pushContent:nil pushData:nil success:^(long messageId) {
        
    } error:^(RCErrorCode nErrorCode, long messageId) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _newsArr = [NSMutableArray array];
    [self setLeftButton];
    [self setRightButton];
    
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    [self setTableView];
    // MARK: --设置监听消息--
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
}
- (void)setTableView{
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.conversationListTableView.tableFooterView = TabLeViewFootView;
    self.conversationListTableView.tableHeaderView = self.headerView;
    self.isShowNetworkIndicatorView = YES;
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    [self.conversationListTableView registerNib:[UINib nibWithNibName:@"MineSystemMessageListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSystemMessageListCell"];
}

- (MineMessageHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineMessageHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        __weak typeof(self) mySelf = self;
        _headerView.pushSystemViewConreoller = ^{
            MineSystemVC *chatVC = [[MineSystemVC alloc]init];
            chatVC.dataArr = mySelf.newsArr.copy;
            [mySelf.navigationController pushViewController:chatVC animated:YES];
        };
    }
    return _headerView;
}
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    MineChatDetaialViewController *chatVC = [[MineChatDetaialViewController alloc]init];
    chatVC.title = model.conversationTitle;
    chatVC.conversationType = model.conversationType;
    chatVC.targetId = model.targetId;
    chatVC.displayUserNameInCell = YES;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [self.navigationController pushViewController:chatVC animated:YES];
    
}
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
    __weak typeof(self) weakSelf = self;
    [dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RCConversationModel *model = obj;
        if ([model.targetId isEqualToString:@"wyxqAdministrator"]) {
            [weakSelf.newsArr addObject:model];
            [dataSource removeObject:model];
        }
    }];
    return dataSource;
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
