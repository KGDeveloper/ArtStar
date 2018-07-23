//
//  MineCollectionBookView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionBookView.h"
#import "MineCollectionBookTableViewCell.h"

@interface MineCollectionBookView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineCollectionBookView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
    _listView.rowHeight = 180;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionBookTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionBookTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionBookTableViewCell"];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
