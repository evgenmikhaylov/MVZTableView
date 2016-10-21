//
//  MVZTableViewCellModel.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 20/09/16.
//  Copyright © 2016 Igor. All rights reserved.
//

#import "MVZTableViewCellModelProtocol.h"
#import <Foundation/Foundation.h>

@class RACCommand;

@interface MVZTableViewCellModel : NSObject <MVZTableViewCellModelProtocol>

@property (nonatomic) double cellHeight;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL useDynamicCellHeight;
@property (nonatomic) RACCommand *rac_cellDidSelectCommand;
@property (nonatomic) RACCommand *rac_cellDidDeselectCommand;

@end
