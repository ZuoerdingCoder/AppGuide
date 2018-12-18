//
//  SMAppGuideViewController.h
//  APPGuideDemo
//
//  Created by ZED on 2018/12/5.
//  Copyright © 2018年 ZED. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMAppGuideViewControllerDelegate<NSObject>

- (void)appGuideViewControllerWillDismiss;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SMAppGuideViewController : UIViewController

@property (nonatomic, weak) id<SMAppGuideViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString *> *guideImageNames;

@end

NS_ASSUME_NONNULL_END
