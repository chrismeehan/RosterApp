//
//  Details.m
//  RsterApp
//  Created by Chris Meehan on 1/13/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.


#import "Details.h"



@implementation Details
@synthesize nameHoldingLabel = _nameHoldingLabel;
@synthesize someString = _someString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameHoldingLabel.text = self.someString;
}

@end
