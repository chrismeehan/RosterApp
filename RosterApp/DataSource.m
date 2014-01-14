//
//  DataSource.m
//  RosterApp
//
//  Created by Chris Meehan on 1/14/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "DataSource.h"

@interface DataSource ()
    @property (strong, nonatomic) NSMutableArray *studentArray;
    @property (strong, nonatomic) NSArray *teacherArray;
@end

@implementation DataSource
@synthesize studentArray=_studentArray;
@synthesize teacherArray=_teacherArray;


-(id)init{
    if(self = [super init]){
        self.studentArray = [[NSMutableArray alloc]init];
        Teacher* teacher1 = [[Teacher alloc]initWithName:@"Clem"];
        Teacher* teacher2 = [[Teacher alloc]initWithName:@"Brad"];
        self.teacherArray = [NSArray arrayWithObjects:teacher1,teacher2, nil];
        
        NSArray * arrayOfStudentsFromPList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"]];
        
        for(NSDictionary* dictOfStudent in arrayOfStudentsFromPList){
            NSString * personName = [dictOfStudent objectForKey:@"name"];
            Student* tempStudent = [[Student alloc] initWithName:personName];
            [self.studentArray addObject:tempStudent];
        }
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        NSLog(@"num of students is %d" , self.studentArray.count);
        return self.studentArray.count;
    }
    else{
        return self.teacherArray.count;
    }
}


-(void)sort{
    NSSortDescriptor* nSSD = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nSSD];
    self.studentArray = (NSMutableArray*)[self.studentArray sortedArrayUsingDescriptors:sortDescriptors];
    self.teacherArray =[self.teacherArray sortedArrayUsingDescriptors:sortDescriptors];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ThisCell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        Student* aStudent =[self.studentArray objectAtIndex:indexPath.row];
        cell.textLabel.text =  [aStudent name];
    }
    else {
        Teacher* aTeacher = [self.teacherArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [aTeacher name];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Students";
    }
    else {
        return @"Teachers";
    }
}


@end
