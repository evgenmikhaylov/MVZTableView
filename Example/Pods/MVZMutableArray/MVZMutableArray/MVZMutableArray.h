//
//  MVZMutableArray.h
//  MVZMutableArray, https://github.com/medvedzzz/MVZMutableArray
//
//  Created by Evgeny Mikhaylov on 22/03/16.
//  Copyright © 2016 Evgeny Mikhaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface MVZMutableArray<__covariant ObjectType> : NSObject

@property (nonatomic, copy) NSArray<ObjectType> *mvz_objects;
@property (nonatomic, readonly) RACSignal *mvz_objectsSignal;

+ (instancetype)mvz_array;
+ (instancetype)mvz_arrayWithObjects:(NSArray<ObjectType> *)objects;

- (void)mvz_addObject:(ObjectType)object;
- (void)mvz_insertObject:(ObjectType)object atIndex:(NSUInteger)index;
- (void)mvz_removeObjectAtIndex:(NSUInteger)index;
- (void)mvz_removeObject:(ObjectType)object;

- (void)mvz_addObjects:(NSArray<ObjectType> *)objects;
- (void)mvz_insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexes;
- (void)mvz_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<ObjectType> *)objects;
- (void)mvz_removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)mvz_removeObjects:(NSArray<ObjectType> *)objects;
- (void)mvz_removeAllObjects;

- (void)mvz_linkWithArray:(MVZMutableArray *)array map:(id (^)(id value))mapBlock;

@end

@interface MVZMutableArrayChange<__covariant ObjectType> : NSObject

@property (nonatomic, copy) NSArray<ObjectType> *mvz_objects;
@property (nonatomic, copy) NSArray<ObjectType> *mvz_newObjects;
@property (nonatomic, copy) NSArray<ObjectType> *mvz_oldObjects;
@property (nonatomic, copy) NSIndexSet *mvz_indexes;
@property (nonatomic) NSKeyValueChange mvz_changeType;

@end
