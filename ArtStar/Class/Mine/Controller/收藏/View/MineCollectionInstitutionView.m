//
//  MineCollectionInstitutionView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionInstitutionView.h"
#import "MineCollectionInstitutionViewCell.h"


@interface MineCollectionInstitutionView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineCollectionInstitutionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createData];
        [self setTableView];
    }
    return self;
}
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.rowHeight = 130;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionInstitutionViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionInstitutionViewCell"];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    deleteAction.backgroundColor = Color_333333;
    return @[deleteAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionInstitutionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionInstitutionViewCell"];
    return cell;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

- (void)createData{
    [KGRequestNetWorking postWothUrl:seachPersonCollect parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"collectType":@"0",@"pcquery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            
        }
    } fail:^(NSError *error) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
