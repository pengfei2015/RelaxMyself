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
#import "PFMusicProgressView.h"

#define PFSTATUS_PROP @"status"
#define PFBUFFERING_RATIO @"bufferingRatio"
#define PFDURATION @"duration"

@interface PFMusicPlayingVc ()<PFMusicPlayingFooterViewDelegate,PFMusicProgressViewDelegate>

{
    UIImageView *_imageView;
    UILabel *_titleLab;
    UILabel *_nameLab;
    BOOL _isPlay;
}
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) PFAudioFile *audioFile;

@property (nonatomic, weak) PFMusicProgressView *progressView;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation PFMusicPlayingVc

- (PFAudioFile *)audioFile
{
    if (!_audioFile) {
        _audioFile = [[PFAudioFile alloc] init];
    }
    return _audioFile;
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self playSongAtIndex:self.musicIndex];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(DOUAudioStreamer *)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:PFSTATUS_PROP]) {
            if (DOUAudioStreamerFinished == object.status) {
                [self nextSong];
            }else if (DOUAudioStreamerPlaying == object.status){
                [self addTimer];
            }else if (DOUAudioStreamerPaused == object.status){
                [self removeTimer];
            }
        }else if ([keyPath isEqualToString:PFBUFFERING_RATIO]){
#warning 用除法的时候一定要限制 除数不能为0
            // 总长度
            double expectedLength = self.streamer.expectedLength;
            // 下载长度
            double receivedLength = self.streamer.receivedLength;
            if (expectedLength != 0.0) {
                _progressView.downLoadWidth = (receivedLength / expectedLength) * _progressView.width;
            }
        }else if([PFDURATION isEqualToString:keyPath]){
            _progressView.duration = self.streamer.duration;
        }
    });
    
}

- (void)setNavigationBar
{
    self.view.backgroundColor = [UIColor grayColor];
// 旋转图像
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(self.view.width - 50, self.view.width - 50);
    imageView.center = self.view.center;
    imageView.layer.masksToBounds= YES;
    imageView.layer.cornerRadius = (self.view.width - 50) * 0.5;
    _imageView = imageView;
    
    [self.view addSubview:imageView];
    // 返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(20, 20, 25, 25);
    [self.view addSubview:backButton];
    
    
    // 歌曲名字
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont systemFontOfSize:18.0 weight:20];
    [self.view addSubview:titleLab];
    _titleLab = titleLab;
    
    // 歌手名字
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.font = [UIFont systemFontOfSize:16.0];
    nameLab.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLab];
    _nameLab = nameLab;
    
    // 播放控制界面
    PFMusicPlayingFooterView *footerView = [[PFMusicPlayingFooterView alloc] init];
    footerView.delegate = self;
    CGFloat footerW = self.view.width;
    CGFloat footerH = 80;
    CGFloat footerX = 0;
    CGFloat footerY = self.view.height - footerH;
    footerView.frame = CGRectMake(footerX, footerY, footerW, footerH);
    [self.view addSubview:footerView];
    
    // 歌曲进度界面
    PFMusicProgressView *progressView = [[PFMusicProgressView alloc] init];
    progressView.frame = CGRectMake(0, footerY - 21, self.view.width, 10);
    progressView.delegete = self;
    [self.view addSubview:progressView];
    self.progressView = progressView;
   
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 定时器相关

- (void)addTimer
{
    if (self.timer) return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(roundRotate)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)roundRotate
{
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, M_PI_4 / 200);

}
- (void)updateCurrentTime
{
    // 定时器开始的时候可能还没有获取到值  所以除数可能为0造成崩溃
    if (self.streamer.duration == 0.0) return;
    
    double temp = self.streamer.currentTime / self.streamer.duration;
    //if (isnan(temp)) return;
    self.progressView.slideCurrentX = temp * self.progressView.slideMaxX;
    self.progressView.progressWidth = self.progressView.slideCurrentX;
    self.progressView.currentTime = self.streamer.currentTime;
    
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self.link invalidate];
    self.link = nil;
}

#pragma mark -- PFMusicPlayingFooterViewDelegate
- (void)musicPlayingFooterView:(PFMusicPlayingFooterView *)footerView buttonTypeClick:(PFMusicPlayButtonType)type
{
    switch (type) {
        case PFMusicPlayButtonTypePlay:
        {
            [self playOrPause];
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

// 按钮点击
- (void)playOrPause
{
    if (_isPlay) {
        _isPlay = NO;
        [self.streamer pause];
    }else{
        _isPlay = YES;
        [self.streamer play];
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

// 播放歌曲
- (void)playSongAtIndex:(NSUInteger)index
{
    PFAudioFile *audio = self.streamer.audioFile;
    NSString *playingUrlStr = audio.audioFileURL.absoluteString;
    PFMusicModel *music = _musics[index];
    if ([playingUrlStr isEqualToString:music.source])
        return;
    
    [self clearData];
    
    self.audioFile.audioFileURL = [NSURL URLWithString:music.source];
    self.streamer = [DOUAudioStreamer streamerWithAudioFile:self.audioFile];
    self.streamer.volume = 0.5;
    [self.streamer addObserver:self forKeyPath:PFSTATUS_PROP options:NSKeyValueObservingOptionOld context:nil];
    
    [self.streamer addObserver:self forKeyPath:PFBUFFERING_RATIO options:NSKeyValueObservingOptionOld context:nil];
    
    [self.streamer addObserver:self forKeyPath:PFDURATION options:NSKeyValueObservingOptionOld context:nil];
    [self.streamer play];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PFMUSIC_PLAY_NOTIFICATION object:self userInfo:@{PFMUSIC_PLAYING:music,PFMUSIC_PLAYER:self.streamer}];
    
    _isPlay = YES;
    
    [self setupDataWithModel:music];
}

// 更新数据信息
- (void)setupDataWithModel:(PFMusicModel *)music
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:music.pic_1080] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    // 为了保证显示的第一时间是圆形的  所以先设置隐藏
    
    _titleLab.text = music.name;
    _titleLab.size = PFTEXTSIZE(_titleLab.text, MAXFLOAT, _titleLab.font);
    _titleLab.centerX = self.view.width * 0.5;
    _titleLab.y = 45;
    
    _nameLab.text = music.userName;
    
    _nameLab.size = PFTEXTSIZE(_nameLab.text, MAXFLOAT, _nameLab.font);
    _nameLab.centerX = _titleLab.centerX;
    _nameLab.y = CGRectGetMaxY(_titleLab.frame) + 20;
    
}

- (void)clearData
{
    // 先清空正在播放的歌曲
    
    if (!self.streamer) return;

    [self.streamer pause];
    [self removeObservers];
    self.streamer = nil;
    
    [self removeTimer];
    _imageView.transform = CGAffineTransformIdentity;
}

- (void)removeObservers
{
    [self.streamer removeObserver:self forKeyPath:PFSTATUS_PROP];
    [self.streamer removeObserver:self forKeyPath:PFBUFFERING_RATIO];
    [self.streamer removeObserver:self forKeyPath:PFDURATION];

}

#pragma mark -- PFMusicProgressViewDelegate
- (void)musicProgressView:(PFMusicProgressView *)progressView progressTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:recognizer.view];
    self.streamer.currentTime = (point.x / recognizer.view.width) * self.streamer.duration;
    [self updateCurrentTime];
}

- (void)musicProgressView:(PFMusicProgressView *)progressView slidePanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:recognizer.view];
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
    CGFloat maxX = self.progressView.slideMaxX;
    recognizer.view.x += point.x;
    
    if (recognizer.view.x < 0) {
        recognizer.view.x = 0;
    }else if(recognizer.view.x > maxX){
        recognizer.view.x = maxX;
    }
    
    CGFloat time = (recognizer.view.x / self.progressView.slideMaxX) * self.streamer.duration;
    self.progressView.progressWidth = recognizer.view.center.x;
    self.progressView.currentTime = time;

    if (UIGestureRecognizerStateBegan == recognizer.state) {
        [self removeTimer];
    }else if (UIGestureRecognizerStateEnded == recognizer.state){
        self.streamer.currentTime = time;
        [self updateCurrentTime];
    }
}

static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
@end
