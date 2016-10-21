//
//  MVZTableViewModel.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewModelProtocol.h"
#import "MVZTableViewSectionModel.h"
#import <Foundation/Foundation.h>

@interface MVZTableViewModel : NSObject <MVZTableViewModelProtocol>

@property (nonatomic, readonly) MVZMutableArray<MVZTableViewSectionModel *> *sectionModels;

@end
