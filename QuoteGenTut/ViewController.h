//
//  ViewController.h
//  QuoteGenTut
//
//  Created by User on 9/29/16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

//"@interface" is the equivalent of "class" in c++
@interface ViewController : UIViewController

//"@property" is the equivalent of a "class member" in c++
@property (nonatomic, retain) NSArray* myQuotes;
//nonatomic means that this property possibly will not work in a multi-threaded environment
//retain means a pointer to this variable will remain in memory as long as the ViewController object exists
@property (nonatomic, retain) NSMutableArray* movieQuotes;

//the IBOutlet means that the variable is an object that can be linked to an interface element on the XIB file so that the view controller can change properties of that element
//note, you need to connect objects from the storyboard to the code that you want it to be used in reference with as explained here: http://help.apple.com/xcode/mac/8.0/#/devc0cdc8c7a
@property (nonatomic, retain) IBOutlet UITextView* quote_text;
//IBAction means that the variable is an action that can be linked to an event for UI control on the screen
-(IBAction)quote_btn_touch:(id)sender;

//segmented controls allow you to select 1 item from a list of options
//info on how to specifically change the height of this UI element on storyboard obtained from: http://stackoverflow.com/questions/12027608/ios-change-the-height-of-uisegmentedcontrol
@property (nonatomic, retain) IBOutlet UISegmentedControl* quote_opt;


//Note to self, I need to look up a guide of how you debug code using Xcode; specifically need to find how to view call stack, but for now I find a lot of useful information in the debug output that can point out what the problem with the code is
//this is the equivalent of the ending bracket for a class declaration in c++
@end

