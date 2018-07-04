//
//  TalentVC.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "TalentVC.h"
#import "TelentTitleTableViewCell.h"
#import "TlentIntroudceTableViewCell.h"
#import "TalentPushPhotosTableViewCell.h"
#import "YourLocationVC.h"

@interface TalentVC ()<UITableViewDelegate,UITableViewDataSource,TlentIntroudceTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *plholderArr;

@end

@implementation TalentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"我要做达人" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"提交" image:nil];
    self.view.backgroundColor = Color_f2f2f2;
    
    _plholderArr = @[@"请输入标题",@"请输入机构/场所名称",@"请输入地址",@"请输入场所电话(选填)",@"请对你上传的地标做一番介绍吧！"];
    
    [self setTableView];
}

- (void)leftNavBtuAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TelentTitleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TelentTitleTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"TlentIntroudceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TlentIntroudceTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"TalentPushPhotosTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TalentPushPhotosTableViewCell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 4) {
        return 60;
    }else if (indexPath.row == 4){
        return 210;
    }else{
        return 183;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 4) {
        TelentTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TelentTitleTableViewCell"];
        cell.textTF.placeholder = _plholderArr[indexPath.row];
        return cell;
    }else if (indexPath.row == 4){
        TlentIntroudceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TlentIntroudceTableViewCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 5){
        TalentPushPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalentPushPhotosTableViewCell"];
        cell.titleLab.text = @"上传地标专属照片";
        return cell;
    }else{
        TalentPushPhotosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalentPushPhotosTableViewCell"];
        cell.titleLab.text = @"上传小视频(选填)";
        return cell;
    }
}

//MARK:-----------------------------------------TlentIntroudceTableViewCellDelegate-----------------------------------------------
- (void)whereAreYour{
    YourLocationVC *locationVC = [[YourLocationVC alloc]init];
    locationVC.nowLocation = ^(NSString *location) {
        
    };
    [self pushNoTabBarViewController:locationVC animated:YES];
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
