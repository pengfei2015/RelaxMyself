//
//  PFMusicModel.h
//  RelaxMyself
//
//  Created by 温鹏飞 on 16/1/25.
//  Copyright © 2016年 温鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DOUAudioStreamer.h"

@interface PFMusicModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pic_1080;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, strong) NSDictionary *user;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *id;


//@property (nonatomic, strong) NSURL *audioFileURL;


/*{
    message = success;
    result =     {
        data =         {
            channel =             {
                "backup_id" = 0;
                "check_visition" = 1;
                "commend_time" = 0;
                "create_time" = 1399451040;
                desp = "\U6e05\U65b0\U97f3\U4e50";
                "encrypt_level" = 0;
                "follow_count" = 170287;
                id = 24;
                info = "\U8f7b\U82e5\U84b2\U516c\U82f1\U98de\U8fc7\U4e94\U6708\U3002\U8ba9\U6211\U4eec\U62e5\U62b1\U6e05\U65b0";
                "is_attention" = 0;
                "like_count" = 0;
                "list_order" = 82552;
                name = "\U90a3\U4e9b\U72ec\U7acb\U5c0f\U6e05\U65b0";
                pic = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg";
                "pic_100" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-100";
                "pic_1080" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-1080";
                "pic_200" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-200";
                "pic_500" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-500";
                "pic_640" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-640";
                "pic_750" = "http://kibey-echo.b0.upaiyun.com/poster/2015/12/01/w9iq3fywqyrwt2qr.jpg-750";
                "share_count" = 1487;
                "sound_count" = 24063;
                status = 1;
                "tag_id" = 5;
                "tag_id2" = 18;
                type = 1;
                "update_time" = 1448944303;
                "update_user_id" = 115163;
                "user_id" = 115163;
            };
            news = 0;
            sounds =             (
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1453629600;
                                      "comment_count" = 80;
                                      "exchange_count" = 776;
                                      id = 631748;
                                      length = 235;
                                      "like_count" = 1545;
                                      name = "\U300c\U900f\U660e\U5bf9\U767d\U300d\U66f9\U65b9";
                                      pic = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FvBND3B0hwkH17lR-vQd8Q3yGsqN?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/e02856f8cb284eee226f9f85505f673cc31c24105a9edd83a938666fd7635aa5791b25df.mp3?1448706918";
                                      status = 1;
                                      "status_mask" = 8;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_icon" = "http://77fz4p.com3.z0.glb.qiniucdn.com/20151221/vip@2x.png";
                                          "famous_status" = 103;
                                          "famous_type" = 1;
                                          "followed_count" = 2185;
                                          id = 14102092;
                                          name = "\U66f9\U65b9Icy";
                                          "pay_class" = 1;
                                          "pay_status" = 1;
                                          photo = "";
                                          status = 1;
                                      };
                                      "user_id" = 14102092;
                                      "view_count" = 62347;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1453419300;
                                      "comment_count" = 135;
                                      "exchange_count" = 1167;
                                      id = 1043198;
                                      length = 168;
                                      "like_count" = 2191;
                                      name = "\U68a6\U4e2d\U5c0f\U8239\U9a76\U5411\U4f60\U5fc3\U95f4 Dreamboat";
                                      pic = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FiBWsz0E1vghPHC6KySb0pEbixmf?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/f887ced7cd5410acbe30acc53e94d673639dfc597b6d085c6fb45c79b3edf3d1a48647cc.mp3?1452660405";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://kibey-sys-avatar.b0.upaiyun.com/00/00/00/02/45/61/root03144629crop.jpg!250";
                                          "avatar_100" = "http://kibey-sys-avatar.b0.upaiyun.com/00/00/00/02/45/61/root03144629crop.jpg!100";
                                          "avatar_50" = "http://kibey-sys-avatar.b0.upaiyun.com/00/00/00/02/45/61/root03144629crop.jpg!50";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 2580;
                                          id = 24561;
                                          name = "\U592a\U767d\U5148\U751f";
                                          "pay_class" = 0;
                                          "pay_status" = 0;
                                          photo = "/00/00/00/00/00/00/root03144629.jpg";
                                          status = 0;
                                      };
                                      "user_id" = 24561;
                                      "view_count" = 69138;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1453330800;
                                      "comment_count" = 1544;
                                      "exchange_count" = 10818;
                                      id = 774800;
                                      length = 193;
                                      "like_count" = 22719;
                                      name = "\U8584\U8377\U7eff\U7684\U6b27\U7f8e\U6e05\U65b0\U5973\U58f0 Neopolitan Dreams";
                                      pic = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FkGFmwfUj5enlsHi2Lrm-l3VA8IN?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/5306abfc7450d3678a076e0771f93e4615c35ab9b73baab082ef695eb8ac52c33b54cbe7.mp3?1448821426";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FgmM3oHyRVn8Ew4K4hhHyIuI4N5J?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FgmM3oHyRVn8Ew4K4hhHyIuI4N5J?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FgmM3oHyRVn8Ew4K4hhHyIuI4N5J?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 794;
                                          id = 7118685;
                                          name = "Veer\U845b\U6653\U6708";
                                          "pay_class" = 0;
                                          "pay_status" = 0;
                                          photo = "";
                                          status = 1;
                                      };
                                      "user_id" = 7118685;
                                      "view_count" = 562747;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1453087800;
                                      "comment_count" = 119;
                                      "exchange_count" = 1862;
                                      id = 1045988;
                                      length = 235;
                                      "like_count" = 3242;
                                      name = "\U96e8\U8679 \U4eba\U4e0e\U4eba\U4e4b\U95f4\U9519\U7efc\U590d\U6742\U7684\U60c5\U611f\U5173\U7cfb   \U66f9\U65b9";
                                      pic = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FpBs6yUDGO8TvWF9_1Dbalh5jhLi?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/ddd6ddc26a0539d68607798e4318b235271fe78a7a2d1104b309fd0fdfdb79b53564c749.mp3?1452851778";
                                      status = 1;
                                      "status_mask" = 8;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FjO_ZU5jI6ykrqTIOg-4vQ4b4Xka?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_icon" = "http://77fz4p.com3.z0.glb.qiniucdn.com/20151221/vip@2x.png";
                                          "famous_status" = 103;
                                          "famous_type" = 1;
                                          "followed_count" = 2185;
                                          id = 14102092;
                                          name = "\U66f9\U65b9Icy";
                                          "pay_class" = 1;
                                          "pay_status" = 1;
                                          photo = "";
                                          status = 1;
                                      };
                                      "user_id" = 14102092;
                                      "view_count" = 119763;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452905700;
                                      "comment_count" = 339;
                                      "exchange_count" = 4682;
                                      id = 757855;
                                      length = 248;
                                      "like_count" = 9594;
                                      name = "\U611f\U53d7\U4e00\U79cd\U6175\U61d2\U968f\U5174\U7684\U6c1b\U56f4 ohio";
                                      pic = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v";
                                      "pic_100" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/Fu1dcXMWwWIkUgSb6D0occGbED-v?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/0ae322f9dc15ff62a2b07b75baaad34a29c46cf178e3ab6e63addafd006496843c914312.mp3?1448764196";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://7xavig.com2.z0.glb.qiniucdn.com/7d4e1ca06221c6ee80f43b0c83542fe9.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://7xavig.com2.z0.glb.qiniucdn.com/7d4e1ca06221c6ee80f43b0c83542fe9.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://7xavig.com2.z0.glb.qiniucdn.com/7d4e1ca06221c6ee80f43b0c83542fe9.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 295;
                                          id = 7335932;
                                          name = LYLSONY;
                                          "pay_class" = 1;
                                          "pay_status" = 2;
                                          photo = "http://7xavig.com2.z0.glb.qiniucdn.com/7d4e1ca06221c6ee80f43b0c83542fe9.png";
                                          status = 1;
                                      };
                                      "user_id" = 7335932;
                                      "view_count" = 454165;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452852000;
                                      "comment_count" = 227;
                                      "exchange_count" = 1370;
                                      id = 1032613;
                                      length = 215;
                                      "like_count" = 4264;
                                      name = "\U90d1\U79c0\U6676\U6700\U7231\U4e0d\U91ca\U624b\U7684\U72ec\U7acb\U5c0f\U6e05\U65b0  Oohyo  Madrid";
                                      pic = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FrrmQYT12suZ_XkI-LE9AOkB2pBf?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/76a183d1b7d14db01ef697918460ce6673b05fa3c78f14b6490adaba9011b928cac89ec7.mp3?1452046389";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 928;
                                          id = 13846498;
                                          name = MUUUUJ;
                                          "pay_class" = 0;
                                          "pay_status" = 0;
                                          photo = "";
                                          status = 1;
                                      };
                                      "user_id" = 13846498;
                                      "view_count" = 136947;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452747600;
                                      "comment_count" = 40;
                                      "exchange_count" = 893;
                                      id = 1030544;
                                      length = 209;
                                      "like_count" = 2196;
                                      name = "\U6bd4\U7ea2\U4e1d\U7ed2\U86cb\U7cd5\U8fd8\U60ec\U610f\U7684\U4e0b\U5348\U8336\U5fc5\U5907\U66f2 \Ud5e4\Uc5b4\Uc9c4 \Ub2e4\Uc74c\Ub0a0";
                                      pic = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FkQj7hLemuePt-zU9w9CFS5XZtzX?imageView2/4/w/750";
                                      source = "http://7fvgtj.com2.z0.glb.qiniucdn.com/lhVCKoCiehnS6sGgBm5i8f45DMDW";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FirIDmmAMGhkija4h5C00IJodWQO?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 928;
                                          id = 13846498;
                                          name = MUUUUJ;
                                          "pay_class" = 0;
                                          "pay_status" = 0;
                                          photo = "";
                                          status = 1;
                                      };
                                      "user_id" = 13846498;
                                      "view_count" = 88057;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452661200;
                                      "comment_count" = 168;
                                      "exchange_count" = 2609;
                                      id = 191397;
                                      length = 168;
                                      "like_count" = 4197;
                                      name = "\U6ee1\U6ee1\U90fd\U662f\U9633\U5149 You Are My Sunshine";
                                      pic = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4";
                                      "pic_100" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/FiDa5hlbSYoTfZpJdfa3i1gKIpx4?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/2cd46b6e13ae3c3ebe0430d9af0ccaab98719056b873fdce7ccc2665f3e40106249fcf49.mp3?1448711857";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://7xik56.com2.z0.glb.qiniucdn.com/aa1821c5de8c8d71e8900ef0f2cbcdb36111e3f2?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://7xik56.com2.z0.glb.qiniucdn.com/aa1821c5de8c8d71e8900ef0f2cbcdb36111e3f2?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://7xik56.com2.z0.glb.qiniucdn.com/aa1821c5de8c8d71e8900ef0f2cbcdb36111e3f2?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_status" = 0;
                                          "famous_type" = "<null>";
                                          "followed_count" = 150;
                                          id = 822015;
                                          name = "\U5339\U8bfa\U66f9\U7684\U5c0f\U8fab\U5b50";
                                          "pay_class" = 1;
                                          "pay_status" = 2;
                                          photo = "http://7xik56.com2.z0.glb.qiniucdn.com/aa1821c5de8c8d71e8900ef0f2cbcdb36111e3f2";
                                          status = 1;
                                      };
                                      "user_id" = 822015;
                                      "view_count" = 132060;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452294000;
                                      "comment_count" = 291;
                                      "exchange_count" = 4868;
                                      id = 322735;
                                      length = 249;
                                      "like_count" = 7411;
                                      name = "\U5c0f\U6e05\U65b0\U5f39\U5531 Take Me Away  (Acoustic Version)";
                                      pic = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv";
                                      "pic_100" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/100";
                                      "pic_1080" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/1080";
                                      "pic_200" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/200";
                                      "pic_500" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/500";
                                      "pic_640" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/640";
                                      "pic_750" = "http://echo-image.qiniucdn.com/Fuqwub7m40xiKh2TYdy0tYvsvamv?imageView2/4/w/750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/2c3e6a9c583591672114cb70abed14d8469b730521a7249b8c8a5e2e436e0bf662f58d98.mp3?1448613071";
                                      status = 1;
                                      "status_mask" = 8;
                                      user =                     {
                                          avatar = "http://7xavig.com2.z0.glb.qiniucdn.com/9827cd835aee77204ef648b7b5977051.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://7xavig.com2.z0.glb.qiniucdn.com/9827cd835aee77204ef648b7b5977051.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://7xavig.com2.z0.glb.qiniucdn.com/9827cd835aee77204ef648b7b5977051.png?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_icon" = "http://77fz4p.com3.z0.glb.qiniucdn.com/20151221/vip@2x.png";
                                          "famous_status" = 103;
                                          "famous_type" = 1;
                                          "followed_count" = 857;
                                          id = 13866024;
                                          name = "ReDor\U9510\U8c46\U4e50\U961f";
                                          "pay_class" = 1;
                                          "pay_status" = 1;
                                          photo = "http://7xavig.com2.z0.glb.qiniucdn.com/9827cd835aee77204ef648b7b5977051.png";
                                          status = 1;
                                      };
                                      "user_id" = 13866024;
                                      "view_count" = 237910;
                                  },
                                  {
                                      "channel_id" = 24;
                                      "commend_time" = 1452193200;
                                      "comment_count" = 1161;
                                      "exchange_count" = 15027;
                                      id = 246914;
                                      length = 221;
                                      "like_count" = 15868;
                                      name = "\U5c0f\U6e05\U65b0\U7684\U6ce1\U83dc\U6b4c\U66f2 \U80fd\U591f\U6210\U5bb6\U4e48\Uff1f";
                                      pic = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg";
                                      "pic_100" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!100";
                                      "pic_1080" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!1080";
                                      "pic_200" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!200";
                                      "pic_500" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!500";
                                      "pic_640" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!640";
                                      "pic_750" = "http://echo-web-pic.b0.upaiyun.com/d5d49bfb5630a27539e717f1a1d7e024.jpg!750";
                                      source = "http://7u2q8y.com2.z0.glb.qiniucdn.com/c1/68d130297f8f21ed3dda7804621f11ef9cb319f046add5a66086b5e776da3c05037ea97e.mp3?1448191919";
                                      status = 1;
                                      "status_mask" = 0;
                                      user =                     {
                                          avatar = "http://echo-image.qiniucdn.com/FsmvUHxfftCY8auqd1aHx0odlyvP?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0";
                                          "avatar_100" = "http://echo-image.qiniucdn.com/FsmvUHxfftCY8auqd1aHx0odlyvP?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!100x100r/gravity/Center/crop/100x100/dx/0/dy/0";
                                          "avatar_50" = "http://echo-image.qiniucdn.com/FsmvUHxfftCY8auqd1aHx0odlyvP?imageMogr2/thumbnail/!250x250r/gravity/Center/crop/250x250/dx/0/dy/0&imageMogr2/thumbnail/!50x50r/gravity/Center/crop/50x50/dx/0/dy/0";
                                          "famous_icon" = "http://77fz4p.com3.z0.glb.qiniucdn.com/20151221/vip@2x.png";
                                          "famous_status" = 103;
                                          "famous_type" = 7;
                                          "followed_count" = 84206;
                                          id = 490552;
                                          name = "\U4e45\U7761\U5922\U4e8c";
                                          "pay_class" = 1;
                                          "pay_status" = 1;
                                          photo = "/00/00/00/00/00/00/root06165742.png";
                                          status = 0;
                                      };
                                      "user_id" = 490552;
                                      "view_count" = 399318;
                                  }
                                  );
        };
    };
    state = 1;
}
*/
@end
