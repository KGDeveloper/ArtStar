//
//  ReadBooksView.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ReadBooksView.h"
#import "ReadIngRecommendView.h"
#import "ReadBooksCell.h"


@interface ReadBooksView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation ReadBooksView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.rowHeight = 155;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"ReadBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReadBooksCell"];
}

- (UIView *)setTableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 510)];
    _headerView.backgroundColor = Color_fafafa;
    
    ReadIngRecommendView *recommendView = [[ReadIngRecommendView alloc]initWithFrame:CGRectMake(0, 10, ViewWidth(self), 245)];
    recommendView.backgroundColor = [UIColor whiteColor];
    recommendView.titleStr = @"今日推荐";
    __weak typeof(self) mySelf = self;
    recommendView.pushReadBooskHotVC = ^{
        if (mySelf.pushVC) {
            mySelf.pushVC();
        }
    };
    recommendView.bookArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194178353&di=19d68e46115332e5abb8a86e46f9b9ec&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2735078535%2C525447672%26fm%3D214%26gp%3D0.jpg",@"name":@"神魔列国志"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194210710&di=c721427599d77d6bb305eee846a4c03e&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4039423581%2C996604435%26fm%3D214%26gp%3D0.jpg",@"name":@"严凤英之死"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194247911&di=e5f6f69fcfcc117e9a9501d86c77bbe5&imgtype=jpg&src=http%3A%2F%2Fwww.dawenxue.org%2Ffiles%2Farticle%2Fimage%2F426%2F426314%2F426314s.jpg",@"name":@"大宋中兴演绎"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194178353&di=19d68e46115332e5abb8a86e46f9b9ec&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2735078535%2C525447672%26fm%3D214%26gp%3D0.jpg",@"name":@"神魔列国志"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194210710&di=c721427599d77d6bb305eee846a4c03e&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4039423581%2C996604435%26fm%3D214%26gp%3D0.jpg",@"name":@"严凤英之死"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194247911&di=e5f6f69fcfcc117e9a9501d86c77bbe5&imgtype=jpg&src=http%3A%2F%2Fwww.dawenxue.org%2Ffiles%2Farticle%2Fimage%2F426%2F426314%2F426314s.jpg",@"name":@"大宋中兴演绎"}];
    [_headerView addSubview:recommendView];
    
    ReadIngRecommendView *hotView = [[ReadIngRecommendView alloc]initWithFrame:CGRectMake(0, 255, ViewWidth(self), 245)];
    hotView.backgroundColor = [UIColor whiteColor];
    hotView.titleStr = @"畅销图书榜";
    hotView.pushReadBooskHotVC = ^{
        if (mySelf.pushVC) {
            mySelf.pushVC();
        }
    };
    hotView.bookArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194178353&di=19d68e46115332e5abb8a86e46f9b9ec&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2735078535%2C525447672%26fm%3D214%26gp%3D0.jpg",@"name":@"神魔列国志"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194210710&di=c721427599d77d6bb305eee846a4c03e&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4039423581%2C996604435%26fm%3D214%26gp%3D0.jpg",@"name":@"严凤英之死"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194247911&di=e5f6f69fcfcc117e9a9501d86c77bbe5&imgtype=jpg&src=http%3A%2F%2Fwww.dawenxue.org%2Ffiles%2Farticle%2Fimage%2F426%2F426314%2F426314s.jpg",@"name":@"大宋中兴演绎"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194178353&di=19d68e46115332e5abb8a86e46f9b9ec&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2735078535%2C525447672%26fm%3D214%26gp%3D0.jpg",@"name":@"神魔列国志"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194210710&di=c721427599d77d6bb305eee846a4c03e&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D4039423581%2C996604435%26fm%3D214%26gp%3D0.jpg",@"name":@"严凤英之死"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528194247911&di=e5f6f69fcfcc117e9a9501d86c77bbe5&imgtype=jpg&src=http%3A%2F%2Fwww.dawenxue.org%2Ffiles%2Farticle%2Fimage%2F426%2F426314%2F426314s.jpg",@"name":@"大宋中兴演绎"}];
    [_headerView addSubview:hotView];
    
    UIView *labView = [[UIView alloc]initWithFrame:CGRectMake(0, 500, ViewWidth(self), 50)];
    labView.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:labView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ViewWidth(labView) - 30, 15)];
    titleLab.text = @"你可能感兴趣的";
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(14);
    [labView addSubview:titleLab];
    
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadBooksCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.reloadBookDetaial) {
        self.reloadBookDetaial();
    }
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
