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
@synthesize statusLabel, swipeLeft, swipeRight, swipeUp, swipeDown, labels, scoreLabel;

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
        [self assesMove:(int)2];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        [statusLabel setText:@"Right Swipe!"];
        [self assesMove:(int)3];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Up Swipe");
        [statusLabel setText:@"Up Swipe!"];
        [self assesMove:(int)0];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Down Swipe");
        [statusLabel setText:@"Down Swipe!"];
        [self assesMove:(int)1];
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
    
    int r = arc4random_uniform(15);
    grid[r] = 2;
    
    for(i = 0; i < 16; i++)
    {
        [labels[i] setText:[NSString stringWithFormat:@"%d", grid[i]]];
    }
}

- (void)assesMove:(int) dir {
    if(dir==0) {
        [self assesRow:(int[4]){0,4,8,12}];
        [self assesRow:(int[4]){1,5,9,13}];
        [self assesRow:(int[4]){2,6,10,14}];
        [self assesRow:(int[4]){3,7,11,15}];
    } else if(dir==1) {
        [self assesRow:(int[4]){12,8,4,0}];
        [self assesRow:(int[4]){13,9,5,1}];
        [self assesRow:(int[4]){14,10,6,2}];
        [self assesRow:(int[4]){15,11,7,3}];
    } else if(dir==2) {
        [self assesRow:(int[4]){0,1,2,3}];
        [self assesRow:(int[4]){4,5,6,7}];
        [self assesRow:(int[4]){8,9,10,11}];
        [self assesRow:(int[4]){12,13,14,15}];
    } else if(dir==3) {
        [self assesRow:(int[4]){3,2,1,0}];
        [self assesRow:(int[4]){7,6,5,4}];
        [self assesRow:(int[4]){11,10,9,8}];
        [self assesRow:(int[4]){15,14,13,12}];
    }
    unsigned int i;
    
    for(i = 0; i < 17; i++)
    {
        if(i==16) {
            [statusLabel setText:@"GAME OVER"];
            break;
        }
        int r = arc4random_uniform(16);
        if(grid[r]==0) {
            grid[r]=2;
            break;
        }
    }
    int sum = 0;
    for(i = 0; i < 16; i++)
    {
        sum+=grid[i];
        [labels[i] setText:[NSString stringWithFormat:@"%d", grid[i]]];
    }
    [scoreLabel setText:[NSString stringWithFormat:@"%d", sum]];
    for ( int i=0; i<16; i+=4 ) {
        NSLog(@"%i %i %i %i", grid[i], grid[i+1], grid[i+2], grid[i+3]);
    }
}

- (void)assesRow:(int[4]) set {
    if(grid[set[0]]==grid[set[1]] && grid[set[0]]!=0 && grid[set[2]]!=0 && grid[set[3]]!=0 ) {
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
    } else if (grid[set[0]]==0 && grid[set[1]]==0 && grid[set[2]] == grid[set[3]]) {
        grid[set[0]] = grid[set[2]]*2;
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else if (grid[set[0]]==0 && grid[set[1]]!=0 && grid[set[2]] == grid[set[3]]) {
        grid[set[0]] = grid[set[1]];
        grid[set[1]] = grid[set[2]]*2;
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else if (grid[set[0]]!=0 && grid[set[1]]==0 && grid[set[2]] == grid[set[3]]) {
        grid[set[1]] = grid[set[2]]*2;
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else if (grid[set[0]]!=0 && grid[set[1]]!=0 && grid[set[0]]!=grid[set[1]] && grid[set[2]] == grid[set[3]]) {
        grid[set[2]] = grid[set[2]]*2;
        grid[set[3]] = 0;
    } else if (grid[set[0]]!=0 && grid[set[1]]!=0 && grid[set[0]]!=grid[set[1]] && grid[set[1]] == grid[set[2]]) {
        grid[set[1]] = grid[set[1]]*2;
        grid[set[2]] = grid[set[3]];
        grid[set[3]] = 0;
    } else if (grid[set[0]]==0 && grid[set[1]]!=0 && grid[set[0]]!=grid[set[1]] && grid[set[1]] == grid[set[2]]) {
        grid[set[0]] = grid[set[1]]*2;
        grid[set[1]] = grid[set[3]];
        grid[set[2]] = 0;
        grid[set[3]] = 0;
    } else {
        if(grid[set[0]]==0 && grid[set[1]]!=0 && grid[set[2]]!=0) {
            grid[set[0]] = grid[set[1]];
            grid[set[1]] = grid[set[2]];
            grid[set[2]] = grid[set[3]];
            grid[set[3]] = 0;
        } else if (grid[set[0]]==0 && grid[set[1]]!=0 && grid[set[2]]==0 && grid[set[3]]!=0) {
            grid[set[0]] = grid[set[1]];
            grid[set[1]] = grid[set[3]];
            grid[set[2]] = 0;
            grid[set[3]] = 0;
        } else if (grid[set[0]]==0 && grid[set[1]]!=0 && grid[set[2]]==0 && grid[set[3]]==0) {
            grid[set[0]] = grid[set[1]];
            grid[set[1]] = 0;
            grid[set[2]] = 0;
            grid[set[3]] = 0;
        } else if (grid[set[0]]==0 && grid[set[1]]==0 && grid[set[2]]!=0 && grid[set[3]]==0) {
            grid[set[0]] = grid[set[2]];
            grid[set[1]] = 0;
            grid[set[2]] = 0;
            grid[set[3]] = 0;
        } else if (grid[set[0]]==0 && grid[set[1]]==0 && grid[set[2]]!=0 && grid[set[3]]!=0) {
            grid[set[0]] = grid[set[2]];
            grid[set[1]] = grid[set[3]];
            grid[set[2]] = 0;
            grid[set[3]] = 0;
        } else if (grid[set[0]]==0 && grid[set[1]]==0 && grid[set[2]]==0 && grid[set[3]]!=0) {
            grid[set[0]] = grid[set[3]];
            grid[set[1]] = 0;
            grid[set[2]] = 0;
            grid[set[3]] = 0;
        }
    }
}
- (IBAction)orbTapAction:(id)sender {
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

