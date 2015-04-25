//
//  PhotoImageModel.m
//  W8_AsyncURL
//
//  Created by 김성희 on 2015. 4. 25..
//  Copyright (c) 2015년 skim. All rights reserved.
//

#import "PhotoImageModel.h"
#import <UIKit/UIKit.h>

@implementation PhotoImageModel

- (id)initWithItem:(NSMutableDictionary *)item {
    self = [super init];
    
    _item = item;
    
    return self;
}

- (void)loadImage {
    // Create the request.
    NSString *imageString = [_item objectForKey:@"image"];

    if ([imageString hasPrefix:@"http://"]) {
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:imageString]
                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                           timeoutInterval:5.0];
        
        // Create url connection and fire request
        (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:imageString ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [_item setObject:image forKey:@"imageData"];
    }
}

- (void)postLoadImageNotification:(NSString *)file {
    NSDictionary *noti;
    
    noti = [[NSDictionary alloc] initWithObjectsAndKeys:file, @"file", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadImage" object:nil userInfo:noti];
}

- (NSString *)fileNameFromUrl:(NSString *)url {
    NSRange range = [url rangeOfString:@"/" options:NSBackwardsSearch];

    return [url substringFromIndex:range.location + 1];
}

#pragma mark - NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *url = [[[connection currentRequest] URL] absoluteString];
    
    // Get the docs directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    // Write the file
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[self fileNameFromUrl:url]];
    [_responseData writeToFile:filePath atomically:YES];

    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    [_item setObject:image forKey:@"imageData"];
   
    [self postLoadImageNotification:filePath];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
