//
//  MVZTableViewSectionItemsFactoryProtocol.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVZTableViewSectionModelProtocol;
@class MVZTableViewSectionItem;
@class MVZTableView;

@protocol MVZTableViewSectionItemsFactoryProtocol <NSObject>

@property (nonatomic, weak) MVZTableView *tableView;

- (NSArray<MVZTableViewSectionItem *> *)sectionItemsForSectionModels:(NSArray<id<MVZTableViewSectionModelProtocol>> *)sectionModels;

@end
