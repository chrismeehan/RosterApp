//
//  CAMViewController.h
//  RosterApp
//
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "Teacher.h"
#import "DataSource.h"

@interface CAMViewController : UIViewController<UITableViewDelegate>

-(IBAction)sortWasHit:(id)sender;

@end
