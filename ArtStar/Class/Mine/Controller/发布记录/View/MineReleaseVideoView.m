//
//  MineReleaseVideoView.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleaseVideoView.h"
#import "MineReleaseVideoTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface MineReleaseVideoView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,MineReleaseVideoTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSMutableArray *dataArr;
/**
 选择以及删除弹窗
 */
@property (nonatomic,strong) MineTalentLowEditView *editView;
@property (nonatomic,copy) NSMutableArray *cellArr;

@end

@implementation MineReleaseVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = [NSMutableArray array];
        _cellArr = [NSMutableArray array];
        [self createData];
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 150;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf createData];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf createData];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineReleaseVideoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineReleaseVideoTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineReleaseVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineReleaseVideoTableViewCell"];
    cell.delegate = self;
    if (_isEditCell == YES) {
        cell.viewWidth.constant = 30;
        cell.deleteBtu.hidden = NO;
        [_cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ((NSInteger)obj == cell.ID) {
                [cell.deleteBtu setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
                *stop = YES;
            }
        }];
    }else{
        cell.viewWidth.constant = 0;
        cell.deleteBtu.hidden = YES;
    }
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        NSString *timeStr = [[dic[@"createTime"] componentsSeparatedByString:@" "] firstObject];
        NSArray *timeArr = [timeStr componentsSeparatedByString:@"-"];
        cell.dayLab.text = [NSString stringWithFormat:@"%@",timeArr[2]];
        cell.mouthLab.text = [NSString stringWithFormat:@"%@月",timeArr[1]];
        cell.locationLab.text = dic[@"location"];
        NSArray *imageArr = dic[@"imageUrl"];
        dispatch_queue_t alentQueue = dispatch_queue_create("请求视频", DISPATCH_QUEUE_CONCURRENT);
        dispatch_sync(alentQueue, ^{
            cell.topImage.image = [self thumbnailImageForVideo:[NSURL URLWithString:[imageArr firstObject]]];
        });
        NSData *strData = [dic[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
        NSString *str = dataArr[0];
        for (int i = 1; i < dataArr.count; i++) {
            str = [NSString stringWithFormat:@"%@%@",str,dataArr[i]];
        }
        cell.detailLab.text = str;
        cell.ID = [dic[@"rfmId"] integerValue];
    }
    return cell;
}
// MARK: --MineReleaseVideoTableViewCellDelegate--
- (void)sendDeleteIDtoView:(NSInteger)ID style:(NSInteger)style{
    switch (style) {
        case 0:
            [_cellArr addObject:@(ID)];
            break;
        default:
            [_cellArr removeObject:@(ID)];
            break;
    }
}
- (void)setIsEditCell:(BOOL)isEditCell{
    _isEditCell = isEditCell;
    if (isEditCell == YES) {
        self.editView.hidden = NO;
    }else{
        self.editView.hidden = YES;
    }
    [_listView reloadData];
}
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD bwm_showHUDAddedTo:self title:@"正在加载..." animated:YES];
    dispatch_queue_t alentQueue = dispatch_queue_create("请求记录", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(alentQueue, ^{
        [KGRequestNetWorking postWothUrl:seachIssueRecord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"issueType":@"2",@"irQuery":@{@"page":@(weakSelf.page),@"rows":@"15"}} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
            if ([result[@"code"] integerValue] == 200) {
                NSArray *tmp = result[@"data"];
                if (tmp.count > 0) {
                    [weakSelf.dataArr addObjectsFromArray:tmp];
                }
                [weakSelf.listView.mj_header endRefreshing];
                [weakSelf.listView.mj_footer endRefreshing];
                [weakSelf.listView reloadData];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        }];
    });
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
- (UIImage *)thumbnailImageForVideo:(NSURL *)video{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:video options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *error = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&error];
    if (!thumbnailImageRef) {
        NSLog(@"%@",error);
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}
// MARK: --选择以及删除弹窗--
- (MineTalentLowEditView *)editView{
    if (!_editView) {
        _editView = [[MineTalentLowEditView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 50, kScreenWidth, 50)];
        _editView.title = @"全选";
        _editView.detailStr = @"删除";
        _editView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        // !!!: --点击全选按钮，选中所有--
        _editView.chooseAllCell = ^(NSString *clear) {
            [weakSelf.cellArr removeAllObjects];
            if ([clear isEqualToString:@"全选"]) {
                [weakSelf.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic = obj;
                    [weakSelf.cellArr addObject:@([dic[@"id"] integerValue])];
                }];
            }else{
                [weakSelf.listView reloadData];
            }
        };
        // !!!: --取消审核还是删除审核通过--
        _editView.deleteChooseCell = ^(NSString *deleteStr) {
            
        };
        [self insertSubview:_editView atIndex:99];
    }
    return _editView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
