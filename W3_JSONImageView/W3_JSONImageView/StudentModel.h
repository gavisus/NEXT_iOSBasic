//
//  StudentModel.h
//  W3_2_JSONImageView
//
//  Created by 김성희 on 2015. 3. 19..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#include <Foundation/Foundation.h>

@interface StudentModel : NSObject {
}

@property NSMutableArray *data;

- (id)initFromJson:(NSString *)jsonData;
- (int)count;
- (NSDictionary *)objectAtIndex:(int)index;

- (NSString *)jsonMakerWithArray:(NSArray*)array;
- (NSString *)jsonMakerWithDictionary:(NSDictionary*)dictionary;

@end