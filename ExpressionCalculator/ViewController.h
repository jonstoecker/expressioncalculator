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
    
    UIScrollView* scrollView;
    UIView* buttonPanel;
    
    SystemSoundID clickSoundSSID;
    
@private
    BOOL showingResult;
}

@property (nonatomic, retain) IBOutlet UIView* buttonPanel;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;

-(IBAction)inputPressed:(id)sender;
-(IBAction)equalsPressed:(id)sender;
-(IBAction)deletePressed:(id)sender;
-(IBAction)clearPressed:(id)sender;
-(IBAction)operatorPressed:(id)sender;
-(IBAction)functionPressed:(id)sender;

extern NSString* const JSZeroStr;
extern NSString* const JSEmptyStr;
extern NSString* const JSSyntaxErrorMsg;

@end
