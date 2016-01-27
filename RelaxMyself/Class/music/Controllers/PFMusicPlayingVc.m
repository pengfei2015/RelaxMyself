//
//  PFMusicPlayingVc.m
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/26.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import "PFMusicPlayingVc.h"
#import "UIImageView+WebCache.h"
#import "PFMusicModel.h"
#import "PFMusicPlayingFooterView.h"
#import "PFHttpTool.h"
#import "DOUAudioStreamer.h"
#import "MBProgressHUD+MJ.h"
#import "PFAudioFile.h"

#define PFSTATUS_PROP @"status"
#define PFBUFFERING_RATIO @"bufferingRatio"
@interface PFMusicPlayingVc ()<PFMusicPlayingFooterViewDelegate>

{
    UIImageView *_imageView;
    UILabel *_titleLab;
    UILabel *_nameLab;
}
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) PFMusicModel *music;

@property (nonatomic, strong) PFAudioFile *audioFile;

@end

@implementation PFMusicPlayingVc

- (PFAudioFile *)audioFile
{
    if (!_audioFile) {
        _audioFile = [[PFAudioFile alloc] init];
    }
    return _audioFile;
}

- (PFMusicModel *)music
{
    if (!_music) {
        _music = self.musics[self.musicIndex];
    }
    return _music;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];

    [self playSongAtIndex:self.musicIndex];
    
}

- (void)dealloc
{
    PFLog(@"PFMusicPlayingVc");
    
    [self removeObservers];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:PFSTATUS_PROP]) {
            PFLog(@"播放状态改变了");
        }else if ([keyPath isEqualToString:PFBUFFERING_RATIO]){
            
        }
    });
    
}

- (void)setNavigationBar
{
    self.view.backgroundColor = [UIColor grayColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(self.view.width - 50, self.view.width - 50);
    imageView.center = self.view.center;
    _imageView = imageView;
    
    [self.view addSubview:imageView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(20, 20, 25, 25);
    [self.view addSubview:backButton];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:18.0 weight:20];
    [self.view addSubview:titleLab];
    _titleLab = titleLab;
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.font = [UIFont systemFontOfSize:16.0];
    nameLab.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLab];
    _nameLab = nameLab;
    
    PFMusicPlayingFooterView *footerView = [[PFMusicPlayingFooterView alloc] init];
    footerView.delegate = self;
    CGFloat footerW = self.view.width;
    CGFloat footerH = 80;
    CGFloat footerX = 0;
    CGFloat footerY = self.view.height - footerH;
    footerView.frame = CGRectMake(footerX, footerY, footerW, footerH);
    [self.view addSubview:footerView];

}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- PFMusicPlayingFooterViewDelegate
- (void)musicPlayingFooterView:(PFMusicPlayingFooterView *)footerView buttonTypeClick:(PFMusicPlayButtonType)type
{
    switch (type) {
        case PFMusicPlayButtonTypePlay:
        {
            
        }
            break;
        case PFMusicPlayButtonTypeNext:
        {
            [self nextSong];
        }
            break;
        case PFMusicPlayButtonTypePrevious:
        {
            [self previousSong];
        }
            break;
            
        default:
            break;
    }
}

- (void)nextSong
{
    if (self.musics.count - 1  == self.musicIndex) {
        [MBProgressHUD showError:@"已经是最后一首了"];
        return;
    }
    ++ self.musicIndex;
    [self playSongAtIndex:self.musicIndex];
}

- (void)previousSong
{
    if (0 == self.musicIndex) {
        [MBProgressHUD showError:@"已经是第一首了"];
        return;
    }
    -- self.musicIndex;
    [self playSongAtIndex:self.musicIndex];
}
- (void)playSongAtIndex:(NSUInteger)index
{
    [self clearData];
    
    PFMusicModel *music = self.musics[index];
    self.audioFile.audioFileURL = [NSURL URLWithString:music.source];
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:self.audioFile];
    
    [self.streamer addObserver:self forKeyPath:PFSTATUS_PROP options:NSKeyValueObservingOptionOld context:nil];
    
    [self.streamer addObserver:self forKeyPath:PFBUFFERING_RATIO options:NSKeyValueObservingOptionOld context:nil];
    [self.streamer play];
    
    [self setupDataWithModel:music];

}

- (void)setupDataWithModel:(PFMusicModel *)music
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:music.pic_1080]];
    UIImage *image = [UIImage circleImageWithImage:_imageView.image borderWidth:2 borderColor:PFRANDRGB];
    _imageView.image = image;
// 为了保证显示的第一时间是圆形的  所以先设置隐藏 
    _imageView.hidden = NO;
    
    _titleLab.text = music.name;
    _titleLab.size = PFTEXTSIZE(_titleLab.text, MAXFLOAT, _titleLab.font);
    _titleLab.centerX = self.view.width * 0.5;
    _titleLab.y = 25;

    _nameLab.text = music.userName;

    _nameLab.size = PFTEXTSIZE(_nameLab.text, MAXFLOAT, _nameLab.font);
    _nameLab.centerX = _titleLab.centerX;
    _nameLab.y = CGRectGetMaxY(_titleLab.frame) + 20;
}


- (void)removeObservers
{
    [self.streamer removeObserver:self forKeyPath:PFSTATUS_PROP];
    [self.streamer removeObserver:self forKeyPath:PFBUFFERING_RATIO];
}

- (void)clearData
{
    // 先清空正在播放的歌曲
    
    if (!self.streamer) return;
    
    [self.streamer pause];
    [self removeObservers];
    self.streamer = nil;
    
    _imageView.hidden = YES;

}
@end
