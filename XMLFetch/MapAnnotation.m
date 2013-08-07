//
//  MapAnnotation.m
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize nameInfo;

-(CLLocationCoordinate2D) coordinate{
    CLLocationCoordinate2D coord;
    
    coord.longitude = [self.longitude doubleValue];
    coord.latitude = [self.latitude doubleValue];
    
    return coord;
}

-(NSString*) title{
    return self.nameInfo;
}

@end
