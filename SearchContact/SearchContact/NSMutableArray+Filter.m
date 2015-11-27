//
//  NSMutableArray+Filter.m
//  SearchContact
//
//  Created by oucaizi on 15/11/27.
//  Copyright © 2015年 oucaizi. All rights reserved.
//

#import "NSMutableArray+Filter.h"

@implementation NSMutableArray (Filter)

-(NSMutableArray*)filterElement{
    NSMutableSet *set=[NSMutableSet set];
    for (id obj in self) {
        [set addObject:obj];
    }
    [self removeAllObjects];
    for (id obj in set) {
        [self addObject:obj];
    }
    return self;
}

@end
