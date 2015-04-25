//
//  ViewController.h
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 17..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface AlbumViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_sections;
    NSString *_mode;
}

@property (nonatomic, retain) PhotoModel *itemList;

@end

