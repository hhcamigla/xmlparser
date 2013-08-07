//
//  CustomMutableDictionary.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "CustomMutableDictionary.h"

@implementation CustomMutableDictionary

@synthesize childNodes;
@synthesize nodeName;
@synthesize nodeValue;
@synthesize dictionary;

-(id)init{
    self = [super init];
    if (self) {
        self.childNodes = [[NSMutableArray alloc] init];
        self.dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) setParentId:(id)parentId{
    objectParentId = parentId;
}
-(id) getParentId{
    return objectParentId;
}

-(void) addObject:(id)object{
    [self.childNodes addObject:object];
    [object release];
}


-(void) processDictionary{
    
    
    if (self.childNodes.count>0) {

        CustomMutableDictionary *parent = objectParentId;
        
        NSMutableDictionary *dict = [parent.dictionary objectForKey:self.nodeName];
        
        if (!dict) {
            dict = [[NSMutableDictionary alloc] init];;
        }
        
        
        for (CustomMutableDictionary *item in self.childNodes) {
            
            if (item.childNodes.count>0) {
                [item processDictionary];
                [dict addEntriesFromDictionary:item.dictionary];
            }else{
                [dict setObject:item.nodeValue forKey:item.nodeName];
            }
        
        }
        
        [self.dictionary setObject:dict forKey:self.nodeName];
        
    }
    
}

-(void)dealloc{
    [self.childNodes removeAllObjects];
    [self.dictionary release];
    
    self.childNodes = nil;
    self.dictionary = nil;
    
    NSLog(@"Deallocate %@", [[self class] description]);

    [super dealloc];
}

@end
