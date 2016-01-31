//
//  PFReadTableViewCell.m
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "PFReadDetailCell.h"
#import "PFReadDetailListModel.h"
#import "UIImageView+WebCache.h"

#define MARGIN 20
@interface PFReadDetailCell ()

@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *detailLab;
@end
@implementation PFReadDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PFReadDetailCell";
    PFReadDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PFReadDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = PFRGB(220, 231, 219);
        
        UILabel *titleLab =[[UILabel alloc] init];
        titleLab.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.numberOfLines = 0;
        detailLab.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:detailLab];
        self.detailLab = detailLab;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleX = MARGIN;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - MARGIN * 2;
    CGFloat titleH = 30;
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    
    CGFloat iconX = MARGIN;
    CGFloat iconY = CGRectGetMaxY(self.titleLab.frame);
    CGFloat iconW = 180;
    CGFloat iconH = self.height - MARGIN - iconY;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    if (self.article.coverimg.length > 0) {
        [self.iconView setImageWithURL:[NSURL URLWithString:_article.coverimg] placeholderImage:[UIImage imageNamed:@"bomimg"]];
    }else if (self.article.firstimage.length > 0){
        [self.iconView setImageWithURL:[NSURL URLWithString:_article.firstimage] placeholderImage:[UIImage imageNamed:@"bomimg"]];
    }else{
        self.iconView.frame = CGRectMake(0, 0, 0, 0);
    }

    CGFloat detailX = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat detailY = CGRectGetMaxY(self.titleLab.frame);
    CGFloat detailW = self.width - detailX - MARGIN;
    CGFloat detailH = self.height - MARGIN - detailY;
    self.detailLab.frame = CGRectMake(detailX, detailY, detailW, detailH);
}

- (void)setArticle:(PFReadDetailListModel *)article
{
    _article = article;
    
    self.titleLab.text = article.title;
    if (article.content.length > 0) {
        self.detailLab.text = article.content;
    }else if (article.shortcontent.length > 0){
        self.detailLab.text = article.shortcontent;
    }else{
        self.detailLab.text = nil;
    }
    
    
}
@end
