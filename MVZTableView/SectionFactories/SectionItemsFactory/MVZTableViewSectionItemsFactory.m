//
//  MVZTableViewSectionItemsFactory.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewSectionItemsFactory.h"
#import "MVZTableViewCellItemsFactoryProtocol.h"
#import "MVZTableViewSectionItem.h"

@implementation MVZTableViewSectionItemsFactory

- (NSArray<MVZTableViewSectionItem *> *)sectionItemsForSectionModels:(NSArray<id<MVZTableViewSectionModelProtocol>> *)sectionModels {
    NSMutableArray<MVZTableViewSectionItem *> *sectionItems = [[NSMutableArray alloc] init];
    [sectionModels enumerateObjectsUsingBlock:^(id<MVZTableViewSectionModelProtocol>  _Nonnull sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        MVZTableViewSectionItem *sectionItem = [[MVZTableViewSectionItem alloc] init];
        sectionItem.tableView = self.tableView;
        sectionItem.cellItemsFactory = self.cellItemsFactory;
        sectionItem.sectionModel = sectionModel;
        [sectionItems addObject:sectionItem];
    }];
    return sectionItems;
}

@end
