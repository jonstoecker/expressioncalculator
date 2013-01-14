//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Jonathan Stoecker on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
// member variables
@private
    double operand,
           waitingOperand,
           storedOperand;
    NSString* waitingOperation;
}

// member methods
@property double operand;
-(double)performOperation:(NSString *)operation;
-(BOOL)testValidity:(NSString*) operation;

@end
