//
//  PhotoImageModel.h
//  W8_AsyncURL
//
//  Created by 김성희 on 2015. 4. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoImageModel : NSObject <NSURLConnectionDelegate> {
    NSMutableDictionary *_item;
   
    NSMutableData *_responseData;
}

- (id)initWithItem:(NSMutableDictionary *)item;
- (void)loadImage;

@end
