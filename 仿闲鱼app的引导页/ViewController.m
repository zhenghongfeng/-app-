//
//  ViewController.m
//  仿闲鱼app的引导页
//
//  Created by zhf on 16/4/6.
//  Copyright © 2016年 郑洪锋. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <MediaPlayer/MediaPlayer.h>

#import <AVKit/AVKit.h>

@interface ViewController ()

/** 播放器 */
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

/**  */
@property (nonatomic, strong) AVPlayerViewController *avPlayerVC;

@property (nonatomic, strong) AVPlayer *avPlayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"guide0" ofType:@"mp4"];
//    
//    NSURL *url = [NSURL URLWithString:path];
//    
//    _player = [AVPlayer playerWithURL:url];
    
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guide0" ofType:@"mp4"]]];
    self.moviePlayer.view.frame = [UIScreen mainScreen].bounds;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.moviePlayer play];
    [self.view addSubview:self.moviePlayer.view];
    
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guide0" ofType:@"mp4"]]];
    
    _avPlayer = [AVPlayer playerWithPlayerItem:item];
    _avPlayerVC = [[AVPlayerViewController alloc] init];
    _avPlayerVC.player = _avPlayer;
    
    [self addChildViewController:_avPlayerVC];

    _avPlayerVC.view.frame = self.view.bounds;
    [self.view addSubview:_avPlayerVC.view];
    
    [_avPlayerVC.player play];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
