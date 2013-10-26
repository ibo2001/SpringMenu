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
#define kDelayAnimation 0.05
#define kIncreaseDurationBy 10

@implementation IBSrpingMenu

@synthesize icons = _icons;
@synthesize selectedImage = _selectedImage;
@synthesize normalImage = _normalImage;

@synthesize itemSelectedDelegate;
@synthesize dataSource;
@synthesize itemCount = _itemCount;


+(id)initSpringMenuForBtn:(UIButton *)btn{
    return [[self alloc]init];
}
-(id)initSpringMenuForBtn:(UIButton *)btn{
    self = [super init];
    if (self) {
        [self.layer setAnchorPoint:CGPointMake(0.5, 0.0)];
        
        self.hidingDuration = .1;
        self.showingDuration = .1;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.menuBtn = btn;
        [btn.superview insertSubview:self belowSubview:btn];
    }
    
    return self;
}

-(void) layOutTheBtns{
    self.itemCount = [dataSource numberOfItemsForMenu:self];
    self.backgroundColor = [dataSource menuBackgroundColor:self];
    
    int tag = kButtonBaseTag;
    float padding = 5.0f;
    int rowTotal = [dataSource numberOfItemsInRow:self];

    float finalWidht = 0.0f;
    float finalHeight = 0.0f;
    

    for(int i = 0 ; i < self.itemCount; i ++){
        int theRow = i / rowTotal;
        int column = i % rowTotal;
        UIImage *icon = [UIImage imageNamed:[dataSource ibSrpingMenu:self imageNameForItemAtIndex:i]];
        CGSize size = icon.size;

        UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customButton.alpha = 0.0f;
        
        [customButton setImage:icon forState:UIControlStateNormal];
        
        customButton.tag = tag++;
        [customButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        customButton.frame = CGRectMake(padding+ ((size.width*column)+(padding*column)),
                                        padding+ ((size.height*theRow)+(padding*theRow)),
                                        icon.size.width, icon.size.height);
        

        [self addSubview:customButton];
        finalHeight = (((theRow+1)*size.height)+(padding*theRow)) + padding;
        finalWidht = ((rowTotal *size.width)+(padding*rowTotal)) + padding;

    }
    


    [self setFrame:CGRectMake(CGRectGetMinX(self.menuBtn.frame),
                               CGRectGetMaxY(self.menuBtn.frame),
                               finalWidht,
                               finalHeight)];
//    self.alpha = 0.0f;
    self.center = CGPointMake(self.menuBtn.center.x, self.center.y);
    [self setTransform:CGAffineTransformMakeScale(1.0, 0.0)];

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
    
    for(int i = 0; i < self.itemCount; i++){
        UIButton *thisButton = (UIButton*) [self viewWithTag:i + kButtonBaseTag];
        if(i + kButtonBaseTag == button.tag)
            thisButton.selected = YES;
        else
            thisButton.selected = NO;
    }
    
    [self.itemSelectedDelegate ibSpringMenu:self itemSelectedAtIndex:button.tag - kButtonBaseTag];
}

-(void)resetSelfFrame{
//    CGRect r = self.frame;
//    r.origin.y = self.menuBtn.frame.origin.y-self.frame.size.height,

    [UIView animateWithDuration: self.showingDuration*kIncreaseDurationBy delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.frame = r;
//        self.alpha = 0.0f;
        [self setTransform:CGAffineTransformMakeScale(1.0, 0.0)];
    }completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

#pragma mark-
#pragma mark shake animation

-(void)doHidingTheBtnsAnimation_kShake{
    if (animTag >=0) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        CGAffineTransform leftShake = CGAffineTransformMakeTranslation(-5, 0);

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.hidingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseOut animations:^{
                [UIView setAnimationRepeatCount:5];
                button.imageView.transform = leftShake;
            }completion:^(BOOL finished) {
                button.alpha = 0.0f;
                animTag--;
                [self performSelector:@selector(doHidingTheBtnsAnimation_kShake) withObject:nil afterDelay:self.hidingDuration];
            }];
        });
    }else{
        [self performSelector:@selector(resetSelfFrame) withObject:nil afterDelay:self.hidingDuration];
    }
}

-(void)doShowingTheBtnsAnimation_kShake{
    if (animTag < self.itemCount) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        CGAffineTransform rightShake = CGAffineTransformMakeTranslation(5, 0);

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.showingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseIn animations:^{
                button.alpha = 1.0f;
                [UIView setAnimationRepeatCount:5];
                button.imageView.transform = rightShake;
            }completion:^(BOOL finished) {
                animTag++;
                [self performSelector:@selector(doShowingTheBtnsAnimation_kShake) withObject:nil afterDelay:self.showingDuration];
            }];
        });
    }else{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

#pragma mark-
#pragma mark Alpha animation

-(void)doShowingTheBtnsAnimation_kFade{
    if (animTag < self.itemCount) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.showingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseOut animations:^{
                button.alpha = 1.0f;
            }completion:^(BOOL finished) {
            animTag++;
            [self performSelector:@selector(doShowingTheBtnsAnimation_kFade) withObject:nil afterDelay:self.showingDuration];
            }];
        });
    }else{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}


-(void)doHidingTheBtnsAnimation_kFade{
    if (animTag >=0) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.hidingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseOut animations:^{
                button.alpha = 0.0f;
            }completion:^(BOOL finished){
                animTag--;
                [self performSelector:@selector(doHidingTheBtnsAnimation_kFade) withObject:nil afterDelay:self.hidingDuration];
            }];
        });
    }else{
        [self performSelector:@selector(resetSelfFrame) withObject:nil afterDelay:self.hidingDuration];
    }
}

#pragma mark-
#pragma mark shake animation

-(void)doHidingTheBtnsAnimation_kSpring{
    if (animTag >=0) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        CGAffineTransform upShake = CGAffineTransformMakeTranslation(0, -5);
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.hidingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseOut animations:^{
                [UIView setAnimationRepeatCount:2];
                button.imageView.transform = upShake;
            }completion:^(BOOL finished) {
                button.alpha = 0.0f;
                animTag--;
                [self performSelector:@selector(doHidingTheBtnsAnimation_kSpring) withObject:nil afterDelay:self.hidingDuration];
            }];
        });
    }else{
        [self performSelector:@selector(resetSelfFrame) withObject:nil afterDelay:self.hidingDuration];
    }
}

-(void)doShowingTheBtnsAnimation_kSpring{
    if (animTag < self.itemCount) {
        UIButton *button = (UIButton *)[self viewWithTag:animTag+kButtonBaseTag];
        CGAffineTransform downShake = CGAffineTransformMakeTranslation(0, 5);
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [UIView animateWithDuration: self.showingDuration delay:kDelayAnimation options:UIViewAnimationOptionCurveEaseIn animations:^{
                button.alpha = 1.0f;
                [UIView setAnimationRepeatCount:2];
                button.imageView.transform = downShake;
            }completion:^(BOOL finished) {
                animTag++;
                [self performSelector:@selector(doShowingTheBtnsAnimation_kSpring) withObject:nil afterDelay:self.showingDuration];
            }];
        });
    }else{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

#pragma mark-
#pragma mark animation call

-(void)showSpringMenu:(AnimationType)animationType{
    animTag = 0;
    self.animationType = animationType;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

//    CGRect r = self.frame;
//    r.origin.y = CGRectGetMaxY(self.menuBtn.frame);
    
    [UIView animateWithDuration: self.showingDuration*kIncreaseDurationBy delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.alpha = 1.0f;
//        self.frame = r;
        [self setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    }completion:^(BOOL finished) {
        switch (self.animationType) {
            case kSpring:
                [self doShowingTheBtnsAnimation_kSpring];
                break;
            case kFade:
                [self doShowingTheBtnsAnimation_kFade];
                break;
            case kShake:
                [self doShowingTheBtnsAnimation_kShake];
                break;
                
                
            default:
                break;
        }
    }];
}

-(void)hideSpringMenu{
    animTag = self.itemCount;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    switch (self.animationType) {
        case kSpring:
            [self doHidingTheBtnsAnimation_kSpring];
            break;
        case kFade:
            [self doHidingTheBtnsAnimation_kFade];
            break;
        case kShake:
            [self doHidingTheBtnsAnimation_kShake];
            break;
 
        default:
            break;
    }
}

@end
