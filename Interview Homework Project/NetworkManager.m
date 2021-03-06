//
//  NetworkManager.m
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkManager

-(void)requestDataFromURL:(NSURL *)url andCompletionHandler:(void (^)(bool success, id responseObject, NSError *error))completionHandler{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [_delegate networkManagerDidRecieveData:responseObject];
        completionHandler(YES, responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [_delegate networkManagerDidFailWithError:error];
        completionHandler(NO, nil, error);
    }];
    
    [operation start];
    
    
}

@end
