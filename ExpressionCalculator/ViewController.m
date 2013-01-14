//
//  ViewController.m
//  ExpressionCalculator
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

// Private methods here:
-(void)updateResultDisplay;
-(void)updateExpressionDisplay:(NSString*)expression;
-(void)playSound;

@end

@implementation ViewController
@synthesize numberButtons;
@synthesize operationButtons;
@synthesize equalsButton;

//
//  Checks for an instance of the model and initializes
//  if necessary.
//
-(LogicModel*)logicInit
{
    if (!model) {
        model = [[LogicModel alloc] init];
    }
    return model;
}

//
//  Adds a number/value or operator to the expression scratchpad.
//
-(IBAction)inputPressed:(UIButton*)sender
{
    [self playSound];
    [self updateExpressionDisplay: [[sender titleLabel] text]];
    [self updateResultDisplay];
}

//
//  Adds an operator to the scratchpad expression
//  and updates the current result display
//
-(IBAction)operatorPressed:(UIButton*)sender
{
    [self playSound];
    [self updateExpressionDisplay: [[sender titleLabel] text]];
}

//
//  Executes the currently entered expression (when pressing the = button).
//
-(IBAction)equalsPressed:(UIButton*)sender
{
    [self playSound];
    
    NSString* finalResult = [[self logicInit] calculateExpression: [expressionDisplay text] isFinal:YES];
    if (!finalResult) {
        [resultDisplay setText:@"check syntax"];
    } else {
        [resultDisplay setText:finalResult];
        showingResult = YES;
    }
}

//
//  Truncates the currently entered expression by one character.
//
-(IBAction)deletePressed:(UIButton*)sender
{
    [self playSound];
    
    NSString* expression = [expressionDisplay text];
    if ([expression length] > 0) {
        [expressionDisplay setText:[expression substringToIndex:([expression length] - 1)]];
    }
    
    [self updateResultDisplay];
}

//
//  Clears the results window and expression scratchpad.
//
-(IBAction)clearPressed:(UIButton*)sender
{
    [self playSound];
    [expressionDisplay setText:@""];
    [resultDisplay setText:@""];
}

//
//  Returns most recent expression calculated.
//
-(IBAction)recallPressed:(UIButton*)sender
{
    [self playSound];
    [expressionDisplay setText:[[self logicInit] recall]];
    [self updateResultDisplay];
}

//
//  Accesses the model to calculate the result of the expression
//  shown in the scratchpad.
//
-(void)updateResultDisplay
{
    result = [[self logicInit] calculateExpression: [expressionDisplay text] isFinal:NO];
    [resultDisplay setText:result];
}

//
//  Updates the expression scratchpad.
//
-(void)updateExpressionDisplay:(NSString*)input
{
    if (showingResult) {
        [expressionDisplay setText:@""];
        [resultDisplay setText:@""];
        showingResult = NO;
    }
    
    [expressionDisplay setText:[[expressionDisplay text] stringByAppendingString:input]];
}

//
//  Plays the button click audio file.
//
-(void)playSound
{
    AudioServicesPlaySystemSound(clickSoundSSID);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize programmatic button gradients.
    for (GradientButton* eachButton in numberButtons) {
        [eachButton useBlackStyle];
    }
    for (GradientButton* eachButton in operationButtons) {
        [eachButton useAlertStyle];
    }
    [equalsButton useSimpleOrangeStyle];
    
    // Sound (button click) initialization.
    NSURL* clickSoundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/click.aiff",[[NSBundle mainBundle] resourcePath]]];
    AudioServicesCreateSystemSoundID((CFURLRef) clickSoundURL, &clickSoundSSID);
}

-(void)viewDidUnload
{
    self.numberButtons = nil;
    self.operationButtons = nil;
    self.equalsButton = nil;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(clickSoundSSID);
    [numberButtons release];
    [operationButtons release];
    [equalsButton release];
    [super dealloc];
}

@end
