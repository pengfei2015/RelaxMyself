//
//  PFReadTableViewCell.h
//  简
//
//  Created by 温鹏飞 on 15/12/15.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFReadDetailListModel;

@interface PFReadDetailCell : UITableViewCell

@property (nonatomic, strong) PFReadDetailListModel *article;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
