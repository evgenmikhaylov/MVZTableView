//
//  MVZTableViewCellModelProtocol.h
//  HA_Waterbouw
//
//  Created by Evgeny Mikhaylov on 20/09/16.
//  Copyright © 2016 Igor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;

@protocol MVZTableViewCellModelProtocol <NSObject>

@property (nonatomic) double cellHeight;
@property (nonatomic, readonly) BOOL selected;
@property (nonatomic, readonly) BOOL useDynamicCellHeight;
@property (nonatomic, readonly) RACCommand *rac_cellDidSelectCommand;
@property (nonatomic, readonly) RACCommand *rac_cellDidDeselectCommand;

@end
