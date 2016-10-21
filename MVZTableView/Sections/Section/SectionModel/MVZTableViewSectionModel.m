//
//  MVZTableViewSectionModel.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewSectionModel.h"
#import "ReactiveCocoa.h"

@interface MVZTableViewSectionModel ()

@property (nonatomic) MVZMutableArray<MVZTableViewCellModel *> *cellModels;

@end
    
@implementation MVZTableViewSectionModel

- (MVZMutableArray<MVZTableViewCellModel *> *)cellModels {
    if (!_cellModels) {
        _cellModels = [MVZMutableArray mvz_array];
    }
    return _cellModels;
}

@end
