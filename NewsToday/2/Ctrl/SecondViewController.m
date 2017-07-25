

//
//  SecondViewController.m
//  NewsToday
//
//  Created by Mr_Jia on 2017/4/14.
//  Copyright © 2017年 Mr_Jia. All rights reserved.
//

#import "SecondViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SecondViewController ()
@property (nonatomic,strong) AVPlayer *player;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Second";
    self.view.backgroundColor = [UIColor colorWithHexString:@"4c4c4c"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[YYFPSLabel new]];
//
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    btn.frame = CGRectMake(0, 400, 100, 30);
    
    btn.centerX = self.view.centerX;
    
    btn.backgroundColor = [UIColor randomColor];
    
    
    [btn setTitle:@"播放\\暂停" forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"]];
//    //添加监听
//    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    self.player = [AVPlayer playerWithPlayerItem:playerItem];
//    
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer: self.player];
//    //设置模式
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    playerLayer.contentsScale = [UIScreen mainScreen].scale;
//    playerLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
//    [self.view.layer addSublayer:playerLayer];
    
  
    AVPlayerItem *playerItem   = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:@"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"]];
    
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    playerLayer.contentsScale = [UIScreen mainScreen].scale;
    
    playerLayer.frame = CGRectMake(0, 100, kScreenWidth, 200);
    
    [self.view.layer addSublayer:playerLayer];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,playerLayer.bottom , kScreenWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor randomColor];
    __weak __typeof(self) weakSelf = self;

    [playerLayer addSublayer:label.layer];
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //当前播放的时间
        NSTimeInterval current = CMTimeGetSeconds(time);
        //视频的总时间
        NSTimeInterval total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        //设置滑块的当前进度
//        weakSelf.slider.sliderPercent = current/total;
        NSLog(@"%f",current/total);
        //设置时间
//        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@", [weakSelf formatPlayTime:current], [weakSelf formatPlayTime:total]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@/%@", [weakSelf formatPlayTime:current], [weakSelf formatPlayTime:total]]);
        
        label.text = [NSString stringWithFormat:@"%@/%@", [weakSelf formatPlayTime:current], [weakSelf formatPlayTime:total]];
    }];
}

- (NSString *)formatPlayTime:(NSTimeInterval)duration
{
    int minute = 0, hour = 0, secend = duration;
    minute = (secend % 3600)/60;
    hour = secend / 3600;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}
- (void)clickAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.player.rate == 1) {
        [self.player pause];
//        self.link.paused = YES;
//        [self.activity stopAnimating];
    } else {
        [self.player play];
//        self.link.paused = NO;
    }
    
}

//监听回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
    }else if ([keyPath isEqualToString:@"status"]){
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            NSLog(@"playerItem is ready");
            [self.player play];
        } else{
            NSLog(@"load break");
        }
    }
}

- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
