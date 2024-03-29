//
//  ViewController.m
//  TFYCrashException
//
//  Created by 田风有 on 2023/2/24.
//

#import "ViewController.h"
#import "TFYCrashSDK.h"
#import <objc/runtime.h>
#import "PushViewController.h"

@interface ViewController ()<TFYCrashExceptionHandle>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* startGuardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startGuardButton setTitle:@"Start Guard" forState:UIControlStateNormal];
    [startGuardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startGuardButton.frame = CGRectMake((self.view.frame.size.width - 100)/2, 250, 100, 50);
    [startGuardButton addTarget:self action:@selector(startGuardAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startGuardButton];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Test KVO|NotificatinCenter|NSTimer" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 300, self.view.frame.size.width, 50);
    [button addTarget:self action:@selector(testKVONotificatinCenterNSTimerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton* otherButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [otherButton setTitle:@"Test NSArray|NSDictionary|UnrecognizedSelector|NSNull" forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    otherButton.frame = CGRectMake(0, 350, self.view.frame.size.width, 50);
    [otherButton addTarget:self action:@selector(testArrayDictionaryUnrecognizedSelector) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherButton];
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 100)/2 , 400, 100, 20)];
    textField.secureTextEntry = YES;
    textField.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:textField];
}

- (void)crashhandleCrashException:(NSString*)exceptionMessage extraInfo:(NSDictionary*)info{

    NSLog(@"info============:%@================exceptionMessage======:%@===:%@",info,exceptionMessage,[TFYLogTool tfy_getCurrentLogContents]);
}

#pragma mark - Action

- (void)startGuardAction {
    [TFYCrashException registerExceptionHandle:self];
}

#pragma mark - Test Action

- (void)testKVONotificatinCenterNSTimerAction{
    PushViewController* push = [[PushViewController alloc] init];
    [self presentViewController:push animated:YES completion:nil];
}

- (void)testArrayDictionaryUnrecognizedSelector{
    [self testSampleArray];
    [self testSimpleDictionary];
    [self testUnrecognizedSelector];
    [self testNull];
}

- (void)testSampleArray{
    NSArray* test = @[];
    NSLog(@"object:%@",test[1]);
}

- (void)testSimpleDictionary{
    id value = nil;
    NSDictionary* dic = @{@"key":value};
    NSLog(@"dic:%@",dic);
}

- (void)testUnrecognizedSelector{
    [self performSelector:@selector(testUndefineSelector)];
    [self performSelector:@selector(crashhandleCrashException:exceptionCategory:extraInfo:)];
}

- (void)testNull{
    NSNull* null = [NSNull null];
    NSString* str = (NSString*)null;
    NSLog(@"Str length:%ld",str.length);
}

@end
