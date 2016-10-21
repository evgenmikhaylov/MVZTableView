//
//  MVZTableViewSectionItem.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <RSBTableViewSectionItem.h>

@protocol MVZTableViewCellItemsFactoryProtocol;
@protocol MVZTableViewSectionModelProtocol;
@class MVZTableView;

@interface MVZTableViewSectionItem : RSBTableViewSectionItem

- (void)setTableViewRowAnimation:(UITableViewRowAnimation)animation forChangeType:(NSKeyValueChange)changeType;

@property (nonatomic) id<MVZTableViewCellItemsFactoryProtocol> cellItemsFactory;
@property (nonatomic, weak) id<MVZTableViewSectionModelProtocol> sectionModel;
@property (nonatomic, weak) MVZTableView *tableView;

@end
