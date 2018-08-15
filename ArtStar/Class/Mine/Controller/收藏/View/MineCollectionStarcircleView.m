//
//  MineCollectionStarcircleView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionStarcircleView.h"
#import "MineCollectionStarCircleTableViewCell.h"

@interface MineCollectionStarcircleView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineCollectionStarcircleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _dataArr = [NSMutableArray array];
        [self createData];
        [self setTableView];
    }
    return self;
}
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 165;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionStarCircleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionStarCircleTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionStarCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionStarCircleTableViewCell"];
    
    /*
     @property (weak, nonatomic) IBOutlet UIImageView *headImage;
     @property (weak, nonatomic) IBOutlet UILabel *nameLab;
     @property (weak, nonatomic) IBOutlet UIImageView *topImage;
     @property (weak, nonatomic) IBOutlet UILabel *detailLab;
     @property (weak, nonatomic) IBOutlet UILabel *timeLab;
     @property (weak, nonatomic) IBOutlet NSLayoutConstraint *topWidth;
     */
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
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequestNetWorking postWothUrl:seachPersonCollect parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"collectType":@"2",@"pcquery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
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
