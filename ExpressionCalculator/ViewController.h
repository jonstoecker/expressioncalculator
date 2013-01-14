//
//  ViewController.h
//  ExpressionCalculator
//
//  Created by Jon Stoecker on 1/13/13.
//  Copyright (c) 2013 Jon Stoecker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LogicModel.h"
#import "GradientButton.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel* resultDisplay;
    IBOutlet UILabel* expressionDisplay;
    
    NSArray* numberButtons;
    NSArray* operationButtons;
    GradientButton* equalsButton;
    
    LogicModel* model;
    
    SystemSoundID clickSoundSSID;

@private
    BOOL showingResult;
    NSString* result;
}

-(IBAction)inputPressed:(id)sender;
-(IBAction)equalsPressed:(id)sender;
-(IBAction)deletePressed:(id)sender;
-(IBAction)clearPressed:(id)sender;
-(IBAction)recallPressed:(id)sender;

@property (nonatomic, retain) IBOutletCollection(GradientButton) NSArray* numberButtons;
@property (nonatomic, retain) IBOutletCollection(GradientButton) NSArray* operationButtons;
@property (nonatomic, retain) IBOutlet GradientButton* equalsButton;

@end
