//
//  NewsCell.h
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/17.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

typedef void(^CellClick)();

@interface NewsCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *contentImageView;
@property (nonatomic ,strong) UIButton *playBtn;
@property (nonatomic,strong) UILabel *gifLable;
@property (nonatomic,copy) CellClick cellClick;
@property (nonatomic,strong) NewsModel *model;
@property (nonatomic,strong) UILabel *longPicLable;

@property (nonatomic,assign) float cellHeight;
@end
