//
//  ViewController.h
//  W10_ButtonAmination
//
//  Created by 김성희 on 2015. 5. 4..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGRect _buttonFrame;
    NSString *_buttonTitle;
    UIColor *_buttonBgColor;
    CGPoint _buttonCenter;
}

@property (weak, nonatomic) IBOutlet UIButton *firstButton;

- (IBAction)changeAttr:(id)sender;

@end

