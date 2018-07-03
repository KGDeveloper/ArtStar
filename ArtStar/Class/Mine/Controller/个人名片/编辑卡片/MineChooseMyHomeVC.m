
//
//  MineChooseMyHomeVC.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChooseMyHomeVC.h"
#import "MineChooseMyHomeCell.h"

@interface MineChooseMyHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *cityView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *countryArr;
@property (nonatomic,strong) NSMutableArray *provinceArr;
@property (nonatomic,strong) NSMutableArray *cityArr;
@property (nonatomic,strong) NSMutableArray *areaArr;

@property (nonatomic,assign) BOOL isCountry;
@property (nonatomic,assign) BOOL isProvince;
@property (nonatomic,assign) BOOL isCity;
@property (nonatomic,assign) BOOL isArea;

@property (nonatomic,copy) NSString *countryStr;
@property (nonatomic,copy) NSString *provinceStr;
@property (nonatomic,copy) NSString *cityStr;

@end

@implementation MineChooseMyHomeVC

- (void)leftNavBtuAction:(UIButton *)sender{
    if (_isCountry == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (_isProvince == YES) {
        _isCountry = YES;
        _isProvince = NO;
        _dataArr = _countryArr.copy;
        [_cityView reloadData];
        [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"家乡" image:Image(@"back")];
    }
    if (_isCity == YES) {
        _isProvince = YES;
        _isCity = NO;
        _dataArr = _provinceArr.copy;
        [_cityView reloadData];
        [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"中国" image:Image(@"back")];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"家乡" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"确定" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    _countryArr = [NSMutableArray array];
    _provinceArr = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _areaArr = [NSMutableArray array];
    
    _isCountry = YES;
    _isProvince = NO;
    _isCity = NO;
    _isArea = NO;
    
    [self createData];
    [self setTableView];
}

- (void)setTableView{
    _cityView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _cityView.delegate = self;
    _cityView.dataSource = self;
    _cityView.rowHeight = 45;
    _cityView.tableFooterView = TabLeViewFootView;
    _cityView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cityView];
    
    [_cityView registerNib:[UINib nibWithNibName:@"MineChooseMyHomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineChooseMyHomeCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineChooseMyHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineChooseMyHomeCell"];
    if (_isCountry == YES) {
        if ([_dataArr[indexPath.row] isEqualToString:@"中国"]) {
            cell.openImage.hidden = NO;
        }else{
            cell.openImage.hidden = YES;
        }
    }
    if (_isProvince == YES) {
        cell.openImage.hidden = NO;
    }
    if (_isCity == YES) {
        cell.openImage.hidden = YES;
    }
    cell.titleLab.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isCity == YES) {
        _cityStr = _dataArr[indexPath.row];
    }
    if (_isProvince == YES) {
        _isProvince = NO;
        _isCity = YES;
        _provinceStr = _dataArr[indexPath.row];
        NSArray *arr = [KGCity cityWithprovince:_dataArr[indexPath.row]];
        [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:_dataArr[indexPath.row] image:Image(@"back")];
        for (NSDictionary *dic in arr) {
            NSArray *city = dic.allKeys;
            _cityArr = [NSMutableArray arrayWithArray:city];
            _dataArr = _cityArr.copy;
            [_cityView reloadData];
        }
    }
    if (_isCountry == YES) {
        _countryStr = _dataArr[indexPath.row];
        if ([_dataArr[indexPath.row] isEqualToString:@"中国"]) {
            _isCountry = NO;
            _isProvince = YES;
            _dataArr = _provinceArr.copy;
            [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"中国" image:Image(@"back")];
            [_cityView reloadData];
        }
    }
}

- (void)createData{
    
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *arr = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in arr) {
        NSString *countryName = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [_countryArr addObject:countryName];
    }
    _dataArr = _countryArr.copy;
    [_cityView reloadData];
    
    _provinceArr = [NSMutableArray arrayWithArray:[KGCity province]];

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
