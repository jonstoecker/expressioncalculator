//
//  Stack.m
//  ExpressionCalculator
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import "Stack.h"

@implementation Stack

- (id)init
{
    if (self = [super init]) {
        stack = [[NSMutableArray alloc] init];
    }
    return self;
}

//
//  Push an item onto the stack
//
- (void)push:(id)element
{
    [stack addObject:element];
}

//
//  Pop an item from the stack
//
- (id)pop
{
    NSUInteger count = [stack count];
    if (count > 0) {
        id returnObject = [[stack objectAtIndex:count - 1] retain];
        [stack removeLastObject];
        return [returnObject autorelease];
    }
    else {
        return nil;
    }
}

- (void)dealloc
{
    [stack release];
    [super dealloc];
}

@end