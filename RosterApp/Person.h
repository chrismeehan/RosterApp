//
//  Person.h
//  RosterApp
//
//  Created by Chris Meehan on 1/14/14.
//  Copyright (c) 2014 Chris Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    CGFloat redValue;
    CGFloat greenValue;
    CGFloat blueValue;
    
}

@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) UIImage* uII;

-(void)setRed:(CGFloat)red abdBlue:(CGFloat)blue andGreen:(CGFloat)green;
-(UIColor*)getRGBUIColor;

-(CGFloat)getRed;
-(CGFloat)getBlue;
-(CGFloat)getGreen;

-(id)initWithName:(NSString*)name;
-(id)initWithName:(NSString*)name andImage:(UIImage*)image;

@end
