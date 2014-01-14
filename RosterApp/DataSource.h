//
//  DataSource.h
//  RosterApp
//
//  Created by Chris Meehan on 1/14/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"

@interface DataSource : NSObject<UITableViewDataSource>

-(void)sort;

@end
