//
//  ViewController.h
//  W3_JSONImageView
//
//  Created by 김성희 on 2015. 3. 19..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentModel.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleMsg;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) StudentModel *students;

- (IBAction)show:(id)sender;

@end

