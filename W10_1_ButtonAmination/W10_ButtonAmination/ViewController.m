//
//  ViewController.m
//  W10_ButtonAmination
//
//  Created by 김성희 on 2015. 5. 4..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttonFrame = [_firstButton frame];
    _buttonTitle = [_firstButton titleLabel].text;
    _buttonBgColor = [_firstButton backgroundColor];
    _buttonCenter = [_firstButton center];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeAttr:(id)sender {
    [UIView animateWithDuration:1
                     animations:^{
                         [_firstButton setBackgroundColor:[UIColor colorWithRed:(arc4random() % 256)/255.0
                                                                          green:(arc4random() % 256)/255.0
                                                                           blue:(arc4random() % 256)/255.0
                                                                          alpha:1]];
                         [_firstButton setFrame:CGRectMake(0, 0, 150, 70)];
                         [_firstButton setCenter:CGPointMake(arc4random() % (int)self.view.frame.size.width,
                                                             arc4random() % (int)self.view.frame.size.height)];
                         [_firstButton setTitle:@"Clicked" forState:normal];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1
                                          animations:^{
                                              [_firstButton setTitle:_buttonTitle forState:normal];
                                              [_firstButton setBackgroundColor:_buttonBgColor];
                                              [_firstButton setFrame:_buttonFrame];
                                              [_firstButton setCenter:_buttonCenter];
                                          }
                                          completion:^(BOOL finished) {
                                          }];
                     }];
}

@end
