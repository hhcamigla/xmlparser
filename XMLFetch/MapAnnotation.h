//
//  MapAnnotation.h
//  XMLFetch
//
//  Created by Harry Herrys Camigla on 8/6/13.
//  Copyright (c) 2013 Harry Herrys Camigla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>{
    
}

@property (nonatomic, retain) NSString *nameInfo;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *identifier;

@end
