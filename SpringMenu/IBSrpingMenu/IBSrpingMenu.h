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
- (UIColor *)menuBackgroundColor:(IBSrpingMenu*) menu;

- (NSString *) ibSrpingMenu:(IBSrpingMenu*)springMenu imageNameForItemAtIndex:(NSUInteger) index;
@end

@protocol IBSrpingMenuDelegate <NSObject>
@required
- (void)ibSpringMenu:(IBSrpingMenu*)springMenu itemSelectedAtIndex:(NSUInteger) index;
@end

typedef enum {
    kFade,
    kSpring,
    kShake
} AnimationType;

@interface IBSrpingMenu : UIView{
    int _itemCount;
    UIImage *_selectedImage;
    UIImage *_normalImage;
    
    NSMutableArray *_icons;

    int animTag;
}

@property (nonatomic, assign) AnimationType animationType;

@property (nonatomic, retain) NSMutableArray *icons;
@property (nonatomic, assign) id <IBSrpingMenuDelegate> itemSelectedDelegate;
@property (nonatomic, assign) id <IBSrpingMenuDataSource> dataSource;
@property (nonatomic, weak) UIButton *menuBtn;

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, assign) int itemCount;

@property (nonatomic) float showingDuration;
@property (nonatomic) float hidingDuration;


+(id)initSpringMenuForBtn:(UIButton *)btn;
-(id)initSpringMenuForBtn:(UIButton *)btn;

-(void) layOutTheBtns;
-(void) setSelectedIndex:(int) index animated:(BOOL) animated;

-(void)showSpringMenu:(AnimationType)animationType;
-(void)hideSpringMenu;
@end
