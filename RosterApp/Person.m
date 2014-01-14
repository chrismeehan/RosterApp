//
//  Person.m
//  RosterApp
//
//  Created by Chris Meehan on 1/14/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import "Person.h"

@interface Person()

@end

@implementation Person
@synthesize name= _name;

-(id)init{
    if(self = [super init]){
        return [self initWithName:@"No Name"];
    }
    return self;
}

-(id)initWithName:(NSString*)name{
    UIImage *image = [UIImage imageNamed:@"farTarget.png"];
    return [self initWithName:name andImage:image];
}

-(id)initWithName:(NSString*)name andImage:(UIImage*)image{
    self.name = name;
    self.uII = image;
    return self;
}



@end
