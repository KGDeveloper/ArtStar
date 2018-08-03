//
//  MineWorksIndustryView.m
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineWorksIndustryView.h"
#import "KGCityChooseCell.h"

@interface MineWorksIndustryView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *oneListView;
@property (nonatomic,strong) UITableView *twoListView;
@property (nonatomic,strong) UITableView *threeListView;

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) NSMutableArray *firstArr;
@property (nonatomic,strong) NSMutableArray *secondArr;
@property (nonatomic,strong) NSMutableArray *thirdArr;

@property (nonatomic,assign) BOOL isWorks;
@property (nonatomic,copy) NSString *indutryStr;
@property (nonatomic,copy) NSString *positionStr;
@property (nonatomic,copy) NSString *jobStr;

@property (nonatomic,strong) UIButton *cancelBtu;

@property (nonatomic,copy) NSString *worksName;
@property (nonatomic,copy) NSString *worksID;

@end

@implementation MineWorksIndustryView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _isWorks = YES;
        [self createFirstArr];
        [self setView];
    }
    return self;
}

- (void)setView{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, ViewWidth(self), ViewHeight(self) - 135)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(0, 0, ViewWidth(self)/4, 40);
    [_leftBtu setTitle:@"文艺爱好者" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(13);
    [_leftBtu addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(self)/4, 0, ViewWidth(self)/4, 40);
    [_rightBtu setTitle:@"文艺工作者" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [_rightBtu addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_rightBtu];
    
    _cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtu.frame = CGRectMake(ViewWidth(self) - 55, 0, 40, 40);
    [_cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _cancelBtu.titleLabel.font = SYFont(13);
    _cancelBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_cancelBtu addTarget:self action:@selector(cancelBtuClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_cancelBtu];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0,38, 64, 2)];
    _line.centerX = _leftBtu.centerX;
    _line.backgroundColor = Color_333333;
    [_backView addSubview:_line];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 40, ViewWidth(self), 1)];
    lowLine.backgroundColor = Color_ededed;
    [_backView addSubview:lowLine];
    
    [self setTheFirstColumn];
    [self setTheSecondColumn];
    [self setTheThirdColumn];
}
- (void)setTheFirstColumn{
    
    _oneListView = [[UITableView alloc]initWithFrame:CGRectMake(0, 41, ViewWidth(self)/3, ViewHeight(_backView) - 41)];
    _oneListView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    _oneListView.delegate = self;
    _oneListView.dataSource = self;
    _oneListView.tableFooterView = TabLeViewFootView;
    _oneListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _oneListView.bounces = NO;
    _oneListView.showsVerticalScrollIndicator = NO;
    _oneListView.showsHorizontalScrollIndicator = NO;
    [_backView addSubview:_oneListView];
    
    [_oneListView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
    
}
- (void)setTheSecondColumn{
    _twoListView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth(self)/3, 41, ViewWidth(self)/3, ViewHeight(_backView) - 41)];
    _twoListView.backgroundColor = [UIColor whiteColor];
    _twoListView.delegate = self;
    _twoListView.dataSource = self;
    _twoListView.tableFooterView = TabLeViewFootView;
    _twoListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _twoListView.bounces = NO;
    _twoListView.showsVerticalScrollIndicator = NO;
    _twoListView.showsHorizontalScrollIndicator = NO;
    [_backView addSubview:_twoListView];
    
    [_twoListView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
}
- (void)setTheThirdColumn{
    _threeListView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth(self)/3*2, 41, ViewWidth(self)/3, ViewHeight(_backView) - 41)];
    _threeListView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    _threeListView.delegate = self;
    _threeListView.dataSource = self;
    _threeListView.tableFooterView = TabLeViewFootView;
    _threeListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _threeListView.bounces = NO;
    _twoListView.showsVerticalScrollIndicator = NO;
    _twoListView.showsHorizontalScrollIndicator = NO;
    [_backView addSubview:_threeListView];
    
    [_threeListView registerNib:[UINib nibWithNibName:@"KGCityChooseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCityChooseCell"];
}
- (void)leftAction{
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _line.centerX = _leftBtu.centerX;
    _isWorks = YES;
    [self createSecondArr:YES key:_firstArr[0]];
}
- (void)rightAction{
    [_leftBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _line.centerX = _rightBtu.centerX;
    _isWorks = NO;
    [self createSecondArr:NO key:_firstArr[0]];
}
- (void)cancelBtuClick{
    if ([_cancelBtu.currentTitle isEqualToString:@"确定"]) {
        if (self.sendChooseworks) {
            self.sendChooseworks(_worksName, _worksID);
        }
    }
    self.hidden = YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _oneListView) {
        return _firstArr.count;
    }else if (tableView == _twoListView){
        return _secondArr.count;
    }else{
        return _thirdArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _oneListView) {
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewNormalBackView:cell.frame];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.titleLab.text = _firstArr[indexPath.row];
        return cell;
    }else if (tableView == _twoListView){
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLab.text = _secondArr[indexPath.row];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:CGRectMake(ViewX(cell), ViewY(cell), ViewWidth(cell), ViewHeight(cell) - 1)];
        return cell;
    }else{
        KGCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCityChooseCell"];
        cell.backgroundView = [self tableViewWhiteBackView:cell.frame];
        cell.titleLab.text = _thirdArr[indexPath.row];
        cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _oneListView) {
        _indutryStr = _firstArr[indexPath.row];
        [self createSecondArr:_isWorks key:_indutryStr];
    }else if (tableView == _twoListView ){
        _positionStr = _secondArr[indexPath.row];
        _worksName = _secondArr[indexPath.row];
        _worksID = [self returnIdWithFirstKey:_indutryStr sencedKey:_positionStr thirdKey:nil status:_isWorks];
        [self createThriedArr:_isWorks title:_indutryStr key:_positionStr];
    }else{
        _jobStr = _thirdArr[indexPath.row];
        _worksName = _thirdArr[indexPath.row];
        _worksID = [self returnIdWithFirstKey:_indutryStr sencedKey:_positionStr thirdKey:_jobStr status:_isWorks];
    }
}

- (NSString *)returnIdWithFirstKey:(NSString *)first sencedKey:(NSString *)senced thirdKey:(NSString *)third status:(BOOL)status{
    NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
    NSDictionary *typeDic = dic[first];
    NSDictionary *worksDic;
    if (status == YES) {
        worksDic = typeDic[@"工作者"];
    }else{
        worksDic = typeDic[@"兴趣爱好"];
    }
    NSDictionary *dataDic = worksDic[@"data"];
    NSDictionary *sencDic = dataDic[senced];
    if (third == nil) {
        return sencDic[@"id"];
    }else{
        NSDictionary *thDic = sencDic[@"data"];
        NSDictionary *endDic = thDic[third];
        return endDic[@"id"];
    }
}

- (UIView *)tableViewWhiteBackView:(CGRect)frame{
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}
- (UIView *)tableViewNormalBackView:(CGRect)frame{
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    return backView;
}

- (void)createFirstArr{
    NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
    _firstArr = [NSMutableArray arrayWithArray:dic.allKeys];
    [self createSecondArr:YES key:_firstArr[0]];
    [self createThriedArr:YES title:_firstArr[0] key:_secondArr[1]];
}

- (void)createSecondArr:(BOOL)status key:(NSString *)key{
    if (status == YES) {
        NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
        NSDictionary *typeDic = dic[key];
        NSDictionary *worksDic = typeDic[@"工作者"];
        NSDictionary *dataDic = worksDic[@"data"];
        _secondArr = [NSMutableArray arrayWithArray:dataDic.allKeys];
        [self createThriedArr:status title:key key:_secondArr[0]];
    }else{
        NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
        NSDictionary *typeDic = dic[key];
        NSDictionary *worksDic = typeDic[@"兴趣爱好"];
        NSDictionary *dataDic = worksDic[@"data"];
        _secondArr = [NSMutableArray arrayWithArray:dataDic.allKeys];
        [self createThriedArr:status title:key key:_secondArr[0]];
    }
    [_twoListView reloadData];
}

- (void)createThriedArr:(BOOL)status title:(NSString *)title key:(NSString *)key{
    if (status == YES) {
        NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
        NSDictionary *typeDic = dic[title];
        NSDictionary *worksDic = typeDic[@"工作者"];
        NSDictionary *detiaDic = worksDic[@"data"];
        NSDictionary *dataDic = detiaDic[key];
        NSDictionary *endDic = dataDic[@"data"];
        _thirdArr = [NSMutableArray arrayWithArray:endDic.allKeys];
    }else{
        NSString *fileUlr = [[NSBundle mainBundle] pathForResource:@"KGIndustryPlist" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileUlr];
        NSDictionary *typeDic = dic[title];
        NSDictionary *worksDic = typeDic[@"兴趣爱好"];
        NSDictionary *detiaDic = worksDic[@"data"];
        NSDictionary *dataDic = detiaDic[key];
        NSDictionary *endDic = dataDic[@"data"];
        _thirdArr = [NSMutableArray arrayWithArray:endDic.allKeys];
    }
    [_threeListView reloadData];
}

- (void)setStatus:(NSString *)status{
    _status = status;
    if ([status isEqualToString:@"不显示"]) {
        _cancelBtu.hidden = YES;
        _backView.frame = CGRectMake(0, 0, ViewWidth(self), ViewHeight(self));
    }
}

- (void)setCancelStr:(NSString *)cancelStr{
    _cancelStr = cancelStr;
    [_cancelBtu setTitle:cancelStr forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
