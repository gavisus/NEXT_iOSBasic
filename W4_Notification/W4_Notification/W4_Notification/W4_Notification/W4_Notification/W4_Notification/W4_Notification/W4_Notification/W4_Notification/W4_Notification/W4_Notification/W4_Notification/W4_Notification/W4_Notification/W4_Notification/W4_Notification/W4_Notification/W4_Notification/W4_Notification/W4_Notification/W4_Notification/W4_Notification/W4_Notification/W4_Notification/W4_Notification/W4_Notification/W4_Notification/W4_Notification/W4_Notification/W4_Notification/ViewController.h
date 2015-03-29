//
//  ViewController.h
//  W4_Notification
//
//  Created by 김성희 on 2015. 3. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDeck.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) CardDeck *cardDeck;

- (IBAction)show:(id)sender;

@end

