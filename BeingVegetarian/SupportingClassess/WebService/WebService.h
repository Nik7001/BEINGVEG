//
//  WebService.h

//  Trunks
//
//  Created by Nitin Saklecha on 05/09/18.
//  Copyright © 2018 Arnasoftech. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT
};

typedef void(^RequestCompletion)(NSDictionary<NSString *, id> *dictResponse, NSError *error, NSString *theReply, NSUInteger statusCode);

@interface WebService : NSObject

+ (NSData *)encodeDictionary:(NSDictionary*) dictionary;
+ (void)createRequestAndGetResponse:(NSString *) strUrl methodType:(HTTPMethod) method andHeaderDict:(NSDictionary *) dictHeader andParameterDict:(NSDictionary *) dictParameters onCompletion:(RequestCompletion) completed;
+ (void)createRequestForImageAndGetResponse:(NSString *) strUrl methodType:(HTTPMethod) method andHeaderDict:(NSDictionary *) dictHeader andParameterDict:(NSDictionary *) dictParameters andImageNameAsKeyAndImageAsItsValue:(NSDictionary<NSString *, UIImage *> *) dictImages onCompletion:(RequestCompletion) completed;
+ (void)createRequestForNodeJSAndGetResponse:(NSString *) strUrl methodType:(HTTPMethod) method andHeaderDict:(NSDictionary *) dictHeader andParameterDict:(NSDictionary *) dictParameters onCompletion:(RequestCompletion) completed;
+ (NSDictionary<NSString *, id> *)getDictionaryFromResponseObject:(id) responseObject;
@end
