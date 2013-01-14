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
    if (self = [super init]) {
        stack = [[Stack alloc] init];
    }
    return self;
}

//
//  Performs a calculation and returns the result as an NSString value
//  suitable for displaying in the calculator's view window.
//
-(NSString*)calculateExpression:(NSString*)expression isFinal:(BOOL)final
{
    // Parser expects ** instead of ^ for exponential calculations
    // So, it's necessary to replace all instances of ^ with **
    NSString* modifiedExpression = [expression stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    NSString* result = [[modifiedExpression numberByEvaluatingString] stringValue];
    
    if (final && result)
        [stack push:modifiedExpression];
    
    return result;
}

//
//  Pulls the most recent expression from the stack and returns it.
//
-(NSString*)recall
{
    return [stack pop];
}

-(void)dealloc
{
    [stack release];
    [super dealloc];
}

@end
