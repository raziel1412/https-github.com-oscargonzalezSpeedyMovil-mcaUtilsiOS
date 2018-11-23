//
//  Interface.h
//  engine
//
//  Created by Iván Galaz Jeria on 14-07-16.
//  Copyright © 2016 khipu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
    
#import "KhenshinEnums.h"
#import "ProcessHeader.h"
#import "ProcessExit.h"
#import "KhenshinRunner.h"
#import "KhenshinBuilder.h"

@protocol GAITracker;
@class UINavigationController, Manager;
@class KhenshinBuilder;
@class KhenshinRunner;


@interface KhenshinInterface : NSObject

+ (void) destroyManager;
// barCenteredLogo 121x48
// barLeftSideLogo 110x42
+ (void) initWithNavigationBarCenteredLogo:(UIImage *)                              barCenteredLogo
                 NavigationBarLeftSideLogo:(UIImage *)                              barLeftSideLogo
                           automatonAPIURL:(NSURL *)                                automatonAPIURL
                             cerebroAPIURL:(NSURL *)                                cerebroAPIURL
                             processHeader:(UIView<ProcessHeader> *)                processHeader
                            processFailure:(UIViewController<ProcessExit> *)        processFailure
                            processSuccess:(UIViewController<ProcessExit> *)        processSuccess
                            processWarning:(UIViewController<ProcessExit> *)        processWarning
                    allowCredentialsSaving:(BOOL)                                   allowCredentialsSaving
                           mainButtonStyle:(KHMainButton)                           mainButtonStyle
           hideWebAddressInformationInForm:(BOOL)                                   hideWebAddressInformationInForm
                  useBarCenteredLogoInForm:(BOOL)                                   useBarCenteredLogoInForm
                            principalColor:(UIColor *)                              principalColor
                      darkerPrincipalColor:(UIColor *)                              darkerPrincipalColor
                            secondaryColor:(UIColor *)                              secondaryColor
                     navigationBarTextTint:(UIColor *)                              navigationBarTextTint
                                      font:(UIFont *)                               font __deprecated;


+ (void) initWithNavigationBarCenteredLogo:(UIImage *)                              barCenteredLogo
                 NavigationBarLeftSideLogo:(UIImage *)                              barLeftSideLogo
                           automatonAPIURL:(NSURL *)                                automatonAPIURL
                             cerebroAPIURL:(NSURL *)                                cerebroAPIURL
                             processHeader:(UIView<ProcessHeader> *)                processHeader
                            processFailure:(UIViewController<ProcessExit> *)        processFailure
                            processSuccess:(UIViewController<ProcessExit> *)        processSuccess
                            processWarning:(UIViewController<ProcessExit> *)        processWarning
                    allowCredentialsSaving:(BOOL)                                   allowCredentialsSaving
                           mainButtonStyle:(KHMainButton)                           mainButtonStyle
           hideWebAddressInformationInForm:(BOOL)                                   hideWebAddressInformationInForm
                  useBarCenteredLogoInForm:(BOOL)                                   useBarCenteredLogoInForm
                            principalColor:(UIColor *)                              principalColor
                      darkerPrincipalColor:(UIColor *)                              darkerPrincipalColor
                            secondaryColor:(UIColor *)                              secondaryColor
                     navigationBarTextTint:(UIColor *)                              navigationBarTextTint
                                      font:(UIFont *)                               font
                              skipExitPage:(BOOL)                                   skipExitPage __deprecated;

+ (void) initWithNavigationBarCenteredLogo:(UIImage *)                              barCenteredLogo
                 NavigationBarLeftSideLogo:(UIImage *)                              barLeftSideLogo
                           automatonAPIURL:(NSURL *)                                automatonAPIURL
                             cerebroAPIURL:(NSURL *)                                cerebroAPIURL
                             processHeader:(UIView<ProcessHeader> *)         processHeader
                    allowCredentialsSaving:(BOOL)                                   allowCredentialsSaving
                           mainButtonStyle:(NSInteger)                              mainButtonStyle
           hideWebAddressInformationInForm:(BOOL)                                   hideWebAddressInformationInForm
                  useBarCenteredLogoInForm:(BOOL)                                   useBarCenteredLogoInForm
                            principalColor:(UIColor *)                              principalColor
                      darkerPrincipalColor:(UIColor *)                              darkerPrincipalColor
                            secondaryColor:(UIColor *)                              secondaryColor
                     navigationBarTextTint:(UIColor *)                              navigationBarTextTint
                                      font:(UIFont *)                               font
                              skipExitPage:(BOOL)                                   skipExitPage __deprecated;

+ (BOOL) isRunningAutomaton;

+ (void) isThereAnAutomatonForFingerPrint:(NSString*) fingerPrint
                        completionHandler:(void (^)(BOOL result))completionHandler;

+ (void) removeAllCredentialsWithUser:(NSString*) userIdentifier;;

+ (void) removeAllStoredCookiesForBankExternalId:(NSString *) externalId
                           completionHandler:(void (^)()) completionHandler;

+ (void) removeCredentialsForBankExternalId:(NSString *) externalId
                         userIdentifier:(NSString*) userIdentifier
                      completionHandler:(void (^)()) completionHandler;

+ (void) savedBanksWithCredentialsForUserIdentifier:(NSString*) userIdentifier
                                  completionHandler:(void (^)(NSArray*)) completionHandler;
+ (void) savedBanksWithCookiesForUserIdentifier:(NSString*) userIdentifier
                              completionHandler:(void (^)(NSArray*)) completionHandler;

+ (void) startEngineWithPaymentExternalId:(NSString*) paymentExternalId
                           userIdentifier:(NSString*) userIdentifier
                        isExternalPayment:(BOOL) externalPayment
                                  success:(void (^)(NSURL *returnURL))success
                                  failure:(void (^)(NSURL *returnURL))failure
                                 animated:(BOOL) animated;

+ (void) startEngineWithPaymentExternalId:(NSString*) paymentExternalId
                           userIdentifier:(NSString*) userIdentifier
                        isExternalPayment:(BOOL) externalPayment
                                  success:(void (^)(NSURL *returnURL))success
                                  failure:(void (^)(NSURL *returnURL))failure
                                 animated:(BOOL) animated
                     navigationController:(UINavigationController*) navigationController;

+ (void) startEngineWithPaymentNumericoCode:(NSString*) numericCode
                             userIdentifier:(NSString*) userIdentifier
                          isExternalPayment:(BOOL) externalPayment
                                    success:(void (^)(NSURL *returnURL))success
                                    failure:(void (^)(NSURL *returnURL))failure
                                   animated:(BOOL) animated;

+ (void) startEngineWithPaymentNumericCode:(NSString*) numericCode
                     withPaymentExternalId:(NSString*) paymentExternalId
                                userIdentifier:(NSString*) userIdentifier
                         isExternalPayment:(BOOL) externalPayment
                                   success:(void (^)(NSURL *returnURL))success
                                   failure:(void (^)(NSURL *returnURL))failure
                                  animated:(BOOL) animated
                      navigationController:(UINavigationController*) navigationController;

+ (void) setAutomatonTimeout:(NSTimeInterval)timeout;
+ (void) setGoogleTracker:(id<GAITracker>) tracker;
+ (void) setPreferredStatusBarStyle:(UIStatusBarStyle) preferredStatusBarStyle;
+ (void) setPrefersStatusBarHidden:(BOOL) prefersStatusBarHidden;
+ (void) setOtherThanOwnerWillPayOnThisDevice:(BOOL) isOtherThanOwnerPayingOnThisDevice;
+ (void) setExitMessagesShouldUseRawValue:(BOOL) useRawValue;

+ (void) startEngineWithAutomatonId:(NSString*) automatonId
                           animated:(BOOL) animated
                         parameters:(NSDictionary*) parameters
                     userIdentifier:(NSString*) userIdentifier
                            success:(void (^)(NSURL *returnURL))success
                            failure:(void (^)(NSURL *returnURL))failure;

+ (void) startEngineWithAutomatonId:(NSString*) automatonId
                           animated:(BOOL) animated
                         parameters:(NSDictionary*) parameters
                     userIdentifier:(NSString*) userIdentifier
               navigationController:(UINavigationController*) navigationController
                            success:(void (^)(NSURL *returnURL))success
                            failure:(void (^)(NSURL *returnURL))failure;

+ (void) startEngineWithAutomatonRequestId:(NSString*) automatonRequestId
                                  animated:(BOOL) animated
                            userIdentifier:(NSString*) userIdentifier
                      navigationController:(UINavigationController*) navigationController
                                   success:(void (^)(NSURL *returnURL))success
                                   failure:(void (^)(NSURL *returnURL))failure;

+ (void) startEngineWithAutomatonByFingerPrint:(NSString*) fingerPrint
                                      animated:(BOOL) animated
                                userIdentifier:(NSString*) userIdentifier
                          navigationController:(UINavigationController*) navigationController
                                       success:(void (^)(NSURL *returnURL))success
                                       failure:(void (^)(NSURL *returnURL))failure;

+ (BOOL) validateInitialization;


+ (void) startEngineWithAutomatonId:(NSString*) automatonId
                           animated:(BOOL) animated
                         parameters:(NSDictionary*) parameters
                     userIdentifier:(NSString*) userIdentifier
                successWithResponse:(void (^)(NSDictionary *response))success
                failureWithResponse:(void (^)(NSDictionary *response))failure __deprecated;


+ (void) startEngineWithAutomatonId:(NSString*) automatonId
                           animated:(BOOL) animated
                         parameters:(NSDictionary*) parameters
                     userIdentifier:(NSString*) userIdentifier
               navigationController:(UINavigationController*) navigationController
                successWithResponse:(void (^)(NSDictionary *response))success
                failureWithResponse:(void (^)(NSDictionary *response))failure __deprecated;

+ (void (^)(NSDictionary *)) wrapCallbackThatExpectsReturnURL: ( void(^)(NSURL *) )callback;

+ (void) startWithRunnerBlock: (void (^)(KhenshinRunner *runner) )runnerBlock;
+ (void) initWithBuilderBlock: (void (^)(KhenshinBuilder *builder) )builderBlock;
+ (void) notifyAppEvent:(NSString*) operationId
              withExtra:(NSDictionary*) extra;
+ (void) notifyAppException:(NSString *) operationId
                 withAction:(NSString *) action
                 andProcess:(NSString *) process
                 andMessage:(NSString *) message;

@end



