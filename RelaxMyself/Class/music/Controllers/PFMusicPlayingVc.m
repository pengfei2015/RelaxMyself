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
#import "UMSocial.h"


#define PFSTATUS_PROP @"status"
#define PFBUFFERING_RATIO @"bufferingRatio"
#define PFDURATION @"duration"

@interface PFMusicPlayingVc ()<PFMusicPlayingFooterViewDelegate,PFMusicProgressViewDelegate,UMSocialUIDelegate>

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
@property (nonatomic, weak) PFMusicPlayingFooterView *footerView;
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


- (void)viewDidDisappear:(BOOL)animated
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

#pragma mark -- 创建按钮等

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
    
    // 分享按钮
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(self.view.width - 50 - 20, 20, 50, 25);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
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
    self.footerView = footerView;
    
    // 歌曲进度界面
    PFMusicProgressView *progressView = [[PFMusicProgressView alloc] init];
    progressView.frame = CGRectMake(0, footerY - 21, self.view.width, 10);
    progressView.delegete = self;
    [self.view addSubview:progressView];
    self.progressView = progressView;
   
}
- (void)shareClick
{
    NSString *text = @"分享音乐，分享快乐";
    NSString *url = [self.musics[self.musicIndex] source];
    NSString *str = PFFORMAT(@"%@:%@",text,url);
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPP_KEY shareText:str shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,UMShareToSms,UMShareToEmail] delegate:self];

//    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:url image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
//        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//            [MBProgressHUD showSuccess:@"成功分享"];
//        }
//    }];
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 定时器相关

// 添加定时器
- (void)addTimer
{
    if (self.timer) return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    //[_timer fire];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(roundRotate)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 定时器旋转方法
- (void)roundRotate
{
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, M_PI_4 / 200);

}

// 定时器更新数据
- (void)updateCurrentTime
{
    
    
    [self updateProgressWithCurrentTime:self.streamer.currentTime];
    
}

- (void)updateProgressWithCurrentTime:(CGFloat)currentTime
{
    // 定时器开始的时候可能还没有获取到值  所以除数可能为0造成崩溃
    if (self.streamer.duration == 0.0 && currentTime != 0.0) return;
    double temp = currentTime / self.streamer.duration;
    //if (isnan(temp) && currentTime != 0.0) return;
    if (currentTime == 0.0) {
        temp = 0.0;
    }
    self.progressView.slideCurrentX = temp * self.progressView.slideMaxX;
    self.progressView.progressWidth = self.progressView.slideCurrentX;
    self.progressView.currentTime = currentTime;
}
// 移除定时器
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self.link invalidate];
    self.link = nil;
}

#pragma mark -- PFMusicPlayingFooterViewDelegate

// 歌曲播放音量的设置
- (void)musicPlayingFooterView:(PFMusicPlayingFooterView *)footerView voiceValueChange:(CGFloat)value
{
    if (self.streamer) {
        self.streamer.volume = value;
    }
}

// 歌曲控制界面的点击
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

// 按钮点击 暂停或者播放
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

// 下一首
- (void)nextSong
{
    if (self.musics.count - 1  == self.musicIndex) {
        [MBProgressHUD showError:@"已经是最后一首了"];
        [self updateProgressWithCurrentTime:0.0];
        return;
    }
    ++ self.musicIndex;
    [self playSongAtIndex:self.musicIndex];
}

// 上一首
- (void)previousSong
{
    if (0 == self.musicIndex) {
        [MBProgressHUD showError:@"已经是第一首了"];
        [self updateProgressWithCurrentTime:0.0];
        return;
    }
    -- self.musicIndex;
    [self playSongAtIndex:self.musicIndex];
}

// 播放歌曲
- (void)playSongAtIndex:(NSUInteger)index
{
    
// 判断是否是同一首歌? 如果是的话就返回
    
#warning 因为歌曲的网址可能一样，所以这里判断歌曲的来源是不靠谱的
    PFAudioFile *audio = self.streamer.audioFile;
   // NSString *playingUrlStr = audio.audioFileURL.absoluteString;
    PFMusicModel *music = _musics[index];
    
    //if ([playingUrlStr isEqualToString:music.source])
     //   return;
    if ([audio.id isEqualToString:music.id]) return;
    
    [self clearData];
    
    self.audioFile.audioFileURL = [NSURL URLWithString:music.source];
    self.audioFile.id = [music.id copy];

    self.streamer = [DOUAudioStreamer streamerWithAudioFile:self.audioFile];
    CGFloat value = [[NSUserDefaults standardUserDefaults] floatForKey:MUSIC_VOICE];
    
    [self musicPlayingFooterView:self.footerView voiceValueChange:value];
    
    // KVO 键值观察
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
    
    [self updateProgressWithCurrentTime:0.0];
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
    [self removeTimer];
    CGPoint point = [recognizer locationInView:recognizer.view];
    CGFloat x = (point.x / recognizer.view.width) * self.streamer.duration;
#warning 为什么点击后currentTime数据不是立马改变的
    self.streamer.currentTime = x;

    [self updateProgressWithCurrentTime:x];
    
    if (_isPlay) {
        [self addTimer];
    }
}

- (void)musicProgressView:(PFMusicProgressView *)progressView slidePanGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:recognizer.view];
    
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
        if (_isPlay == YES) {
            [self addTimer];
        }
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


#pragma mark -- UMSocialUIDelegate
- (BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        [MBProgressHUD showSuccess:@"分享成功"];
    }else if (response.responseCode == UMSResponseCodeFaild){
        [MBProgressHUD showError:@"分享失败"];
    }
}
@end
