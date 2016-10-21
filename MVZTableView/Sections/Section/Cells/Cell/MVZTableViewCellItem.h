//
//  MVZTableViewCellItem.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 20/09/16.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <RSBTableViewCellItem.h>

@protocol MVZTableViewCellModelProtocol;

@interface MVZTableViewCellItem : RSBTableViewCellItem

@property (nonatomic, weak) id<MVZTableViewCellModelProtocol> cellModel;
@property (nonatomic, readonly) UITableViewCell *cell;

- (void)bindCellModel;

@end
