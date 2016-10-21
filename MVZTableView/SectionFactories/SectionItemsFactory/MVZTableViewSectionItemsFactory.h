//
//  MVZTableViewSectionItemsFactory.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewSectionItemsFactoryProtocol.h"
#import <Foundation/Foundation.h>

@protocol MVZTableViewCellItemsFactoryProtocol;
@class MVZTableView;

@interface MVZTableViewSectionItemsFactory : NSObject <MVZTableViewSectionItemsFactoryProtocol>

@property (nonatomic) id<MVZTableViewCellItemsFactoryProtocol> cellItemsFactory;
@property (nonatomic, weak) MVZTableView *tableView;

@end
