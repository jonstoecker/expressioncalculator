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

}

-(NSString*)calculateExpression:(NSString*)expression;

extern NSString* const JSErrorMsg;

@end
