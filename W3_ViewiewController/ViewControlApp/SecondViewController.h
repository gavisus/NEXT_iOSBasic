//
//  SecondViewController.h
//  ViewControlApp
//
//  Created by 김성희 on 2015. 3. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface SecondViewController : UIViewController {
    IBOutlet UITextField *name;
    IBOutlet UILabel *searchResult;
}

@property (nonatomic, retain) PersonModel *students;

@end

