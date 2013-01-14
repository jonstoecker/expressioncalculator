//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Jonathan Stoecker on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        // init sounds
        NSURL* clickSoundURL = [NSURL fileURLWithPath:
                                [NSString stringWithFormat:@"%@/click.aiff", 
                                 [[NSBundle mainBundle] resourcePath]]];
        
        AudioServicesCreateSystemSoundID((CFURLRef) clickSoundURL, &clickSoundSSID);
    }
    return self;
}

-(CalculatorBrain *) brain {
    if (!brain) {
        brain = [[CalculatorBrain alloc] init];
    }
    return brain;
}

-(IBAction)digitPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(clickSoundSSID);
    
    NSString* digit = [[sender titleLabel] text];
    
    if (userIsEnteringData) {
        [display setText:[[display text] stringByAppendingString:digit]];
    } else {
        [display setText:digit];
        userIsEnteringData = YES;
    }
}

-(IBAction)operationPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(clickSoundSSID);
    
    if (userIsEnteringData) {
        // converts to double and sends to calculator brain for processing
        //[[self brain] setOperand:[[display text] doubleValue]];
        [self brain].operand = [[display text] doubleValue];
        userIsEnteringData = NO;
    }
    NSString *operation = [[sender titleLabel] text];
    
    BOOL valid = [[self brain] testValidity:operation];
    if (valid) {
        double result = [[self brain] performOperation:operation];
        [display setText:[NSString stringWithFormat:@"%g", result]];
    }
    else {
        [display setText:[NSString stringWithFormat:@"ERROR"]];
    }
}

-(IBAction)decimalPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(clickSoundSSID);
    
    NSString* displayedValue = [display text];
    
    if ([displayedValue rangeOfString:@"."].location == NSNotFound) {
        [display setText:[[display text] stringByAppendingString:@"."]];
        userIsEnteringData = YES;
    }
}

@end
