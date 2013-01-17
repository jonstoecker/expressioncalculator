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

@interface ViewController : UIViewController
{
    IBOutlet UILabel* resultDisplay;
    IBOutlet UILabel* expressionDisplay;
    
    LogicModel* model;
    
    SystemSoundID clickSoundSSID;
    
@private
    BOOL showingResult;
}

-(IBAction)inputPressed:(id)sender;
-(IBAction)equalsPressed:(id)sender;
-(IBAction)deletePressed:(id)sender;
-(IBAction)clearPressed:(id)sender;
-(IBAction)operatorPressed:(id)sender;

extern NSString* const JSZeroStr;
extern NSString* const JSEmptyStr;
extern NSString* const JSSyntaxErrorMsg;

@end
