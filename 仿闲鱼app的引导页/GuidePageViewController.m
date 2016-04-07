//
//  GuidePageViewController.m
//  仿闲鱼app的引导页
//
//  Created by zhf on 16/4/6.
//  Copyright © 2016年 郑洪锋. All rights reserved.
//

#import "GuidePageViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GuidePageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;

/** 记录当前位置索引 */
@property (nonatomic, assign) NSInteger currentIndex;

/** <#注释#> */
@property (nonatomic, strong) UIScrollView *scrollView;

/** <#注释#> */
@property (nonatomic, strong) AVPlayer *player;

/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *layerArray;


@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray = @[@"guide0", @"guide1", @"guide2", @"guide3"];
    _layerArray = [NSMutableArray array];
    _currentIndex = 0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.contentSize = CGSizeMake(_imageArray.count * [UIScreen mainScreen].bounds.size.width, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.image = [UIImage imageNamed:_imageArray[i]];
        [_scrollView addSubview:imageView];
        
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:_imageArray[i] ofType:@"mp4"];
//        
//        NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
//        
//        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
//        
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//        
//        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//        
//        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//        
//        playerLayer.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        
//        //视频填充模式
//        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        
//        [_scrollView.layer addSublayer:playerLayer];
//        
//        if (i == 0) {
//            [player play];
//        }
//        
//        [_layerArray addObject:playerLayer];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_imageArray[0] ofType:@"mp4"];
    
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [_scrollView.layer addSublayer:playerLayer];
    
    [player play];
    
    [_layerArray addObject:playerLayer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    NSLog(@"index = %@", @(index));
    
    if (self.currentIndex != index) {
        
        NSLog(@"播放");
//        [_scrollView.layer removeFromSuperlayer];
        
//        AVPlayerLayer *playLayer = _layerArray[index];
//        
//        [playLayer.player play];
//        
//        [playLayer.player seekToTime:CMTimeMake(0,1)];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:_imageArray[index] ofType:@"mp4"];
        
        NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
        
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        
        AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
        
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        playerLayer.frame = CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        //视频填充模式
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [_scrollView.layer addSublayer:playerLayer];
        
        [player play];
        
        self.currentIndex = index;
        
        
//        for (int i = 0; i < _imageArray.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//            imageView.image = [UIImage imageNamed:_imageArray[i]];
//            [_scrollView addSubview:imageView];
//        }
        
    } else {
        NSLog(@"不播放");
    }
}



//- (void)playAgain
//{
//    [playLayer.player seekToTime:CMTimeMake(0,1)];
//    [playLayer.player play];
//}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
