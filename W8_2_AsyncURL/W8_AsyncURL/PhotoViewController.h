//
//  PhotoViewController.h
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController {
    NSString *_photoTitle;
    NSString *_subTitle;
    
    UIImage *_imageData;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setDataWithItem:(NSDictionary *)item;

@end
