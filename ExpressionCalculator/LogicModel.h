//
//  LogicModel.h
//  ExpressionCalculator
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

@interface LogicModel : NSObject
{
    Stack* stack;
}

-(NSString*)calculateExpression:(NSString*)expression isFinal:(BOOL)final;
-(NSString*)recall;

@end
