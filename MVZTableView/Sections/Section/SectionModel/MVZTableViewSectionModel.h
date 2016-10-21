//
//  MVZTableViewSectionModel.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 26/09/2016.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewSectionModelProtocol.h"
#import "MVZTableViewCellModel.h"
#import <Foundation/Foundation.h>

@class RACSignal;

@interface MVZTableViewSectionModel : NSObject <MVZTableViewSectionModelProtocol>

@property (nonatomic, readonly) MVZMutableArray<MVZTableViewCellModel *> *cellModels;
@property (nonatomic) RACCommand *rac_scrollToCellModelCommand;

@end
