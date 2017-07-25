//
//  NewsCell.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/17.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "NewsCell.h"
#import "YYPhotoGroupView.h"
#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"] || [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)?YES:NO
@interface NewsCell()


@end
@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
//        self.backgroundColor = [UIColor randomFlatColor];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _longPicLable = [UILabel new];
        _longPicLable.text = @"长图";
        _longPicLable.textColor = [UIColor whiteColor];
        _longPicLable.font = [UIFont fontWithName:@"Arial"  size:14];
        _longPicLable.textAlignment = NSTextAlignmentCenter;
        _longPicLable.backgroundColor = [UIColor darkGrayColor];
        _longPicLable.layer.cornerRadius = 5;
        _longPicLable.layer.masksToBounds = YES;
        _longPicLable.frame = CGRectMake(_contentImageView.width, _contentImageView.height, 40, 17);
        
        _gifLable = [[UILabel alloc] init];
        _gifLable.numberOfLines = 0;
        _gifLable.textColor = [UIColor whiteColor];
        _gifLable.layer.cornerRadius = 5;
        _gifLable.textAlignment = NSTextAlignmentCenter;
        _gifLable.layer.masksToBounds = YES;
        _gifLable.font = [UIFont fontWithName:@"Arial"  size:14];
//        _gifLable.backgroundColor = rgba(115, 149, 189, 1);
        _gifLable.backgroundColor = [UIColor darkGrayColor];
        [_contentImageView addSubview:_gifLable];
        
        
        _headImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_headImageView];
        
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(10);
            make.top.offset(10);
            make.size.mas_equalTo(CGSizeMake(36, 36));
            
        }];
//        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.right + 5, 13, kScreenWidth - _headImageView.width - 5, 13)];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.mas_right);
            make.left.equalTo(_headImageView.mas_right).with.offset(10);
            make.top.equalTo(_headImageView.mas_top).offset(0);
            
        }];
        
//        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.right + 5, _nameLabel.bottom + 5, kScreenWidth - _headImageView.width - 5, 18)];
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.numberOfLines = 10;
        [self.contentView addSubview:_timeLabel];
//
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        }];
        
//        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, _headImageView.bottom + 5, kScreenWidth - 26, 20)];
        _contentLabel = [[UILabel alloc]init];
//
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
//
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_left);
            make.top.equalTo(_headImageView.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
        }];
//
    
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_contentImageView];
        
        [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_left);
            make.top.equalTo(_contentLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth-10, 150));
        }];
        
        
        self.playBtn = [[UIButton alloc] init];

        
        
    }
    return self;
}

- (void)playBtnAction{
    
    _cellClick();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (void)setModel:(NewsModel *)model{
    _model = model;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
    _nameLabel.text = model.name;
    _timeLabel.text = model.created_at;
    _contentLabel.text = model.text;
    NSDictionary *attrs = @{NSFontAttributeName:_contentLabel.font};
    
    CGSize maxSize = CGSizeMake(kScreenWidth - 35 , MAXFLOAT);
    
    CGSize size = [_contentLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    NSLog(@"%f ->%f",size.height,size.width);
    
    _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, kScreenWidth - 35, size.height);
    
    _contentLabel.font = [UIFont fontWithName:@"Arial" size:16];
    _contentLabel.numberOfLines = 0;

//    NSLog(@"%f",_contentLabel.bottom);
    
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:_model.image0]];
    
    if (!_model.image0) {
        [_contentImageView setHidden:YES];
    }else{
        [_contentImageView setHidden:NO];
        
        if ([_model.height floatValue] > 1500) {
            
            NSURL *url = [NSURL URLWithString:_model.image0];
            
            __weak typeof(self) myself = self;
            
            [_contentImageView sd_setImageWithURL:url
                                 placeholderImage:[UIImage imageNamed:@"hold"]
                                          options:SDWebImageAvoidAutoSetImage
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                            
                                            UIImage *resultImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, kScreenHeight , kScreenHeight))];
                                            myself.contentImageView.image = resultImage;
                                            
                                        }];
            _longPicLable.hidden = NO;
            
            [_contentImageView addSubview:_longPicLable];
            
        }else{
            
                        _longPicLable.hidden = YES;
            if (STRING_ISNIL(_model.gifFistFrame)) {
                [_contentImageView sd_setImageWithURL:[NSURL URLWithString:_model.image0] placeholderImage:[UIImage imageNamed:@"hold"]];
            }else{
                [_contentImageView sd_setImageWithURL:[NSURL URLWithString:_model.gifFistFrame] placeholderImage:[UIImage imageNamed:@"hold"]];
            }
        }
    }

    if (![_model.videouri isEqualToString:@""]) {
        [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(playBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentImageView addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentImageView);
            make.width.height.mas_equalTo(50);
        }];
        
        
    }else {
        [self.playBtn removeFromSuperview];
    }
    
    if ([_model.is_gif boolValue]) {

        _gifLable.hidden = NO;
        _gifLable.text = @"GIF";
        _gifLable.frame = CGRectMake(_contentImageView.left, _contentImageView.top, 30, 17);
        [_contentImageView addSubview:_gifLable];

    }else{
        _gifLable.hidden = YES;
    }
    
    _contentImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_contentImageView addGestureRecognizer:tap];
    
    if (_contentImageView.isHidden) {
        _cellHeight = _contentLabel.bottom + 20;

    }else {
        _cellHeight = _contentLabel.bottom + 170;

    }
    
//    NSLog(@"%.2f",_contentImageView.bottom);

}



- (UIImage *)compressImage:(UIImage *)sourceImage toTargetScale:(CGFloat)scale {
    CGSize imageSize = sourceImage.size;
    CGFloat width    = imageSize.width;
    CGFloat height   = imageSize.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(width * scale, height * scale));
    [sourceImage drawInRect:CGRectMake(0, 0, width * scale, height * scale)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)tapAction{
    
    if (STRING_ISNIL(_model.videouri)) {
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView         = _contentImageView;
        item.largeImageURL     = [NSURL URLWithString:_model.image0];
        YYPhotoGroupView *view = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
        UIView *toView         = [UIApplication sharedApplication].keyWindow.rootViewController.view;
        [view presentFromImageView:_contentImageView
                       toContainer:toView
                          animated:YES completion:nil];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
