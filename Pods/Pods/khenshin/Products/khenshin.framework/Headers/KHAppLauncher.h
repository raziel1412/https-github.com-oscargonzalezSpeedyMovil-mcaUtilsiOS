//
//  KHAppLauncher.h
//  khenshin
//
//  Created by Nicolas Loira on 6/12/18.
//  Copyright © 2018 khipu. All rights reserved.
//

#ifndef KHAppLauncher_h
#define KHAppLauncher_h

@protocol KHAppLauncher

@required

- (void) inviteUserToReturn;
- (void) openAppWithSchema:(NSString*) schema orRedirectTo:(NSString*) storeLink;

@end

#endif /* KHAppLauncher_h */
