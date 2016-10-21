//
//  MVZTableViewSectionModelProtocol.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVZMutableArray.h"

@protocol MVZTableViewCellModelProtocol;
@class RACCommand;

@protocol MVZTableViewSectionModelProtocol <NSObject>

@property (nonatomic, readonly) MVZMutableArray<id<MVZTableViewCellModelProtocol>> *cellModels;
@property (nonatomic) RACCommand *rac_scrollToCellModelCommand;

@end
