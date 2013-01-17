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

@synthesize scrollView;
@synthesize buttonPanel;

//
//  Defined message constants and statics:
//
NSString* const JSZeroStr = @"0";
NSString* const JSEmptyStr = @"";
NSString* const JSSyntaxErrorMsg = @"syntax";

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
    [self updateExpressionDisplayWith: [[sender titleLabel] text]];
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
        finalResult = [LogicModel calculateExpression: [expressionDisplay text]];
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
//  Enters a function into the scratchpad.
//
-(IBAction)functionPressed:(UIButton*)sender
{
    [self playSound];
    
    if (showingResult) {
        [self updateExpressionDisplayWith:JSEmptyStr];
        showingResult = NO;
    }
    [self updateExpressionDisplayWith: [[[sender titleLabel] text] stringByAppendingString:@"("]];
}

//
//  Accesses the model to calculate the result of the expression
//  shown in the scratchpad.
//
-(void)updateResultDisplay
{
    NSString* expression = [LogicModel calculateExpression: [expressionDisplay text]];
    
    if (expression) {
        [resultDisplay setText:[LogicModel calculateExpression: [expressionDisplay text]]];
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
    
    // Attach button panel to scroll view
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView addSubview:buttonPanel];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
}

-(void)viewDidUnload
{
    self.scrollView = nil;
    self.buttonPanel = nil;
    [super viewDidUnload];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(clickSoundSSID);
    //[model release];
    [scrollView release];
    [buttonPanel release];
    [resultDisplay release];
    [expressionDisplay release];
    [super dealloc];
}

@end
