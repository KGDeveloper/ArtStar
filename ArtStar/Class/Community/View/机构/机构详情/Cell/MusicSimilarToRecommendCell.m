//
//  MusicSimilarToRecommendCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicSimilarToRecommendCell.h"
#import "MusicExhibitTableViewCell.h"

@interface MusicSimilarToRecommendCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation MusicSimilarToRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    _titleLab = [UILabel new];
    _listView = [UITableView new];
    
    [self.contentView sd_addSubviews:@[_titleLab,_listView]];
    
    _titleLab.text = @"同类推荐";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).heightIs(15);
    
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 115;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 15).heightIs(345);
    
    [_listView registerClass:[MusicExhibitTableViewCell class] forCellReuseIdentifier:@"MusicExhibitTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicExhibitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicExhibitTableViewCell"];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
