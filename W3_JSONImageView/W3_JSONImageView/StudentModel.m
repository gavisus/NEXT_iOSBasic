//
//  StudentModel.m
//  W3_2_JSONImageView
//
//  Created by 김성희 on 2015. 3. 19..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentModel.h"

@implementation StudentModel

- (id)initFromJson:(NSString *)jsonString {
    self = [super init];
    
    if (self != nil) {
        NSError *error = nil;
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:0
                                                                      error:&error];

        NSLog(@"parsedObject %@", parsedObject);
        
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in parsedObject) {
            [_data addObject:dict];
        }
        NSLog(@"Count %lu %@\n", (unsigned long)_data.count, _data);
    }
 
    return self;
}

- (int)count {
    return (int)_data.count;
}

- (NSDictionary *)objectAtIndex:(int)index {
    return [_data objectAtIndex:index];
}

- (NSString *)jsonMakerWithArray:(NSArray*)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)jsonMakerWithDictionary:(NSDictionary*)dictionary {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end