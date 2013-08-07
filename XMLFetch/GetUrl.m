//
//  GetUrl.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "GetUrl.h"

@implementation GetUrl

-(void) getUrContentFromUrl:(NSString*)url withCompletionBlock:(CompletionBlock) block{

    _blockEval = [block copy];
    
    NSURL *urlObject = [NSURL URLWithString:url];
    
    _request = [ [ NSMutableURLRequest alloc ] initWithURL: urlObject cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:160.0f ];
    
    [[NSURLConnection alloc] initWithRequest: _request delegate: self ];

}

@end
