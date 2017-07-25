



//
//  NewsTableView.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "NewsTableView.h"
#import "NewsCell.h"
#import <ZFPlayer.h>
#import <NSObject+YYModel.h>
#import <MJRefresh.h>
#import "HomeRequestApi.h"
#define API @"http://api.budejie.com/api/api_open.php"

@interface NewsTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NewsCell *cell;
@property (nonatomic,strong) ZFPlayerView *playerView;
@end
@implementation NewsTableView

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
//        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
         _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate   = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[NewsCell class] forCellReuseIdentifier:@"cellId"];
        self.estimatedRowHeight = 56;
        self.rowHeight = UITableViewAutomaticDimension;
        [self requestData];
        
         self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        
    }
    return self;
}

- (void)requestData{
    NSDictionary *pragram = @{@"a":@"list",@"c":@"data",@"type":@"1"};

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    [manager POST:API parameters:pragram progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
//            NewsModel *model = [NewsModel new];
//            model = [NewsModel modelWithJSON:dic];
//            [self.dataArray addObject:model];
//        }
//        [self.mj_header endRefreshing];
//        [self reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
    HomeRequestApi *api = [[HomeRequestApi alloc]init];
    
    if ([api loadCacheWithError:nil]) {
        for (NSDictionary *dic in [[api responseObject] objectForKey:@"list"]) {
            NewsModel *model = [NewsModel new];
            model = [NewsModel modelWithJSON:dic];
            [self.dataArray addObject:model];
            }
        [self.mj_header endRefreshing];
        [self reloadData];
        

    }
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
//        NSLog(@"%@",request.responseString);
        
        for (NSDictionary *dic in [request.responseObject objectForKey:@"list"]) {
                        NewsModel *model = [NewsModel new];
                        model = [NewsModel modelWithJSON:dic];
                        [self.dataArray addObject:model];
                    }
                    [self.mj_header endRefreshing];
                    [self reloadData];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"cellId";
    
    _cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
//    while ([_cell.contentView.subviews lastObject] != nil) {
//        [(UIView *)[_cell.contentView.subviews lastObject] removeFromSuperview];
//    }
    
    _cell.model = self.dataArray[indexPath.row];
    __weak typeof (self) myself = self;
    __block NewsCell *weakCell = _cell;
    _cell.cellClick = ^{
     
        if (![weakCell.model.videouri isEqualToString:@""]) {
            ZFPlayerModel *playerModle = [[ZFPlayerModel alloc] init];
            //playerModle.title = @"这是我的标题";
            playerModle.videoURL = [NSURL URLWithString:weakCell.model.videouri];
            playerModle.placeholderImageURLString = weakCell.model.image0;
            playerModle.tableView = myself;
            playerModle.indexPath = indexPath;
            playerModle.fatherView = weakCell.contentImageView;
            
            [myself.playerView playerControlView:nil playerModel:playerModle];
            [myself.playerView autoPlayTheVideo];
        }
        
        
    };
    return _cell;
}


 
 //设置每行的高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
//    CGFloat resultHeight =  300;
    
    return _cell.cellHeight;
}

@end
