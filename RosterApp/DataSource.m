//
//  DataSource.m
//  RosterApp
//
//  Created by Chris Meehan on 1/14/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "DataSource.h"

@interface DataSource ()

@end

@implementation DataSource
@synthesize studentArray=_studentArray;
@synthesize teacherArray=_teacherArray;
@synthesize photoDict=_photoDict;    // This is a dictionary of string keys and nsdata(to convert to uiimage) values.


-(id)init{
    if(self = [super init]){
        self.studentArray = [[NSMutableArray alloc]init];
        Teacher* teacher1 = [[Teacher alloc]initWithName:@"Clem"];
        Teacher* teacher2 = [[Teacher alloc]initWithName:@"Brad"];
        self.teacherArray = [NSArray arrayWithObjects:teacher1,teacher2, nil];
        // We are loading up. Read the student names, and create instances of each and add them to a studentArray.
        NSArray * arrayOfStudentsFromPList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"]];
        for(NSDictionary* dictOfStudent in arrayOfStudentsFromPList){
            NSString * personName = [dictOfStudent objectForKey:@"name"];
            Student* tempStudent = [[Student alloc] initWithName:personName];
            UIImage* tempImage = [self loadImagefromName:tempStudent.name];
            //If a uiimage was returned for this current student
            if(tempImage){
                tempStudent.uII = tempImage;
            }
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
        // If the student is NOT holding a point to a UIImage
        if(!aStudent.uII){
            NSLog(@"yaaaa");
            NSData* imageData = [self.photoDict objectForKey:aStudent.name];
            UIImage *image=[UIImage imageWithData:imageData];
            aStudent.uII = image;
        }
        cell.imageView.image = aStudent.uII;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 5.0;
        cell.textLabel.text =  [aStudent name];
        // If this particular student has a uiimage property loaded in him.
        if(aStudent.uII!=nil){
            [cell.imageView setImage:aStudent.uII];
        }
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

// Get the pic from the documents array
- (UIImage*)loadImagefromName:(NSString*)nameOfStudent{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",nameOfStudent]];
    NSLog(@"loading from path %@" , path);
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}





















@end
