//
//  GameViewController.m
//  cs441-2048
//
//  Created by John Doe on 2/11/19.
//  Copyright © 2019 Robert Burton. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController () {
    int grid[16];
}
@end

@implementation GameViewController
@synthesize statusLabel, swipeLeft, swipeRight, swipeUp, swipeDown, labels;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeUp];
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeDown];
    
    [statusLabel setText:@"Testing!"];
    [self gameStart];
}
- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        [statusLabel setText:@"Left Swipe!"];
        
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        [statusLabel setText:@"Right Swipe!"];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Up Swipe");
        [statusLabel setText:@"Up Swipe!"];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Down Swipe");
        [statusLabel setText:@"Down Swipe!"];
        //[statusLabel setText:[labels[10] text]];
    }
}

- (void)gameStart {
    unsigned int i;
    for(i = 0; i < 16; i++)
    {
        [labels[i] setText:@"0"];
        grid[i] = 0;
    }
    
    int r = arc4random_uniform(16);
    grid[r] = 1;
    
    for(i = 0; i < 16; i++)
    {
        [labels[i] setText:[NSString stringWithFormat:@"%d", grid[i]]];
    }
}

- (void)assesMove:(int) dir {
    if(dir==0) {
        
    }
    unsigned int i;
    for(i = 0; i < 16; i++)
    {
        [labels[i] setText:[NSString stringWithFormat:@"%d", grid[i]]];
    }
}

- (void)assesRow:(int[4]) set {
    if(grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[3]]!=0 && grid[set[4]]!=0 ) {
        grid[set[0]] = grid[set[0]]*2;
        grid[set[1]] = grid[set[2]];
        grid[set[2]] = grid[set[3]];
        grid[set[3]] = 0;
        if(grid[set[1]]==grid[set[2]]) {
            grid[set[1]]*=2;
            grid[set[2]]=0;
        }
    } else if (grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[2]]==0 && grid[set[3]]!=0 ) {
        grid[set[0]] = grid[set[0]]*2;
        grid[set[1]] = grid[set[3]];
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else if (grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[3]]==0 && grid[set[2]]!=0 ) {
        grid[set[0]] = grid[set[0]]*2;
        grid[set[1]] = grid[set[2]];
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else if (grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[2]]==0 && grid[set[3]]==0 ) {
        grid[set[0]] = grid[set[0]]*2;
        grid[set[1]] = 0;
    } else if (grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[2]]==0 && grid[set[3]]==0 ) {
        grid[set[0]] = grid[set[0]]*2;
        grid[set[1]] = 0;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

