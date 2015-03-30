//
//  NSObject_PersonModel.h
//  ViewControlApp
//
//  Created by 김성희 on 2015. 3. 18..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonModel.h"

@implementation PersonModel {
    NSMutableArray *_dataArray;
}

- (id)initWithFilePath:(NSString *)filePath {
    self = [super init];
    
    if (self != nil) {
        _dataArray = [[NSMutableArray alloc] init];
        
        NSString *contents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
        
        NSArray *lines = [contents componentsSeparatedByString:@"\n"];
        for (NSString *line in lines) {
            NSArray *columns = [line componentsSeparatedByString:@","];
            if (columns.count >= 3) {
                NSDictionary *values = @{@"name":columns[0], @"number":columns[1], @"team":columns[2]};
                [_dataArray addObject:values];
                
                NSLog(@"%@", values);
            }
        }
    }
    
    return self;
}

- (NSDictionary *)getPersonObjectAtIndex:(int)index {
    if (index < 0 || index > _dataArray.count - 1) {
        return nil;
    }
    
    NSDictionary *person = [_dataArray objectAtIndex:index];
    return person;
}

- (NSObject *)personFieldAtIndex:(int)index field:(NSString *)field {
    NSDictionary *person = [self getPersonObjectAtIndex:index];
    
    if (person == nil)
        return nil;
    
    return [person objectForKey:field];
}

- (NSString *)personNameAtIndex:(int)index {
    return (NSString *)[self personFieldAtIndex:index field:@"name"];
}

- (NSNumber *)personNumberAtIndex:(int)index {
    return (NSNumber *)[self personFieldAtIndex:index field:@"number"];
}

- (NSNumber *)personTeamAtIndex:(int)index {
    return (NSNumber *)[self personFieldAtIndex:index field:@"team"];
}

- (NSString *)findPersonNameByNumber:(NSNumber *)number {
    for (int i = 0; i < _dataArray.count; i++) {
        if ([[self personNumberAtIndex:i] intValue] == [number intValue])
            return [self personNameAtIndex:i];
        
        // crash?
        //    if ([[self personNumberAtIndex:i] isEqualToNumber number])
        //      return [self personNameAtIndex:i];
    }
    
    return nil;
}

- (NSNumber *)findPersonNumberByName:(NSString *)name {
    for (int i = 0; i < _dataArray.count; i++) {
        if ([[self personNameAtIndex:i] isEqualToString:name])
            return [self personNumberAtIndex:i];
    }
    
    return nil;
}

- (NSArray *)sortedByField:(NSString *)field {
    NSArray *sortedArray = [_dataArray sortedArrayUsingComparator:^(NSDictionary *obj1, NSDictionary *obj2) {
        return [[obj1 objectForKey:field] compare:[obj2 objectForKey:field]];
    }];
    
    NSLog(@"%@", sortedArray);
    return sortedArray;
}

- (NSArray *)sortedByName {
    return [self sortedByField:@"name"];
}

- (NSArray *)sortedByNumber {
    return [self sortedByField:@"number"];
}

- (NSArray *)sortedByTeam {
    return [self sortedByField:@"team"];
}

@end
