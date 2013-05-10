//
//  JKViewController.m
//  QCMobile
//
//  Created by Joris Kluivers on 5/5/13.
//  Copyright (c) 2013 Joris Kluivers. All rights reserved.
//

#import "JKViewController.h"
#import "JKComposition.h"
#import "JKQCView.h"

@interface JKViewController ()

@end

@implementation JKViewController

- (void) dealloc
{
    [self.qcView removeObserver:self forKeyPath:@"frameRate"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.qcView.context = context;
	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmptyTest" ofType:@"qtz"];
    
    JKComposition *composition = [[JKComposition alloc] initWithPath:path];
    
    self.qcView.composition = composition;
    [self.qcView setNeedsDisplay];
    
    [self.qcView addObserver:self forKeyPath:@"frameRate" options:0 context:NULL];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.qcView startAnimation];
}

- (IBAction) toggle:(id)sender
{
    if ([self.qcView isAnimating]) {
        [self.qcView stopAnimation];
    } else {
        [self.qcView startAnimation];
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frameRate"]) {
        self.rateLabel.text = [NSString stringWithFormat:@"%.0f fps", self.qcView.frameRate];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end