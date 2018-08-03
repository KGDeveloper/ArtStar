//
//  MusicThemeView.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicThemeView.h"
#import "MusicThemeMyThemeCell.h"

@interface MusicThemeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;

@end

@implementation MusicThemeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setView];
    }
    return self;
}

- (void)setView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableHeaderView = [self tableViewHeaderView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicThemeMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicThemeMyThemeCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FriendsButtomImageTopLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsButtomImageTopLabelCell"];
}
//MARK:---------------------------------------创建头视图------------------------------------------
- (UIView *)tableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self),ViewWidth(self)/750*500 + 50)];
    _headerView.backgroundColor = Color_fafafa;
    
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_headerView), ViewHeight(_headerView) - 10) style:HeaderStyleHeadLines];
    _pageView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 140;
    }else{
        return 58 + 55 + photoViewHeight + 115 + 10 + 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
        MusicThemeMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicThemeMyThemeCell"];
        cell.themeArr = @[@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640369&di=903a99d98547a695c786e3718b1c9a02&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151016%2F258164-15101609241916.jpg",@"name":@"这是一个小狗"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640369&di=8f3266cf5947806adaabf568802d12b6&imgtype=0&src=http%3A%2F%2Fpic42.photophoto.cn%2F20170201%2F1155116821643442_b.jpg",@"name":@"哇，瓢虫"},@{@"image":@"",@"name":@""},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640369&di=c116d5e5ffc94acd9d5a6d627da85e35&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151214%2F258052-15121405593069.jpg",@"name":@"傻鸟"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640368&di=d53e3f37caa107249f37cc3a80f8a6e1&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F131213%2F259971-131213213A114.jpg",@"name":@"绿衣服的大象"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640367&di=a76963382f721e8746224da3b4c4642a&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151103%2F258121-15110315561382.jpg",@"name":@"鹰头小眼神"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640367&di=aaead6d97ff11f82c77d99edea015594&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151214%2F258052-151214061A055.jpg",@"name":@"圣诞鸟"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640364&di=5afc4e1cc21028d1cfdada87f6f16a19&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151016%2F258164-151016091I962.jpg",@"name":@"国王狗"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640364&di=e525fa35b17a0c197e6529aa57f36300&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151214%2F258052-1512140HR770.jpg",@"name":@"狼图腾"},@{@"image":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527684640361&di=8de71d47cc2cd3550a6b4aead84a079b&imgtype=0&src=http%3A%2F%2Fpic36.photophoto.cn%2F20150721%2F1155115613576871_b.jpg",@"name":@"大老虎"}];
        return cell;
//    }else{
//        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
//        cell.delegate = self;
//        [cell showGraphic];
//        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
//        return cell;
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.pushViewController) {
            self.pushViewController();
        }
    }
}
//MARK:--横排文字改变排版--
- (UITextView *)changeTextViewLineSpace:(UITextView *)textView string:(NSString *)text alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(12),NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
