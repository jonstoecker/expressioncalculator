//
//  LogicModel.m
//  ExpressionCalculator
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import "LogicModel.h"
#import "DDMathParser.h"

@implementation LogicModel

//
//  Defined constants
//
NSString* const JSErrorMsg = @"error";

//
//  Performs a calculation and returns the result as an NSString value
//  suitable for displaying in the calculator's view window.
//
+(NSString*)calculateExpression:(NSString*)expression
{
    // Parser expects ** instead of ^ for exponential calculations and pi() instead of π
    // So, it's necessary to substitute these characters before calculating.
    NSString* modifiedExpression = [expression stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    modifiedExpression = [modifiedExpression stringByReplacingOccurrencesOfString:@"π" withString:@"pi()"];
    modifiedExpression = [modifiedExpression stringByReplacingOccurrencesOfString:@"e" withString:@"e()"];
    NSString* result = [[modifiedExpression numberByEvaluatingString] stringValue];
    
    if ([result isEqualToString:@"inf"])
        result = JSErrorMsg;
    
    return result;
}

-(void)dealloc
{
    [super dealloc];
}

@end
