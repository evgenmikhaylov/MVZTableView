//
//  MVZTableViewSectionItem.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewSectionItem.h"
#import "MVZTableViewCellItemsFactoryProtocol.h"
#import "MVZTableViewSectionModelProtocol.h"
#import "MVZTableViewCellItem.h"
#import "MVZTableView.h"

#import <RSBTableViewManager.h>
#import <ReactiveCocoa.h>

@interface MVZTableViewSectionItem ()

@property (nonatomic) NSMutableDictionary<NSNumber *, NSNumber *> *rowAnimations;

@end

@implementation MVZTableViewSectionItem

- (void)setTableViewRowAnimation:(UITableViewRowAnimation)animation forChangeType:(NSKeyValueChange)changeType {
    self.rowAnimations[@(changeType)] = @(animation);
}

#pragma mark - Setters/Getters

- (void)setSectionModel:(id<MVZTableViewSectionModelProtocol>)sectionModel {
    _sectionModel = sectionModel;
    [self bindSectionModel];
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

- (void)bindSectionModel {
    @weakify(self)
    [self.sectionModel.cellModels.mvz_objectsSignal subscribeNext:^(MVZMutableArrayChange<id<MVZTableViewCellModelProtocol>> *change) {
        @strongify(self)
        if (change.mvz_changeType == NSKeyValueChangeSetting) {
            self.cellItems = [self.cellItemsFactory cellItemsForCellModels:change.mvz_objects];
        }
        else {
            UITableViewRowAnimation rowAnimation = self.rowAnimations[@(change.mvz_changeType)].integerValue;
            if (change.mvz_changeType == NSKeyValueChangeInsertion) {
                NSArray<MVZTableViewCellItem *> *cellItems = [self.cellItemsFactory cellItemsForCellModels:change.mvz_newObjects];
                [self.tableView.manager insertCellItems:cellItems
                                          toSectionItem:self
                                              atIndexes:change.mvz_indexes
                                       withRowAnimation:rowAnimation];
            }
            else if (change.mvz_changeType == NSKeyValueChangeRemoval) {
                [self.tableView.manager removeCellItems:[self.cellItems objectsAtIndexes:change.mvz_indexes]
                                        fromSectionItem:self
                                       withRowAnimation:rowAnimation];
            }
            else if (change.mvz_changeType == NSKeyValueChangeReplacement) {
                NSArray<MVZTableViewCellItem *> *cellItems = [self.cellItemsFactory cellItemsForCellModels:change.mvz_newObjects];
                [self.tableView.manager replaceCellItemsAtIndexes:change.mvz_indexes
                                                    withCellItems:cellItems
                                                    inSectionItem:self
                                                 withRowAnimation:rowAnimation];
            }
        }
    }];
    self.sectionModel.rac_scrollToCellModelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(RACTuple *tuple) {
        @strongify(self)
        RACTupleUnpack(id<MVZTableViewCellModelProtocol> cellModel, NSNumber *animatedValue) = tuple;
        return [self rac_scrollToCellModelSignal:cellModel animated:animatedValue.boolValue];
    }];
}

#pragma mark - Signals

- (RACSignal *)rac_scrollToCellModelSignal:(id<MVZTableViewCellModelProtocol>)cellModel animated:(BOOL)animated {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSUInteger sectionIndex = [self.tableView.manager.sectionItems indexOfObject:self];
        NSUInteger rowIndex = [self.cellItems indexOfObject:cellModel];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
        [subscriber sendNext:@YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
