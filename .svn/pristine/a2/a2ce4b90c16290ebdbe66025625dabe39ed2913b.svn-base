//
//  MusicFoundFriendsView.m
//  ArtStar
//
//  Created by abc on 6/4/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicFoundFriendsView.h"
#import "MusicFriendsInfoView.h"

@interface MusicFoundFriendsView ()

@property (nonatomic,strong) MusicFriendsInfoView *topView;
@property (nonatomic,strong) MusicFriendsInfoView *lowView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger count;

@end

@implementation MusicFriendsInfoViewModel
@end

@implementation MusicFoundFriendsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _count = 0;
        [self createData];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.lowView.hidden = NO;
    [self bringSubviewToFront:self.topView];

}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[MusicFriendsInfoView alloc]initWithFrame:self.bounds];
        _topView.model = _dataArr[_count];
        __weak typeof(self) mySelf = self;
        _topView.finishAnimalShowView = ^{
            [mySelf bringSubviewToFront:mySelf.lowView];
            if (mySelf.count + 1< mySelf.dataArr.count) {
                mySelf.topView.model = mySelf.dataArr[mySelf.count + 1];
                mySelf.topView.frame = mySelf.bounds;
                mySelf.count++;
            }else{
                mySelf.count = 0;
            }
        };
        [self addSubview:_topView];
    }
    return _topView;
}
- (UIView *)lowView{
    if (!_lowView) {
        _lowView = [[MusicFriendsInfoView alloc]initWithFrame:self.bounds];
        _lowView.model = _dataArr[_count];
        __weak typeof(self) mySelf = self;
        _lowView.finishAnimalShowView = ^{
            [mySelf bringSubviewToFront:mySelf.topView];
            if (mySelf.count + 1 < mySelf.dataArr.count) {
                mySelf.lowView.model = mySelf.dataArr[mySelf.count + 1];
                mySelf.lowView.frame = mySelf.bounds;
                mySelf.count++;
            }else{
                mySelf.count = 0;
            }
        };
        _count ++;
        [self addSubview:_lowView];
    }
    return _lowView;
}

- (void)createData{
    _dataArr = [NSMutableArray array];
    NSArray *imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891980&di=c358fbda2eedf184af60d94c5b63fd9c&imgtype=0&src=http%3A%2F%2Fimage08.71.net%2Fimage08%2F85%2F89%2F46%2F30%2Fe7484b5d-59c8-47ca-8dbd-70b4192d1110.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891980&di=1acdd7e29565fd755782a930a3c31dbc&imgtype=0&src=http%3A%2F%2Fimg.99114.com%2Fgroup1%2FM00%2F2F%2F2B%2FwKgGTFkXGFCAN2TwAAHbHUhsqNM669.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891979&di=c4b937327f4c546caa69d6993b0c74de&imgtype=0&src=http%3A%2F%2Fimage05.71.net%2Fimage05%2F63%2F68%2F76%2F79%2F61cd298e-880f-44fc-9845-443e2c5f35c3.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891978&di=ae45dcf2e9b9afa17a5ce32132c833cb&imgtype=0&src=http%3A%2F%2Fwd.geilicdn.com%2Fvshop207368590-1415273249-574792.jpg%3Fw%3D1080%26h%3D1080",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891975&di=5937ea2da81579045d58c0042c1ae159&imgtype=0&src=http%3A%2F%2Fimage03.71.net%2Fimage03%2F27%2F72%2F28%2F10%2F47de7b0c-1716-469f-a639-937bcf1cae16.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891974&di=b10921e7ad6da8d872ab62b5fa520794&imgtype=0&src=http%3A%2F%2Fa.vpimg3.com%2Fupload%2Fmerchandise%2Fpdcvis%2F2017%2F10%2F14%2F148%2F046cc962-0b6b-4704-a034-b324e6e23bdb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891974&di=b4ad965fcd5e0593814fd3262cb15986&imgtype=0&src=http%3A%2F%2Fimg002.hc360.cn%2Fk1%2FM0B%2FED%2F7C%2FwKhQw1fRAOyEdPmMAAAAAHXPpFo274.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891973&di=2edc946692ebdd6607c859a00d1093df&imgtype=0&src=http%3A%2F%2Fimg10.360buyimg.com%2Fimgzone%2Fjfs%2Ft1996%2F147%2F886257252%2F310011%2F66715823%2F563170caN3fd85456.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891973&di=268da25deec2213ced728ebfa9f12dcf&imgtype=0&src=http%3A%2F%2Fimage07.71.net%2Fimage07%2F91%2F77%2F65%2F18%2F6e64f1f4-48c9-4bd6-92c3-a128ee142723.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528265891971&di=ed2ecd021b40ff5d6fe3f50093aec46c&imgtype=0&src=http%3A%2F%2Fcbu01.alicdn.com%2Fimg%2Fibank%2F2015%2F761%2F825%2F2072528167_1971460346.jpg"];
    for (int i = 0; i < 10; i++) {
        MusicFriendsInfoViewModel *model = [MusicFriendsInfoViewModel new];
        model.image = imageArr[i];
        model.name = [NSString stringWithFormat:@"这是第%d个",i];
        model.age = [NSString stringWithFormat:@"%d",arc4random_uniform(50)];
        [_dataArr addObject:model];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
