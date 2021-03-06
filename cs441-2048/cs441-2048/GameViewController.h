//
//  GameViewController.h
//  cs441-2048
//
//  Created by John Doe on 2/11/19.
//  Copyright © 2019 Robert Burton. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeUp;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeDown;
@property (retain) IBOutletCollection(UILabel) NSArray *labels;

@end

NS_ASSUME_NONNULL_END
