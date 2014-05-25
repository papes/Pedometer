//
//  ViewController.m
//  Pedometer
//
//  Created by brett davis on 5/25/14.
//  Copyright (c) 2014 brett davis. All rights reserved.
//

#import "ViewController.h"
#import "BDStepModelController.h"

@interface ViewController ()

@end

@implementation ViewController

{
    BDStepModelController *_stepModel;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _stepModel = [[BDStepModelController alloc] init];
    
    [_stepModel addObserver:self forKeyPath:@"stepsToday"
                    options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (void)dealloc
{
    [_stepModel removeObserver:self forKeyPath:@"stepsToday"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self _updateSteps:_stepModel.stepsToday];
}

- (void)_updateSteps:(NSInteger)steps
{
    // force main queue for UIKit
    dispatch_async(dispatch_get_main_queue(), ^{
        if (steps>=0)
        {
            self.stepsLabel.text = [NSString stringWithFormat:@"%ld",
                                    (long)steps];
            self.stepsLabel.textColor = [UIColor colorWithRed:0
                                                        green:0.3
                                                         blue:0.8
                                                        alpha:1];
        }
        else
        {
            self.stepsLabel.text = @"Not available";
            self.stepsLabel.textColor = [UIColor redColor];
        }
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
