//
//  KhenshinRunner.h
//  khenshin
//
//  Created by Nicolas Loira on 4/24/18.
//  Copyright © 2018 khipu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface KhenshinRunner : NSObject

typedef NS_ENUM(NSInteger, KhenshinRunType){
    KHRunWithPaymentExternalId,
    KHRunWithNumericCode,
    KHRunWithAutomatonId,
    KHRunWithAutomatonRequestId,
    KHRunWithAutomatonByFingerPrint,
    KHNoRun
};

@property NSString* automatonId;
@property BOOL animated;
@property NSDictionary* parameters;
@property NSString* userIdentifier;
@property (nonatomic, copy) void(^successWithResponse)(NSDictionary *response);
@property (nonatomic, copy) void(^failureWithResponse)(NSDictionary *response);
@property (nonatomic, copy) void(^success)(NSURL *returnURL);
@property (nonatomic, copy) void(^failure)(NSURL *returnURL);
@property BOOL autoSubmitIfComplete;
@property BOOL hideProgressDialogInTransition;
@property (weak, nonatomic) UINavigationController* navigationController;
@property KhenshinRunType runType;

-(void) run;
@end
