//
//  MusicExhibitCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicExhibitCell.h"
#import "MusicExhibitTableViewCell.h"

@interface MusicExhibitCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation MusicExhibitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _listView = [UITableView new];
    _titleLab = [UILabel new];
    
    [self.contentView sd_addSubviews:@[_listView,_titleLab]];
    
    _titleLab.text = @"相关展览";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = 115;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 15).heightIs(460);
    
    [_listView registerClass:[MusicExhibitTableViewCell class] forCellReuseIdentifier:@"MusicExhibitTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicExhibitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicExhibitTableViewCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.dataDic = dic;
    }
    return cell;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [_listView reloadData];
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
