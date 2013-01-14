//
//  Stack.h
//  ExpressionCalculator
//
//  Stack wrapper for NSMutableArray
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
    NSMutableArray* stack;
}

-(void)push:(id)object;
-(id)pop;

@end
