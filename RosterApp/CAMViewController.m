//
//  CAMViewController.m
//  RosterApp
//
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "CAMViewController.h"
#import "DetailsVC.h"


@interface CAMViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSString *selectedName;
@property (strong, nonatomic) DataSource *theDataSource;

@end

@implementation CAMViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.myTableView reloadData];
}


- (void)viewDidLoad{
    [super viewDidLoad];

    self.theDataSource = [[DataSource alloc]init];

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self.theDataSource;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"refreshing"];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];
    
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    NSLog(@"hello");
    [refreshControl endRefreshing];
}

-(IBAction)sortWasHit:(id)sender{
    
    NSLog(@"sort was hit");
    [self.theDataSource sort];
    [self.myTableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MySegue"]){
        DetailsVC *detailsVC = [segue destinationViewController]; //This is a pointer to the destination view controller.
        UITableViewCell* someCell = (UITableViewCell*)sender;
        NSString* nameString = someCell.textLabel.text;
        NSLog(@"name is %@" , nameString);
        for(Student* thisStudent in self.theDataSource.studentArray){
            if([thisStudent.name isEqualToString: nameString]){
                detailsVC.currentStudent = thisStudent;
            }
        }
        detailsVC.someString = someCell.textLabel.text;
        self.navigationItem.title = someCell.textLabel.text;
        [someCell setSelected:NO];
    }
}



- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
