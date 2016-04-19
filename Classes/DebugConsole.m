//
//  DebugConsole.m
//  jiuxian
//
//  Created by 张正超 on 15/12/4.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import "DebugConsole.h"
#import <UIKit/UIKit.h>

#define LOG_FILE_PATH [[DebugConsole documentsDirectory] stringByAppendingPathComponent:@"jiuxian.log"]
#define APPDELEGATE      ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface DebugConsole () {
    UITextView *textView;
}
@end

@implementation DebugConsole

+ (id)sharedInstance {
    static id __sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self class] new];
    });
    return __sharedInstance;
}

+ (NSMutableString *)documentsDirectory {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] mutableCopy];
}

- (id)init {
    if (self = [super init]) {
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup {
    [self resetLogData];
}

+ (void)startService {
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [DebugConsole sharedInstance];
    });
}

- (void)resetLogData {
    [NSFileManager.defaultManager removeItemAtPath:LOG_FILE_PATH error:nil];
    freopen([LOG_FILE_PATH fileSystemRepresentation], "a", stderr);
}


- (void)showConsole {
    if (textView == nil) {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        CGRect viewRectTextView = CGRectMake(0, bounds.size.height - bounds.size.height / 3, bounds.size.width, bounds.size.height / 3);

        textView = [[UITextView alloc] initWithFrame:viewRectTextView];
        [textView setBackgroundColor:[UIColor blackColor]];
        [textView setFont:[UIFont systemFontOfSize:12.0]];
        [textView setEditable:NO];
        [textView setTextColor:[UIColor whiteColor]];
        [[textView layer] setOpacity:0.6];

        [[[UIApplication sharedApplication] delegate].window addSubview:textView];
        [[[UIApplication sharedApplication] delegate].window bringSubviewToFront:textView];

        UISwipeGestureRecognizer *recogniser = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideWithAnimation)];
        [recogniser setDirection:UISwipeGestureRecognizerDirectionLeft];
        [textView addGestureRecognizer:recogniser];

        [self moveThisViewTowardsLeftToRight:textView duration:0.30];
        [self setUpToGetLogData];
        [self scrollToLast];

        [self addSwipeGesture];
    }
}

- (void)hideWithAnimation {
    [self moveThisViewTowardsLeft:textView duration:0.30];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self hideConsole];
    });
}

- (void)hideConsole {
    [textView removeFromSuperview];
    [NSNotificationCenter.defaultCenter removeObserver:self];
    textView = nil;

    [self resetLogData];

    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:NO] forKey:@"DebugToolShowLogBool"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)scrollToLast {
    NSRange txtOutputRange;
    txtOutputRange.location = textView.text.length;
    txtOutputRange.length = 0;
    textView.editable = YES;
    [textView scrollRangeToVisible:txtOutputRange];
    [textView setSelectedRange:txtOutputRange];
    textView.editable = NO;
}

- (void)setUpToGetLogData {
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:LOG_FILE_PATH];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(getData:) name:@"NSFileHandleReadCompletionNotification" object:fileHandle];
    [fileHandle readInBackgroundAndNotify];
}

- (void)getData:(NSNotification *)notification {
    NSData *data = notification.userInfo[NSFileHandleNotificationDataItem];
    if (data.length) {
        NSString *string = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        textView.editable = YES;
        textView.text = [textView.text stringByAppendingString:string];
        textView.editable = NO;
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            [self scrollToLast];
        });
        [notification.object readInBackgroundAndNotify];
    }
    else {
        [self performSelector:@selector(refreshLog:) withObject:notification afterDelay:1.0];
    }
}

- (void)refreshLog:(NSNotification *)notification {
    [notification.object readInBackgroundAndNotify];
}

- (void)moveThisViewTowardsLeft:(UIView *)view duration:(float)dur; {
    [UIView animateWithDuration:dur animations:^{
        [view setFrame:CGRectMake(view.frame.origin.x - [[UIScreen mainScreen] bounds].size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    }                completion:^(BOOL finished) {
    }];
}

- (void)moveThisViewTowardsLeftToRight:(UIView *)view duration:(float)dur; {
    CGRect original = [view frame];
    [view setFrame:CGRectMake(view.frame.origin.x - [[UIScreen mainScreen] bounds].size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    [UIView animateWithDuration:dur animations:^{
        [view setFrame:original];
    }                completion:^(BOOL finished) {
    }];
}

- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideConsole:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [textView addGestureRecognizer:swipe];
}

- (void)hideConsole:(UIGestureRecognizer *)gesture {
    UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *) gesture;
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self hideWithAnimation];
    }
}


@end
