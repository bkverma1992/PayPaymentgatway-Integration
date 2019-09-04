//
//  PayUServiceHelper.h
//  PayU
//
//  Created by Yugasalabs-28 on 18/06/2019.
//  Copyright © 2019 Yugasalabs-28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>



typedef void (^PayUCompletionBlock) (NSDictionary *dict, NSError *error );
typedef void (^PayUFailuerBlock)(NSError *error );


@interface PayUServiceHelper : NSObject

- (void)logOut;
- (void)getPayment:(UIViewController *)controller :(NSString*)email :(NSString*)phone :(NSString*)name :(NSString*)amount :(NSString*)trxnID didComplete:(PayUCompletionBlock)getPaymentBlock didFail:(PayUFailuerBlock)failBlock;
+ (PayUServiceHelper *)sharedManager;

@end
