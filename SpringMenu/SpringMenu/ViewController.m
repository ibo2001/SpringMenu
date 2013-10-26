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

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (retain, nonatomic) IBSrpingMenu *menu;
- (IBAction)showMenu:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.label setText:@""];

    btns = @[@"face-frown",@"ghost",@"mail-send",@"search",@"volume-high",@"zoom-out"];
    self.menu = [[IBSrpingMenu alloc]initSpringMenuForBtn:self.menuBtn];
    self.menu.dataSource = self;
    self.menu.itemSelectedDelegate = self;
    [self.menu layOutTheBtns];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
    self.menu.showingDuration = .01;
    self.menu.hidingDuration = .01;
    
    if ([self.menuBtn.titleLabel.text isEqualToString:@"Show menu"]){
        [self.menu showSpringMenu:kSpring];
        [self.menuBtn setTitle:@"Hide menu" forState:UIControlStateNormal];
    }else{
        [self.menu hideSpringMenu];
        [self.menuBtn setTitle:@"Show menu" forState:UIControlStateNormal];
    }
}

#pragma mark-
#pragma mark IBSrpingDelegate and datasource
-(UIColor *)menuBackgroundColor:(IBSrpingMenu *)menu{
    return [UIColor redColor];
}
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

    [self.label setText:[NSString stringWithFormat:@"You have selected %@",[btns objectAtIndex:index]]];
    [self.menu hideSpringMenu];
    [self.menuBtn setTitle:@"Show menu" forState:UIControlStateNormal];

}
@end
