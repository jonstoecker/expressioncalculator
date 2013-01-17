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
-(void)updateExpressionDisplayWith:(NSString*)expression;
-(void)playSound;

@end

@implementation ViewController
@synthesize clearButton;

//
//  Defined message constants:
//
NSString* const JSZeroStr = @"0";
NSString* const JSEmptyStr = @"";
NSString* const JSSyntaxErrorMsg = @"syntax";

//
//  Checks for an instance of the model and initializes
//  if necessary.
//
-(LogicModel*)logic
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
    if (showingResult) {
        [self updateExpressionDisplayWith:JSEmptyStr];
        showingResult = NO;
    }
    [self updateExpressionDisplayWith: [[sender titleLabel] text]]; // <- this technically violates a strict interpretation of MVC...
}

//
//  Adds an operator to the scratchpad expression
//  and updates the current result display
//
-(IBAction)operatorPressed:(UIButton*)sender
{
    [self playSound];
    if (showingResult) {
        showingResult = NO;
    }
    else {
        [self updateResultDisplay];
    }
    [self updateExpressionDisplayWith: [[sender titleLabel] text]];
}

//
//  Executes the currently entered expression (when pressing the = button).
//
-(IBAction)equalsPressed:(UIButton*)sender
{
    [self playSound];
    
    NSString* finalResult;
    
    if ([[expressionDisplay text] isEqualToString:JSEmptyStr]) {
        finalResult = JSZeroStr;
    }
    else {
        finalResult = [[self logic] calculateExpression: [expressionDisplay text]];
    }

    if (!finalResult) {
        [resultDisplay setText:JSSyntaxErrorMsg];
    } else {
        [self updateResultDisplay];
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
        showingResult = NO;
    }
}

//
//  Clears the results window and expression scratchpad.
//
-(IBAction)clearPressed:(UIButton*)sender
{
    [self playSound];
    [self updateExpressionDisplayWith:JSEmptyStr];
    [self updateResultDisplay];
}

//
//  Loads a menu of optional operations (trig et al).
//
-(IBAction)optionPressed:(UIButton*)sender
{
    [self playSound];
    // implement the slide up option menu here
}

//
//  Accesses the model to calculate the result of the expression
//  shown in the scratchpad.
//
-(void)updateResultDisplay
{
    NSString* expression = [[self logic] calculateExpression: [expressionDisplay text]];
    
    if (expression) {
        [resultDisplay setText:[[self logic] calculateExpression: [expressionDisplay text]]];
    }
    else if ([[expressionDisplay text] isEqualToString:JSEmptyStr]){
        [resultDisplay setText:JSZeroStr];
    }

}

//
//  Updates the expression scratchpad.
//
-(void)updateExpressionDisplayWith:(NSString*)input
{
    if ([input isEqualToString:JSEmptyStr]) {
        [expressionDisplay setText:JSEmptyStr];
    } else {
        [expressionDisplay setText:[[expressionDisplay text] stringByAppendingString:input]];
    }
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
    
    // Sound (button click) initialization.
    NSURL* clickSoundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/click.aiff",[[NSBundle mainBundle] resourcePath]]];
    AudioServicesCreateSystemSoundID((CFURLRef) clickSoundURL, &clickSoundSSID);
}

-(void)viewDidUnload
{

}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(clickSoundSSID);
    [model release];
    [clearButton release];
    [super dealloc];
}

@end
