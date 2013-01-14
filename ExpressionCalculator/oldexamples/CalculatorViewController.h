//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Jonathan Stoecker on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
    IBOutlet UILabel *display;
    CalculatorBrain *brain;
    BOOL userIsEnteringData;
    SystemSoundID clickSoundSSID;
}

-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;
-(IBAction)decimalPressed:(UIButton *)sender;

@end
