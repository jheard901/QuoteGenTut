//
//  ViewController.m
//  QuoteGenTut
//
//  Created by User on 9/29/16.
//  Copyright © 2016 User. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//these properties need to be synthesized only if you do not provide them within the @implementation block
@synthesize myQuotes;
@synthesize movieQuotes;
@synthesize quote_text;
@synthesize quote_opt;
//"@synthesize" provides default methods for getting and setting the contents of objects

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //this is one way of seting default values for an array
    //note, this is referred to as calling a method; specifically, when calling a method on a property you much declare the method within brackets, then type the object name (ie typename in c++) proceeded by the method name (ie a function associated with that object - eg string.Length() in c++ is the equivalent pretty much)
    self.myQuotes = [NSArray arrayWithObjects:
                     @"Hello friends",
                     @"In they go, but out they don't come",
                     @"That steak was tasty",
                     @"Getting paid to code, well that is the dream",
                     @"You can't win big if you don't give it a try",
                     @"Leave this place at once denizen",
                     @"Alright, that is enough values in the array for now",
                     nil];
    //nil is used at the end of an array to know when it is done
    //"self" optionally can be used when getting/setting data for a property. It is basically the equivalent of "this" in c++. It is recommended that beginners use it until knowing reasons about when to use instance variables directly
    
    //keep in mind that plist (property lists) can be opened in source mode (xml) by right clicking on them
    //load movie quotes from plist
    NSString* plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy];
}


//this function is essentially an upgraded version of the viewDidUnoad method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //frees up memory once object is unloaded
    myQuotes = nil;
    movieQuotes = nil;
    quote_text = nil;
    quote_opt = nil;
}

//updated for using the movieQuotes property
-(IBAction)quote_btn_touch:(id)sender
{
    //updated for using segmented control tool | select a category
    NSString* selectedMovieCat = @"classic";    //defaults to first element
    if(self.quote_opt.selectedSegmentIndex == 1)
    {
        selectedMovieCat = @"modern";
    }
    if(self.quote_opt.selectedSegmentIndex == 2)
    {
        selectedMovieCat = @"extra";
    }
    //predicates are objects that filter an array
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedMovieCat];
    NSArray* filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
    //get number of rows in array
    //int array_tot = (int)[self.myQuotes count]; //typecasting example: http://stackoverflow.com/questions/690748/how-to-cast-an-object-in-objective-c
    //int array_tot = (int)[self.movieQuotes count];
    int array_tot = (int)[filteredArray count];
    //safety time | only get quote when array has rows in it (this bit seems overboard when it comes to typesafety)
    if(array_tot > 0)
    {
        //get random index
        int index = arc4random() % array_tot;
        
        //get quote string for the index
        //NSString* my_quote = [self.myQuotes objectAtIndex:index];
        NSString* quote = [[filteredArray objectAtIndex:index] valueForKey:@"quote"];
        //get source string for the index if it exists
        NSString* source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
        if(!([source length] == 0))
        {
            //update the quote to reflect it has a source
            quote = [NSString stringWithFormat:@"%@\n\n%@", quote, source ];
        }
        //display the quote in the text view | customized based off category
        if([selectedMovieCat isEqualToString:@"classic"])
        {
            quote = [NSString stringWithFormat:@"From Classic Movie:\n%@", quote];
        }
        else if([selectedMovieCat isEqualToString:@"modern"])
        {
            quote = [NSString stringWithFormat:@"From Modern Movie:\n%@", quote];
        }
        else if([selectedMovieCat isEqualToString:@"extra"])
        {
            quote = [NSString stringWithFormat:@"From an Extra Movie:\n%@", quote];
        }
        else
        {
            quote = [NSString stringWithFormat:@"Movie Quote:\n%@", quote];
        }
        
        //optionally, can append some extra stuff before displaying the quote based of if it holds a specific value (prefix of string values in this ex)
        if([source hasPrefix:@"Gone"] || [source hasPrefix:@"THE"])  //displays the extra tidbit at the start if the source starts with "Gone" or "THE"
        {
            quote = [NSString stringWithFormat:@"10/10\nWould watch again!\n-IGN\n\n%@", quote];
        }
        
        //self.quote_text.text = [NSString stringWithFormat:@"Movie Quote:\n\n%@", quote];
        self.quote_text.text = quote;
        
        //now update to reflect that this element from the array has been displayed
        int movie_array_tot = (int)[self.movieQuotes count];
        NSString* quote1 = [[filteredArray objectAtIndex:index] valueForKey:@"quote"];
        for(int x = 0; x < movie_array_tot; x++)
        {
            NSString* quote2 = [[movieQuotes objectAtIndex:x] valueForKey:@"quote"];
            if([quote1 isEqualToString:quote2])
            {
                NSMutableDictionary* itemAtIndex = (NSMutableDictionary*)[movieQuotes objectAtIndex:x];
                [itemAtIndex setValue:@"Movie Quote Repeated..." forKey:@"source"];
            }
        }
    }
    else
    {
        self.quote_text.text = @"No quotes to display.";
    }
}
//arc4random() generates a random number
//note that in the tutorial they ask you to get your .xib file which is basically a predecessor of storyboards; this file can only be accessed through creating it at the start of making a new project or through creating a new cocoa touch class
//more information on .xib files: http://stackoverflow.com/questions/13834999/storyboards-vs-the-old-xib-way
//and: http://stackoverflow.com/questions/11225654/xcode-how-to-connect-xib-to-viewcontroller-class

//found information on how to modify look of buttons manually through the identity inspector hear (when on the .storyboard): http://stackoverflow.com/questions/18968362/xcode-5-round-rect-buttons . Be mindful that changes will only show during runtime.



@end
