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
@synthesize name = _name;
@synthesize uII=_uII;


-(id)init{
    if(self = [super init]){
        return [self initWithName:@"No Name"];
    }
    return self;
}

-(void)setRed:(CGFloat)red abdBlue:(CGFloat)blue andGreen:(CGFloat)green{
    redValue = red;
    blueValue = blue;
    greenValue = green;
}

-(UIColor*)getRGBUIColor{
    UIColor* tempColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
    return tempColor;
}

-(CGFloat)getRed{
    return redValue;
}

-(CGFloat)getBlue{
    return blueValue;
}

-(CGFloat)getGreen{
    return greenValue;
}

-(id)initWithName:(NSString*)name{
    UIImage *image = nil;
    return [self initWithName:name andImage:image];
}

-(id)initWithName:(NSString*)name andImage:(UIImage*)image{
    self.name = name;
    self.uII = image;
    
    //by default, all people's favorite color will be greyish      From 0 to 1
    redValue = 1.0;
    greenValue = 0.0;
    blueValue = 0.0;

    
    return self;
}



@end
