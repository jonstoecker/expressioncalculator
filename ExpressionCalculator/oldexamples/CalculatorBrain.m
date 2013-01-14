//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Jonathan Stoecker on 8/15/11.
//  Copyright 2011 Jon Stoecker. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize operand;

-(void)performWaitingOperation {
    /*
     * Used to handle multiple digit entry for each term and 
     * permit the user to perform several operations in sequence.
     */
    if ([@"+" isEqual:waitingOperation]) {
        operand += waitingOperand;
    } else if ([@"-" isEqual:waitingOperation]) {
        operand = waitingOperand - operand;
    } else if ([@"x" isEqual:waitingOperation]) {
        operand *= waitingOperand;
    } else if ([@"/" isEqual:waitingOperation]) {
        if (operand) {
            operand = waitingOperand / operand;
            
        }
    }
}

-(double)performOperation:(NSString *) operation {
    /*
     * Executes single term operations (i.e. =, sin, cos, invert) and
     * memory operations (i.e. store, recall, mem+).
     */
    if ([operation isEqual:@"sqrt"]){
        operand = sqrt(operand);
    } else if ([operation isEqual:@"sin"]) {
        operand = sin(operand);
    } else if ([operation isEqual:@"cos"]) {
        operand = cos(operand);
    } else if ([operation isEqual:@"( - )"]) {
        operand *= -1;
    } else if ([operation isEqual:@"1/x"]) {
        // inverts displayed value
        if (operand != 0)
            operand = (1/operand);
    } else if ([operation isEqual:@"sto"]) {
        // stores display value in memory
        storedOperand = operand;
    } else if ([operation isEqual:@"rcl"]) {
        // recalls stored memory value
        if (storedOperand)    
            operand = storedOperand;
    } else if ([operation isEqual:@"mem+"]) {
        // adds displayed value to stored memory value
        if (storedOperand)
            storedOperand += operand;
    } else if ([operation isEqual:@"C"]) {
        // clears all values and waiting operations
        operand = 0;
        storedOperand = 0;
        waitingOperation = nil;
    }
    else {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    
    return operand;
}

-(BOOL)testValidity:(NSString*) operation {
    if ( ( [operation isEqual:@"1/x"] || [operation isEqual:@"/"] ) 
        && (operand == 0) )
        return NO;
    
    return YES;
}

@end
