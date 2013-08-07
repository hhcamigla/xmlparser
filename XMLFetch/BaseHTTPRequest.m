//
//  BaseHTTPRequest.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "BaseHTTPRequest.h"
#import "BusinessObject.h"

@implementation BaseHTTPRequest

-(void)clearCache{
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [sharedCache removeCachedResponseForRequest:_request];
    [NSURLCache setSharedURLCache:sharedCache];
    [sharedCache release];
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    return nil;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _nsData = nil;
    if (!_nsData) {
        _nsData = [[NSMutableData data] retain];
        [_nsData setLength:0];
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200) {
        int statuscode = [httpResponse statusCode];
        
        NSString *errString =[NSString stringWithFormat:@"HTTP Error %i : %@", statuscode, [NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]]];
        
        NSLog(@"%@ \n%@ \n%@", errString,[response description], connection.originalRequest.URL);
        

        [[BusinessObject getInstance] displayAlertWithMessage:errString];
        
        [connection cancel];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:kRequestStatusErr,kRequestStatus, nil];
        
        _blockEval( dict );
        
        [self clearCache];
        [_nsData release];

    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_nsData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
    
    if (_nsData) {
        [_nsData release];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:kRequestStatusErr,kRequestStatus, nil];
    
    _blockEval( dict );
    [self clearCache];
    [self release];
}

- (void)dealloc {
    Block_release(_blockEval);
    NSLog(@"Deallocate %@", [[self class] description]);
    [super dealloc];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
	[connection release];
    
    NSDictionary *dict = nil;
    
    dict = [[NSDictionary alloc] initWithObjectsAndKeys:kRequestStatusOK, kRequestStatus, _nsData , kRequestData, nil];
    
    
    _blockEval( dict );
    [self clearCache];
    //[self release];
    
}


@end
