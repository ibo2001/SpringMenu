//
//  IBSrpingMenu.h
//  SpringMenu
//
//  Created by Ibrahim Qraiqe on 24.10.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBSrpingMenu;

@protocol IBSrpingMenuDataSource <NSObject>
@required
- (int)numberOfItemsForMenu:(IBSrpingMenu*) btnView;
- (int)numberOfItemsInRow:(IBSrpingMenu*) itmsInRow;

- (NSString *) ibSrpingMenu:(IBSrpingMenu*)springMenu imageNameForItemAtIndex:(NSUInteger) index;
@end

@protocol IBSrpingMenuDelegate <NSObject>
@required
- (void)ibSpringMenu:(IBSrpingMenu*)springMenu itemSelectedAtIndex:(NSUInteger) index;
@end


@interface IBSrpingMenu : UIView{
    int _itemCount;
    UIImage *_selectedImage;
    UIImage *_normalImage;
    
    NSMutableArray *_icons;

}



@property (nonatomic, retain) NSMutableArray *icons;
@property (nonatomic, weak) IBOutlet id <IBSrpingMenuDelegate> itemSelectedDelegate;
@property (nonatomic, weak) IBOutlet id <IBSrpingMenuDataSource> dataSource;
@property (nonatomic, weak) IBOutlet UIButton *menuBtn;

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, assign) int itemCount;

-(void) reloadData;
-(void) setSelectedIndex:(int) index animated:(BOOL) animated;

@end
