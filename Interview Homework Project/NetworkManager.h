//
//  NetworkManager.h
//  Interview Homework Project
//
//  Created by Ricardo on 6/16/15.
//  Copyright (c) 2015 Applaudo Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkManagerDelegate <NSObject>

@optional

-(void)networkManagerDidRecieveData:(id)responseObject;
-(void)networkManagerDidFailWithError:(NSError*)error;

@end

@interface NetworkManager : NSObject
-(void)requestDataFromURL:(NSURL *)url;
@property (assign) id<NetworkManagerDelegate> delegate;
@end
