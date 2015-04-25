//
//  SKIMDataModel.m
//  MidTerm
//
//  Created by 김성희 on 2015. 4. 17..
//  Copyright (c) 2015년 skim. All rights reserved.
//
#import "PhotoModel.h"
#import "PhotoImageModel.h"
#import "reachability.h"

static NSString *apiServer = @"http://125.209.194.123/json.php";

@implementation PhotoModel

- (id)init {
    self = [super init];
    
    if (self != nil) {
        NSError *error = nil;
        
        NSData *data = [self getData];
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&error];
        if (error == nil) {
            _orgData = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in parsedObject) {
                [_orgData addObject:[dict mutableCopy]];
            }
        }
        
        _list = _orgData;

        // get image file
        for (int i = 0; i < _list.count; i++) {
            PhotoImageModel *photoImageModel = [[PhotoImageModel alloc] initWithItem:_list[i]];
            
            [photoImageModel loadImage];
        }
    }

    return self;
}

- (NSData *)getData {
    NetworkStatus internetReachability = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];

    // dara from local
    if (internetReachability == NotReachable) {
        char *jsonChar = "[{\"title\":\"Local 초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},"
        "{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},"
        "{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},"
        "{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},"
        "{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},"
        "{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},"
        "{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},"
        "{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},"
        "{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
        NSString *jsonString = [NSString stringWithUTF8String:jsonChar];
        
        return [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    }

    // data from internet
    NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiServer]];
    NSURLResponse *response = nil;
    
    return [NSURLConnection sendSynchronousRequest:request
                                 returningResponse:&response
                                             error:&error];
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
