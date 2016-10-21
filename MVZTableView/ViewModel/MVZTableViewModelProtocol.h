//
//  MVZTableViewModelProtocol.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVZMutableArray.h"

@protocol MVZTableViewSectionModelProtocol;

@protocol MVZTableViewModelProtocol <NSObject>

@property (nonatomic, readonly) MVZMutableArray<id<MVZTableViewSectionModelProtocol>> *sectionModels;

@end
