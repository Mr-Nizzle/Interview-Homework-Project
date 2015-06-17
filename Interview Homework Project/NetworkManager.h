//
//  NetworkManager.h
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

-(void)requestDataFromURL:(NSURL *)url andCompletionHandler:(void (^)(bool success, id responseObject, NSError *error))completionHandler;

@end
