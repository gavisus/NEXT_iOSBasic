//
//  SKIMDataModel.m
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 17..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (id)init {
    self = [super init];

    char *jsonData = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},"
        "{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},"
        "{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},"
        "{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},"
        "{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},"
        "{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},"
        "{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},"
        "{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},"
        "{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
    
    if (self != nil) {
        NSError *error = nil;
        NSString *jsonString = [NSString stringWithUTF8String:jsonData];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:0
                                                                       error:&error];
    
        _orgData = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in parsedObject) {
            [_orgData addObject:dict];
        }
        
        _list = _orgData;
    }

    return self;
}

- (void)sort {
    NSString *field = @"date";

    NSArray *sortedArray = [_orgData sortedArrayUsingComparator:^(NSDictionary *obj1, NSDictionary *obj2) {
        return [[obj1 objectForKey:field] compare:[obj2 objectForKey:field]];
    }];

    _list = [[NSMutableArray alloc] initWithArray:sortedArray];
    
    [self postNotificationWithMode:@"sort"];
}

- (void)restore {
    _list = _orgData;
    
    [self postNotificationWithMode:@"reset"];
}

- (void)deleteWithItem:(id)item {
    [_orgData removeObject:item];
    [_list removeObject:item];

    [self postNotificationWithMode:@"keep"];
}

- (void)postNotificationWithMode:(NSString *)mode {
    NSDictionary *noti;
    
    noti = [[NSDictionary alloc] initWithObjectsAndKeys:mode, @"mode", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil userInfo:noti];
}

@end
