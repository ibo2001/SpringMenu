//
//  IBSrpingMenu.m
//  SpringMenu
//
//  Created by Ibrahim Qraiqe on 24.10.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import "IBSrpingMenu.h"
#define kButtonBaseTag 10000
#define kLeftOffset 2

@implementation IBSrpingMenu

@synthesize icons = _icons;
@synthesize selectedImage = _selectedImage;
@synthesize normalImage = _normalImage;

@synthesize itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;


-(void) reloadData
{

    self.itemCount = [dataSource numberOfItemsForMenu:self];
    
    
    int tag = kButtonBaseTag;
    float padding = 5.0f;
    int rowTotal = [dataSource numberOfItemsInRow:self];

    float finalWidht = 0.0f;
    float finalHeight = 0.0f;
    
    int finalTotalOfRows = 0;

    for(int i = 0 ; i < self.itemCount; i ++){
        int theRow = i / rowTotal;
        int column = i % rowTotal;

        UIImage *icon = [UIImage imageNamed:[dataSource ibSrpingMenu:self imageNameForItemAtIndex:i]];
        CGSize size = icon.size;

        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setImage:icon forState:UIControlStateNormal];
        
        customButton.tag = tag++;
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        customButton.frame = CGRectMake((size.width*column)+(padding*column),
                                        (size.height*theRow)+(padding*theRow),
                                        icon.size.width, icon.size.height);
        

        [self addSubview:customButton];
        finalHeight = ((theRow+1)*size.height)+(padding*theRow);
        finalWidht = (rowTotal *size.width)+(padding*rowTotal);

    }
    


    
    [self setFrame:CGRectMake(CGRectGetMinX(self.menuBtn.frame),
                               CGRectGetMaxY(self.menuBtn.frame),
                               finalWidht,
                               finalHeight)];
    self.center = CGPointMake(self.menuBtn.center.x, self.center.y);

}


-(void) setSelectedIndex:(int) index animated:(BOOL) animated
{
    UIButton *thisButton = (UIButton*) [self viewWithTag:index + kButtonBaseTag];
    thisButton.selected = YES;
//    [self setContentOffset:CGPointMake(thisButton.frame.origin.x - kLeftOffset, 0) animated:animated];
    [self.itemSelectedDelegate ibSpringMenu:self itemSelectedAtIndex:index];
}

-(void) buttonTapped:(id) sender
{
    UIButton *button = (UIButton*) sender;
    
    for(int i = 0; i < self.itemCount; i++)
    {
        UIButton *thisButton = (UIButton*) [self viewWithTag:i + kButtonBaseTag];
        if(i + kButtonBaseTag == button.tag)
            thisButton.selected = YES;
        else
            thisButton.selected = NO;
    }
    
    [self.itemSelectedDelegate ibSpringMenu:self itemSelectedAtIndex:button.tag - kButtonBaseTag];
}



@end
