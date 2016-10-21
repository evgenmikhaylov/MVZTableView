//
//  MVZTableView.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVZTableViewModelProtocol;
@protocol MVZTableViewSectionItemsFactoryProtocol;
@class RSBTableViewManager;

@interface MVZTableView : UITableView

@property (nonatomic, weak) id<MVZTableViewModelProtocol> viewModel;
@property (nonatomic) id<MVZTableViewSectionItemsFactoryProtocol> sectionItemsFactory;

@property (nonatomic, readonly) RSBTableViewManager *manager;

- (void)setTableViewRowAnimation:(UITableViewRowAnimation)animation forChangeType:(NSKeyValueChange)changeType;

@end
