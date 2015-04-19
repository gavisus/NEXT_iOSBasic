//
//  PhotoViewController.m
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "PhotoViewController.h"

@implementation PhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    _titleLabel.text = _photoTitle;
    _dateLabel.text = _subTitle;
    
    UIImage *image = [UIImage imageNamed:[[NSString alloc] initWithString:_imageFile]];
    [_imageView setImage:image];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Set local data

- (void)setDataWithItem:(NSDictionary *)item {
    _photoTitle = [item objectForKey:@"title"];
    _subTitle = [item objectForKey:@"date"];
    _imageFile = [item objectForKey:@"image"];
}

@end
