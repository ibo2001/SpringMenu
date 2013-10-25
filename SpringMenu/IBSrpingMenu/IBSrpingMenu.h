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

    int animTag;
}



@property (nonatomic, retain) NSMutableArray *icons;
@property (nonatomic, assign) id <IBSrpingMenuDelegate> itemSelectedDelegate;
@property (nonatomic, assign) id <IBSrpingMenuDataSource> dataSource;
@property (nonatomic, weak) UIButton *menuBtn;

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, assign) int itemCount;

+(id)initSpringMenuForBtn:(UIButton *)btn;
-(id)initSpringMenuForBtn:(UIButton *)btn;

-(void) layOutTheBtns;
-(void) setSelectedIndex:(int) index animated:(BOOL) animated;

-(void)showSpringMenu;
-(void)hideSpringMenu;
@end
