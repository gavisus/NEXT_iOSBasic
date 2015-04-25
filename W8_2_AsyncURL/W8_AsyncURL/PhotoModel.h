//
//  SKIMDataModel.h
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 17..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject {
    NSMutableArray *_orgData;
}

@property (nonatomic, retain) NSMutableArray *list;

- (void)sort;
- (void)restore;
- (void)deleteWithItem:(id)item;

@end