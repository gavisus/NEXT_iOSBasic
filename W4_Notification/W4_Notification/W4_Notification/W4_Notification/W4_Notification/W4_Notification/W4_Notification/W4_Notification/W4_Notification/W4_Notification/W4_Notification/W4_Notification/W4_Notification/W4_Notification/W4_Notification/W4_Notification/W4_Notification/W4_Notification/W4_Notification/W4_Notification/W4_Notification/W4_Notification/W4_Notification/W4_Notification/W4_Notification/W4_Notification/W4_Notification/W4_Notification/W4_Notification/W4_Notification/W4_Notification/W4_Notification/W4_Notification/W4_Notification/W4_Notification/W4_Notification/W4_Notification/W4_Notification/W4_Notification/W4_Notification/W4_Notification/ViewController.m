//
//  ViewController.m
//  W4_Notification
//
//  Created by 김성희 on 2015. 3. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"
#import "CardDeck.h"

@implementation ViewController

- (IBAction)show:(id)sender {
    [_cardDeck randomize];
}

- (void)setImageWithNoti:(NSNotification *)noti {
    // noti 정보 얻어오기
    NSDictionary *notiDic = [noti userInfo];
    NSString *card = [notiDic objectForKey:@"card"];
    
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@.png", card];
    UIImage *image = [UIImage imageNamed:imageFile];
    [_imageView setImage:image];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        [_cardDeck randomize];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cardDeck = [[CardDeck alloc] init];
    
    // Default NotificationCenter에 observer로 등록
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(setImageWithNoti:) name:@"setCard" object:nil];
}

- (void)viewDidUnload {
    // Default NotificationCenter에 등록된 observer 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"setCard" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
