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

-(LogicModel*)init
{
    return self;
}
//
//  Defined constants
//
NSString* const JSErrorMsg = @"error";


//
//  Performs a calculation and returns the result as an NSString value
//  suitable for displaying in the calculator's view window.
//
-(NSString*)calculateExpression:(NSString*)expression
{
    // Parser expects ** instead of ^ for exponential calculations and * instead of x for multiplication
    // So, it's necessary to substitute these characters before calculating.
    // I've chosen to use multiple runs of the function for readability purposes.
    NSString* modifiedExpression = [expression stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    modifiedExpression = [modifiedExpression stringByReplacingOccurrencesOfString:@"x" withString:@"*"];
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
