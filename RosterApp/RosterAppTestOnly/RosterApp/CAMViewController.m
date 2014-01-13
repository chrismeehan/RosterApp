//
//  CAMViewController.m
//  RosterApp
//
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "CAMViewController.h"
#import "Details.h"

@interface CAMViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *studentNameArray;
@property (strong, nonatomic) NSArray *instructorNameArray;
@property (strong, nonatomic) NSString *selectedName;



@end

@implementation CAMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* name1 = @"George";
    NSString* name2 = @"Jesse";
    NSString* name3 = @"Jake";
    
    NSString* name4 = @"Brad";
    NSString* name5 = @"Clem";
    
    
    self.studentNameArray = [NSArray arrayWithObjects:name1,name2,name3, nil];
    self.instructorNameArray = [NSArray arrayWithObjects:name4,name5, nil];

    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"refreshing"];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    NSLog(@"hello");
    [refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.studentNameArray.count;
    }
    else{
        return self.instructorNameArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ThisCell" forIndexPath:indexPath];    

    
    if (indexPath.section==0) {
        cell.textLabel.text = [self.studentNameArray objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [self.instructorNameArray objectAtIndex:indexPath.row];
    }
    return cell;
    
    

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell* someCell = (UITableViewCell*)sender;
    
    if ([[segue identifier] isEqualToString:@"MySegue"]){
        
        Details *detailsVC = [segue destinationViewController];
        detailsVC.someString = someCell.textLabel.text;
        self.navigationItem.title = someCell.textLabel.text;
    }
    
    [someCell setSelected:NO];
    
}

//segue.desinationViewCOnt

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
