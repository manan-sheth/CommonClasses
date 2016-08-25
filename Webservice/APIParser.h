//
//  APIParser.h
//  OWNOWApp
//
//  Created by esharsh on 21/07/16.
//  Copyright © 2016 Esha. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIConstants.h"
#import <objc/runtime.h>

typedef void (^responseBlock) (bool status, NSError *error, id objects, NSString *responseString);

typedef enum {
    
    GET,
    POST
    
} APIType;

enum ResponseStatus
{
    NoResponse = 0,
    Valid = 1,
    Invalid = 2
};

#define Success                     @"1"
#define InvalidResponse      @"2"
#define Failure                        @"3"

@interface APIParser : NSObject

@property (strong) NSOperationQueue *wsOperationQueue;

+ (id)sharedMediaServer;

- (NSData *)dictionaryWithPropertiesOfObject:(id)obj;
- (NSData *)dictionaryWithMembersOfObject:(id)obj forMembers:(NSArray *)members;
- (NSData *)dictionaryToJSONData:(NSDictionary *)dict;

//- (NSMutableURLRequest *)urlRequestForURL:(NSURL *)url withObjects:(NSData *)objData isObject:(bool)customObj;

- (NSMutableURLRequest *)urlRequestForPOSTURL:(NSURL *)url withObjects:(NSData *)objData isObject:(bool)customObj;
- (NSMutableURLRequest *)urlRequestForGETURL:(NSURL *)url;
@end
