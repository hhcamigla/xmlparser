//
//  CustomMutableDictionary.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomMutableDictionary : NSObject{
    id objectParentId;
}

@property (nonatomic, retain) NSMutableArray *childNodes;
@property (nonatomic, retain) NSString *nodeName;
@property (nonatomic, retain) NSString *nodeValue;
@property (nonatomic, retain) NSMutableDictionary *dictionary;

-(void) addObject:(id)object;
-(void) setParentId:(id)parentId;
-(id) getParentId;
-(void) processDictionary;

@end
