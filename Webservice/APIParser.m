//
//  APIParser.m
//  OWNOWApp
//
//  Created by esharsh on 21/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import "APIParser.h"

@implementation APIParser

@synthesize wsOperationQueue = _wsOperationQueue;

#pragma mark - Init Method

- (id)init
{
    if ((self = [super init])) {
        
        _wsOperationQueue = [[NSOperationQueue alloc] init];
        _wsOperationQueue.maxConcurrentOperationCount = 5;
        
//        if (IOS_NEWER_OR_EQUAL_TO_X(8.0)) {
//            
//            _wsOperationQueue.qualityOfService = NSQualityOfServiceBackground;
//        }
        
        [_wsOperationQueue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    APIParser *parser = [APIParser sharedMediaServer];
    
    if (object == parser.wsOperationQueue && [keyPath isEqualToString:@"operations"]) {
        
        if ([parser.wsOperationQueue operationCount] == 0) {
            
//            ShowNetworkIndicator(0);
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
        }
    }
    else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - API

+ (id)sharedMediaServer
{
    static dispatch_once_t onceToken;
    static id sharedMediaServer = nil;
    
    dispatch_once(&onceToken, ^{
        sharedMediaServer = [[[self class] alloc] init];
    });
    
    return sharedMediaServer;
}

#pragma mark - Type Casting

- (NSData *)dictionaryWithPropertiesOfObject:(id)obj
{
    NSArray *aVoidArray =@[@"NSDate"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if (![aVoidArray containsObject: key] )
        {
            if ([obj valueForKey:key]!=nil)
            {
                [dict setObject:[obj valueForKey:key] forKey:key];
            }
        }
    }
    NSLog(@"Dict %@",dict);
    free(properties);
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    
    if (jsonError!=nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSData *)dictionaryToJSONData:(NSDictionary *)dict
{
    //    NSLog(@"Dict %@",dict);
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    
    if (jsonError != nil)
    {
        return nil;
    }
    return jsonData;
}

- (NSData *)dictionaryWithMembersOfObject:(id)obj forMembers:(NSArray *)members
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *memberKey in members)
    {
        if (memberKey.length > 0) {
            
            if ([obj valueForKey:memberKey] != nil) {
                
                [dict setObject:[obj valueForKey:memberKey] forKey:memberKey];
            }
        }
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&error];
    
    return error ? nil : jsonData;
}

#pragma mark - Post Request

- (NSMutableURLRequest *)urlRequestForURL:(NSURL *)url forType:(APIType)type withObjects:(NSData *)objData isObject:(bool)customObj
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:DEFAULT_TIMEOUT];
    
    if (type == GET) {
        
        [request setHTTPMethod:@"GET"];
    }
    else {
        
           if (customObj) {
            
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        else {
            
            [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        
        [request setHTTPMethod:@"POST"];
        [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    }
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //Check for Cookies
    [request setHTTPShouldHandleCookies:false];
    [request setHTTPBody:objData];
    
    return  request;
}

- (NSMutableURLRequest *)urlRequestForPOSTURL:(NSURL *)url withObjects:(NSData *)objData isObject:(bool)customObj
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:DEFAULT_TIMEOUT];
    
    if (customObj) {
        
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    else {
        
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    //Check for Cookies
    [request setHTTPShouldHandleCookies:false];
    [request setHTTPBody:objData];
    
    return  request;
}


- (NSMutableURLRequest *)urlRequestForGETURL:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:DEFAULT_TIMEOUT];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"GET"];
    
    [request setHTTPShouldHandleCookies:false];
    
    
    return  request;
}


@end
