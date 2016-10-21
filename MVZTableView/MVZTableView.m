//
//  MVZTableView.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableView.h"
#import "MVZTableViewModelProtocol.h"
#import "MVZTableViewSectionItemsFactoryProtocol.h"
#import "MVZTableViewSectionItem.h"
#import <RSBTableViewManager.h>
#import <ReactiveCocoa.h>

@interface MVZTableView ()

@property (nonatomic) RSBTableViewManager *manager;
@property (nonatomic) NSMutableDictionary<NSNumber *, NSNumber *> *rowAnimations;

@end

@implementation MVZTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (void)setTableViewRowAnimation:(UITableViewRowAnimation)animation forChangeType:(NSKeyValueChange)changeType {
    self.rowAnimations[@(changeType)] = @(animation);
}

#pragma mark - Setters/Getters

- (void)setViewModel:(id<MVZTableViewModelProtocol>)viewModel {
    _viewModel = viewModel;
    [self bindViewModel];
}

- (void)setSectionItemsFactory:(id<MVZTableViewSectionItemsFactoryProtocol>)sectionItemsFactory {
    _sectionItemsFactory = sectionItemsFactory;
    _sectionItemsFactory.tableView = self;
}


- (RSBTableViewManager *)manager {
    if (!_manager) {
        _manager = [[RSBTableViewManager alloc] initWithTableView:self];
    }
    return _manager;
}

- (NSMutableDictionary *)rowAnimations {
    if (!_rowAnimations) {
        _rowAnimations = [[NSMutableDictionary alloc] init];
        _rowAnimations[@(NSKeyValueChangeSetting)] = @(UITableViewRowAnimationAutomatic);
        _rowAnimations[@(NSKeyValueChangeInsertion)] = @(UITableViewRowAnimationAutomatic);
        _rowAnimations[@(NSKeyValueChangeRemoval)] = @(UITableViewRowAnimationAutomatic);
        _rowAnimations[@(NSKeyValueChangeReplacement)] = @(UITableViewRowAnimationAutomatic);
    }
    return _rowAnimations;
}

#pragma mark - Binding

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.sectionModels.mvz_objectsSignal subscribeNext:^(MVZMutableArrayChange<id<MVZTableViewSectionModelProtocol>> *change) {
        @strongify(self)
        if (change.mvz_changeType == NSKeyValueChangeSetting) {
            self.manager.sectionItems = [self.sectionItemsFactory sectionItemsForSectionModels:change.mvz_objects];
        }
        else {
            UITableViewRowAnimation rowAnimation = self.rowAnimations[@(change.mvz_changeType)].integerValue;
            if (change.mvz_changeType == NSKeyValueChangeInsertion) {
                NSArray<MVZTableViewSectionItem *> *sectionItems = [self.sectionItemsFactory sectionItemsForSectionModels:change.mvz_newObjects];
                [self.manager insertSectionItems:sectionItems
                                       atIndexes:change.mvz_indexes
                                withRowAnimation:rowAnimation];
            }
            else if (change.mvz_changeType == NSKeyValueChangeRemoval) {
                [self.manager removeSectionItems:[self.manager.sectionItems objectsAtIndexes:change.mvz_indexes]
                                withRowAnimation:rowAnimation];
            }
            else if (change.mvz_changeType == NSKeyValueChangeReplacement) {
                NSArray<MVZTableViewSectionItem *> *sectionItems = [self.sectionItemsFactory sectionItemsForSectionModels:change.mvz_newObjects];
                [self.manager replaceSectionItemsAtIndexes:change.mvz_indexes
                                          withSectionItems:sectionItems
                                              rowAnimation:rowAnimation];
            }
        }
    }];
}

@end
