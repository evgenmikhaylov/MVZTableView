//
//  MVZTableViewCellItem.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 20/09/16.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewCellItem.h"

#import "MVZTableViewCellModelProtocol.h"

#import "ReactiveCocoa+Extension.h"
#import "RACChannel+Extension.h"

@interface MVZTableViewCellItem ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) UITableViewCell *dynamicHeightCell;

@end

@implementation MVZTableViewCellItem

#pragma mark - Setters/Getters

- (void)setCellModel:(id<MVZTableViewCellModelProtocol>)cellModel {
    _cellModel = cellModel;
    [self bindCellModel];
}

- (UITableViewCell *)cell {
    if (!self.tableView || !self.indexPath) {
        return nil;
    }
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    return cell;
}

- (UITableViewCell *)dynamicHeightCell {
    if (!_dynamicHeightCell) {
        _dynamicHeightCell = [[self.registeredTableViewCellClass alloc] init];
    }
    return _dynamicHeightCell;
}

#pragma mark - Binding

- (void)bindCellModel {
    [self bindCellModelSelection];
}

- (void)bindCellModelSelection {
    @weakify(self)
    RACSignal *didSelectSignal = [[[self rac_signalForSelector:@selector(didSelectInTableView:atIndexPath:)] map:^id(id value) {
        @strongify(self)
        return @(!self.cellModel.selected);
    }] takeUntil:self.rac_willDeallocSignal];
    RACSignal *didDeselectSignal = [[[self rac_signalForSelector:@selector(didDeselectInTableView:atIndexPath:)] map:^id(id value) {
        return @NO;
    }] takeUntil:self.rac_willDeallocSignal];
    RACChannelTerminal *firstChannelTerminal = RACChannelTo(self.cellModel, selected);
    RACChannelTerminal *secondChannelTerminal =
    [RACChannel channelTerminalWithSignal:[RACSignal merge:@[didSelectSignal, didDeselectSignal]] nextBlock:^(id x) {
        @strongify(self)
        if (self.tableView && self.indexPath) {
            if ([x boolValue]) {
                [self.tableView selectRowAtIndexPath:self.indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            } else {
                [self.tableView deselectRowAtIndexPath:self.indexPath animated:NO];
            }
        }
    }];
    RACChannelTwoWayBinding(firstChannelTerminal, secondChannelTerminal);
}

#pragma mark - RSBItemProtocol

- (void)configureCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [super configureCell:(id)cell inTableView:tableView atIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView = tableView;
    self.indexPath = indexPath;
    if (self.cellModel.selected) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (CGFloat)heightInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if (self.cellModel.useDynamicCellHeight) {
        [self configureCell:self.dynamicHeightCell inTableView:tableView atIndexPath:indexPath];
        CGSize size = [self.dynamicHeightCell sizeThatFits:CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX)];
        self.cellModel.cellHeight = size.height + 1.0;
        return self.cellModel.cellHeight;
    }
    else {
        return self.cellModel.cellHeight;
    }
}

- (Class)registeredTableViewCellClass {
    return [UITableViewCell class];
}

- (void)didSelectInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if (self.cellModel.selected) {
        if (tableView.allowsMultipleSelection) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            [[self.cellModel rac_cellDidDeselectCommand] execute:self.cellModel];
        }
    }
    else {
        [[self.cellModel rac_cellDidSelectCommand] execute:self.cellModel];
    }
}

- (void)didDeselectInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    [[self.cellModel rac_cellDidDeselectCommand] execute:self.cellModel];
}

@end
