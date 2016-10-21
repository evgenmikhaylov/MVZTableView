//
//  MVZTableViewModel.m
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewModel.h"

@interface MVZTableViewModel ()

@property (nonatomic) MVZMutableArray<MVZTableViewSectionModel *> *sectionModels;

@end

@implementation MVZTableViewModel

- (MVZMutableArray<MVZTableViewSectionModel *> *)sectionModels {
    if (!_sectionModels) {
        _sectionModels = [MVZMutableArray mvz_array];
    }
    return _sectionModels;
}

@end
