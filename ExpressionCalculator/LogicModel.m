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
//  Performs a calculation and returns the result as an NSString value
//  suitable for displaying in the calculator's view window.
//
+(NSString*)calculateExpression:(NSString *)expression
{
    // Parser expects ** instead of ^ for exponential calculations
    // So, it's necessary to replace all instances of ^ with **
    NSMutableString* modifiedExpression = [expression stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    
    return [[modifiedExpression numberByEvaluatingString] stringValue];;
}



@end
