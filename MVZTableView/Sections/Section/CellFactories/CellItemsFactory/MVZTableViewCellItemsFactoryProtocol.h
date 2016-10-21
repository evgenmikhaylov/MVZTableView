//
//  MVZTableViewCellItemsFactoryProtocol.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVZTableViewCellModelProtocol;
@class MVZTableViewCellItem;

@protocol MVZTableViewCellItemsFactoryProtocol <NSObject>

- (NSArray<MVZTableViewCellItem *> *)cellItemsForCellModels:(NSArray<id<MVZTableViewCellModelProtocol>> *)sectionModels;

@end
