//
//  MyselfWordWorksView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordWorksView.h"
#import "MyselfWordWorksCell.h"
#import "MyselfWordWorksUploadingCell.h"

@interface MyselfWordWorksView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectView;
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation MyselfWordWorksView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self)) collectionViewLayout:_layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self addSubview:_collectView];
    
    [_collectView registerNib:[UINib nibWithNibName:@"MyselfWordWorksCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyselfWordWorksCell"];
    [_collectView registerNib:[UINib nibWithNibName:@"MyselfWordWorksUploadingCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MyselfWordWorksUploadingCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _dataArr.count - 1) {
        MyselfWordWorksUploadingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyselfWordWorksUploadingCell" forIndexPath:indexPath];
        return cell;
    }else{
        MyselfWordWorksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyselfWordWorksCell" forIndexPath:indexPath];
        cell.layer.contentsScale = [UIScreen mainScreen].scale;
        cell.layer.shadowOpacity = 0.75f;
        cell.layer.shadowRadius = 4.0f;
        cell.layer.shadowOffset = CGSizeMake(0,0);
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
        cell.layer.shouldRasterize = YES;
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _dataArr.count - 1) {
        if (self.pushUploadingVC) {
            self.pushUploadingVC();
        }
    }else{
        if (self.pushDetaialVIewController) {
            self.pushDetaialVIewController();
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ViewWidth(self) - 45)/2, (ViewWidth(self) - 45)/2/330*440 + 44);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 15, 20, 15);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
