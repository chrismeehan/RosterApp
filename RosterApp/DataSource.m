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
        // First, get the general path of the Documents Directory, so we can see if it has our plist. In this case ,lets always check the last path the DocDir gives us.
        docDirPathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        docDirPathString = [docDirPathString stringByAppendingPathComponent:@"Bootcamp.plist"]; // Than make it specific with your plist's name.
        
        // You need a NSFileManager to manage and check any files.
        NSFileManager *myFileManager = [NSFileManager defaultManager];
        
        // Tell you NSFileManager to check if that plist is in your docDir.
        if (![myFileManager fileExistsAtPath:docDirPathString]) {
            // If not, then we need to setup the address to the Main Bundle and get the plist from there instead.
            NSString *mainBundleSourcePathString = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
            // And tell the NSFileManager to copy that file into our docDir, so we never need to look back at our Main Bundle again.
            [myFileManager copyItemAtPath:mainBundleSourcePathString toPath:docDirPathString error:nil];
        }
        
        // Now lets put the contents of the plist (which is surely in our docDir at this point) into an array.
        arrayOfDictionariesFromPList = [[NSMutableArray alloc] initWithContentsOfFile:docDirPathString];

        //Now lets view each dictionary (or student) from the array, and create a Student ovject, using its name and propertys.
        for(NSDictionary* dictOfStudent in arrayOfDictionariesFromPList){
            NSString * personName = [dictOfStudent objectForKey:@"name"];
            NSString * personsTwitter = [dictOfStudent objectForKey:@"twitter"];
            NSString * personsGithub = [dictOfStudent objectForKey:@"github"];
            NSNumber * personsRed = [dictOfStudent objectForKey:@"red"];
            NSNumber * personsGreen = [dictOfStudent objectForKey:@"green"];
            NSNumber * personsBlue = [dictOfStudent objectForKey:@"blue"];

            // Lets set this Student up.
            Student* tempStudent = [[Student alloc] initWithName:personName];
            tempStudent.twitterName = personsTwitter;
            tempStudent.githubName = personsGithub;
            [tempStudent setRed:[personsRed floatValue] andGreen:[personsGreen floatValue] andBlue:[personsBlue floatValue]];
            // set his image.
            UIImage* tempImage = [self loadImagefromName:tempStudent.name];
            //If a uiimage was returned for this current student, set it to his internal property.
            if(tempImage){
                tempStudent.uII = tempImage;
            }
            
            // Add this newly initiallized Student to this class's array of Students.
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
            aStudent.uII = [UIImage imageNamed:@"NoPhotoIcon.jpeg"];
            cell.imageView.layer.borderColor = [self CGColorRefFromUIColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]] ;
        }
        else{
            cell.imageView.layer.borderColor = [self CGColorRefFromUIColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:1.0]] ;
        }
        cell.imageView.layer.borderWidth = 2.5;
        cell.imageView.image = aStudent.uII;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 15;
        cell.textLabel.text =  [aStudent name];
        [cell.imageView setImage:aStudent.uII];
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


-(CGColorRef)CGColorRefFromUIColor:(UIColor*)newColor {
    CGFloat components[4] = {0.0,0.0,0.0,0.0};
    [newColor getRed:&components[0] green:&components[1] blue:&components[2]        alpha:&components[3]];
    CGColorRef newRGB = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
    return newRGB;
}



-(void)changeThePListWithEditedStudent:(Student*)changedStudent atIndex:(int)theindex{

    // This instance of an NSDict (or student) will be held in this NSDict.
    NSMutableDictionary* tempDictionary = [[NSMutableDictionary alloc]init];
    
    // Tell this dictionary (student) to change its "key"(which is 'name') to this "value" (which is 'McGruber').
    [tempDictionary setValue:changedStudent.name forKey:@"name"];
    [tempDictionary setValue:changedStudent.twitterName forKey:@"twitter"];
    [tempDictionary setValue:changedStudent.githubName forKey:@"github"];
    [tempDictionary setValue:[NSNumber numberWithFloat:[changedStudent getRed]] forKey:@"red"];
    [tempDictionary setValue:[NSNumber numberWithFloat:[changedStudent getGreen]] forKey:@"green"];
    [tempDictionary setValue:[NSNumber numberWithFloat:[changedStudent getBlue]] forKey:@"blue"];
    
    // Assingn this new found dictionary (student) to the 3rd object in the original NSMutableArray you've been working with.
    [arrayOfDictionariesFromPList setObject:tempDictionary atIndexedSubscript:theindex];
    //And finally, all Arrays have a method that writes their contents to a file name string (which is a parameter).
    [arrayOfDictionariesFromPList writeToFile: docDirPathString atomically:YES];
}











@end
