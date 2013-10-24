//
//  ViewController.m
//  SpringMenu
//
//  Created by Ibrahim Qraiqe on 24.10.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import "ViewController.h"
#import "IBSrpingMenu.h"


@interface ViewController ()<IBSrpingMenuDataSource,IBSrpingMenuDelegate>{
    NSArray *btns;
}

@property (weak, nonatomic) IBOutlet IBSrpingMenu *menu;
- (IBAction)showMenu:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    btns = @[@"face-frown",@"ghost",@"mail-send",@"search",@"volume-high",@"zoom-out"];

}

-(void)viewDidAppear:(BOOL)animated{
    [self.menu reloadData];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
}

#pragma mark-
#pragma mark IBSrpingDelegate and datasource
- (int)numberOfItemsForMenu:(IBSrpingMenu*) btnView{
    return btns.count;
}
- (int)numberOfItemsInRow:(IBSrpingMenu*) itmsInRow{
    return 1;
}

- (NSString *) ibSrpingMenu:(IBSrpingMenu*)springMenu imageNameForItemAtIndex:(NSUInteger) index{
    return [btns objectAtIndex:index];
}

- (void)ibSpringMenu:(IBSrpingMenu*)springMenu itemSelectedAtIndex:(NSUInteger) index{
    NSLog(@"%s",__FUNCTION__);

}
@end
