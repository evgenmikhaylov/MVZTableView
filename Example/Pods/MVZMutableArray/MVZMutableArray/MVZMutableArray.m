//
//  MVZMutableArray.m
//  MVZMutableArray, https://github.com/medvedzzz/MVZMutableArray
//
//  Created by Evgeny Mikhaylov on 22/03/16.
//  Copyright © 2016 Evgeny Mikhaylov. All rights reserved.
//

#import "MVZMutableArray.h"
#import "ReactiveCocoa.h"

@interface MVZMutableArray ()

@property (nonatomic, readonly) NSMutableArray *mvz_observableObjects;

@end

@implementation MVZMutableArray

#pragma mark - Initialize

+ (instancetype)mvz_array {
    
    return [[self alloc] init];
}

+ (instancetype)mvz_arrayWithObjects:(NSArray *)objects {
    
    MVZMutableArray *array = [self mvz_array];
    array.mvz_objects = objects;
    return array;
}

#pragma mark - Setters/Getters

- (NSArray *)mvz_objects {
    
    if (!_mvz_objects) {
        _mvz_objects = [[NSArray alloc] init];
    }
    return _mvz_objects;
}

- (NSMutableArray *)mvz_observableObjects {
    
    return [self mutableArrayValueForKey:@keypath(self, mvz_objects)];
}

- (RACSignal *)mvz_objectsSignal {
    
    return [[[self rac_valuesAndChangesForKeyPath:@keypath(self, mvz_objects)
                                          options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                         observer:nil] map:^id(RACTuple *value) {
        MVZMutableArrayChange *change = [[MVZMutableArrayChange alloc] init];
        change.mvz_objects = value.first;
        change.mvz_changeType = [value.second[NSKeyValueChangeKindKey] unsignedIntegerValue];
        change.mvz_newObjects = value.second[NSKeyValueChangeNewKey];
        change.mvz_oldObjects = value.second[NSKeyValueChangeOldKey];
        change.mvz_indexes = value.second[NSKeyValueChangeIndexesKey];
        return change;
    }] startWith:[self initialObjectsSignalValue]];
}

- (MVZMutableArrayChange *)initialObjectsSignalValue {
    MVZMutableArrayChange *change = [[MVZMutableArrayChange alloc] init];
    change.mvz_objects = self.mvz_objects;
    change.mvz_changeType = NSKeyValueChangeSetting;
    change.mvz_oldObjects = self.mvz_objects;
    return change;
}

#pragma mark - Object

- (void)mvz_addObject:(id)object {

    [self.mvz_observableObjects addObject:object];
}

- (void)mvz_insertObject:(id)object atIndex:(NSUInteger)index {

    [self.mvz_observableObjects insertObject:object atIndex:index];
}

- (void)mvz_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    
    [self.mvz_observableObjects replaceObjectAtIndex:index withObject:object];
}

- (void)mvz_removeObjectAtIndex:(NSUInteger)index {

    [self.mvz_observableObjects removeObjectAtIndex:index];
}

- (void)mvz_removeObject:(id)object {

    [self.mvz_observableObjects removeObject:object];
}

#pragma mark - Objects

- (void)mvz_addObjects:(NSArray *)objects {
    
    NSUInteger location = self.mvz_objects.count;
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(location, objects.count)];
    [self.mvz_observableObjects insertObjects:objects atIndexes:indexes];
}

- (void)mvz_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {

    [self.mvz_observableObjects insertObjects:objects atIndexes:indexes];
}

- (void)mvz_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {

    [self.mvz_observableObjects replaceObjectsAtIndexes:indexes withObjects:objects];
}

- (void)mvz_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    
    [self.mvz_observableObjects removeObjectsAtIndexes:indexes];
}

- (void)mvz_removeObjects:(NSArray *)objects {

    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.mvz_objects containsObject:obj]) {
            [indexes addIndex:[self.mvz_objects indexOfObject:obj]];
        }
    }];
    [self.mvz_observableObjects removeObjectsAtIndexes:indexes];
}

- (void)mvz_removeAllObjects {
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.mvz_objects.count)];
    [self.mvz_observableObjects removeObjectsAtIndexes:indexes];
}

#pragma mark - Objects

- (void)mvz_linkWithArray:(MVZMutableArray *)array map:(id (^)(id value))mapBlock {
    
    [self.mvz_objectsSignal subscribeNext:^(MVZMutableArrayChange *change) {
        switch (change.mvz_changeType) {
            case NSKeyValueChangeSetting:
                array.mvz_objects = [[change.mvz_newObjects.rac_sequence map:mapBlock] array];
                break;
            case NSKeyValueChangeInsertion:
                [array mvz_insertObjects:[[change.mvz_newObjects.rac_sequence map:mapBlock] array] atIndexes:change.mvz_indexes];
                break;
            case NSKeyValueChangeRemoval:
                [array mvz_removeObjectsAtIndexes:change.mvz_indexes];
                break;
            case NSKeyValueChangeReplacement:
                [array mvz_replaceObjectsAtIndexes:change.mvz_indexes withObjects:[[change.mvz_newObjects.rac_sequence map:mapBlock] array]];
                break;
        }
    }];
}

@end

@implementation MVZMutableArrayChange

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\nobjects = %@,\nchangeType = %lu,\nnewObjects = %@,\noldObjects = %@,\nindexes = %@",
            self.mvz_objects, (unsigned long)self.mvz_changeType, self.mvz_newObjects, self.mvz_oldObjects, self.mvz_indexes];
}

@end

