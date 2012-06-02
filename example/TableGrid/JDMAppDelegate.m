//
// Copyright 2010-2012 JDMdesign.com 
// Created by Jeffrey Morris on 6/1/2012.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "JDMAppDelegate.h"
#import "JDMTableGridViewController.h"

@implementation JDMAppDelegate

@synthesize window = _window;

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JDMTableGridViewController *vc = [[[JDMTableGridViewController alloc] init] autorelease];
    UINavigationController *nvc = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    [self setWindow:[[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease]];
    [_window setRootViewController:nvc];
    [_window addSubview:nvc.view];
    [_window makeKeyAndVisible];
    return YES;
}

@end
