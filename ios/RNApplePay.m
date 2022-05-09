
#import "RNApplePay.h"
#import <React/RCTUtils.h>

@implementation RNApplePay

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSDictionary *)constantsToExport
{
    return @{
             @"canMakePayments": @([PKPaymentAuthorizationViewController canMakePayments]),
             @"SUCCESS": @(PKPaymentAuthorizationStatusSuccess),
             @"FAILURE": @(PKPaymentAuthorizationStatusFailure),
             @"DISMISSED_ERROR": @"DISMISSED_ERROR",
             };
}

RCT_EXPORT_METHOD(requestPayment:(NSDictionary *)props promiseWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
    paymentRequest.merchantCapabilities = PKMerchantCapability3DS;
    paymentRequest.merchantIdentifier = props[@"merchantIdentifier"];
    paymentRequest.countryCode = props[@"countryCode"];
    paymentRequest.currencyCode = props[@"currencyCode"];
    paymentRequest.supportedNetworks = [self getSupportedNetworks:props];
    paymentRequest.paymentSummaryItems = [self getPaymentSummaryItems:props];

    self.viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest: paymentRequest];
    self.viewController.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootViewController = RCTPresentedViewController();
        [rootViewController presentViewController:self.viewController animated:YES completion:nil];
        self.requestPaymentResolve = resolve;
    });
}

RCT_EXPORT_METHOD(canMakePaymentsUsingNetworks:(NSArray *)networks promiseWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        NSMutableArray *paymentNetworks = [[NSMutableArray alloc] initWithCapacity:networks.count];
        for (int i = 0; i < [networks count]; i++) {
          NSString *network = (NSString*) [networks objectAtIndex:i];
         
            if( [network caseInsensitiveCompare:@"visa"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkVisa];
                        }
            else if( [network caseInsensitiveCompare:@"amex"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkAmex];
                        }
            else if( [network caseInsensitiveCompare:@"cartebancaire"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkCarteBancaire];
                        }
            else if( [network caseInsensitiveCompare:@"cartebancaires"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkCarteBancaires];
                        }
            else if( [network caseInsensitiveCompare:@"cartesbancaires"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkCartesBancaires];
                        }
            else if( [network caseInsensitiveCompare:@"chinaunionpay"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkChinaUnionPay];
                        }
            else if( [network caseInsensitiveCompare:@"discover"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkDiscover];
                        }
            else if( [network caseInsensitiveCompare:@"eftpos"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkEftpos];
                        }
            else if( [network caseInsensitiveCompare:@"electron"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkElectron];
                        }
            else if( [network caseInsensitiveCompare:@"elo"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkElo];
                        }
            else if( [network caseInsensitiveCompare:@"idcredit"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkIDCredit];
                        }
            else if( [network caseInsensitiveCompare:@"interac"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkInterac];
                        }
            else if( [network caseInsensitiveCompare:@"jcb"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkJCB];
                        }
            else if( [network caseInsensitiveCompare:@"mada"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkMada];
                        }
            else if( [network caseInsensitiveCompare:@"maestro"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkMaestro];
                        }
            else if( [network caseInsensitiveCompare:@"mastercard"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkMasterCard];
                        }
            else if( [network caseInsensitiveCompare:@"mir"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkMir];
                        }
            else if( [network caseInsensitiveCompare:@"privatelabel"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkPrivateLabel];
                        }
            else if( [network caseInsensitiveCompare:@"quicpay"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkQuicPay];
                        }
            else if( [network caseInsensitiveCompare:@"suica"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkSuica];
                        }
            else if( [network caseInsensitiveCompare:@"vpay"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkVPay];
                        }
            else if( [network caseInsensitiveCompare:@"barcode"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkBarcode];
                        }
            else if( [network caseInsensitiveCompare:@"girocard"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkGirocard];
                        }
            else if( [network caseInsensitiveCompare:@"waon"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkWaon];
                        }
            else if( [network caseInsensitiveCompare:@"nanaco"] == NSOrderedSame ) {
                            [paymentNetworks addObject: PKPaymentNetworkNanaco];
                        }
        }
        BOOL canMakePaymentsUsingTheseNetworks=[PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:paymentNetworks];
        resolve(@(canMakePaymentsUsingTheseNetworks));
   }
   @catch (NSException *exception) {
       reject(exception.name, exception.reason, nil);
   }
    
}

RCT_EXPORT_METHOD(complete:(NSNumber *_Nonnull)status promiseWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    if (self.completion != NULL) {
        self.completeResolve = resolve;
        if ([status isEqualToNumber: self.constantsToExport[@"SUCCESS"]]) {
            self.completion(PKPaymentAuthorizationStatusSuccess);
        } else {
            self.completion(PKPaymentAuthorizationStatusFailure);
        }
        self.completion = NULL;
    }
}

- (NSArray *_Nonnull)getSupportedNetworks:(NSDictionary *_Nonnull)props
{
    NSMutableDictionary *supportedNetworksMapping = [[NSMutableDictionary alloc] init];

    if (@available(iOS 8, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkAmex forKey:@"amex"];
        [supportedNetworksMapping setObject:PKPaymentNetworkMasterCard forKey:@"mastercard"];
        [supportedNetworksMapping setObject:PKPaymentNetworkVisa forKey:@"visa"];
    }

    if (@available(iOS 9, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkDiscover forKey:@"discover"];
        [supportedNetworksMapping setObject:PKPaymentNetworkPrivateLabel forKey:@"privatelabel"];
    }

    if (@available(iOS 9.2, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkChinaUnionPay forKey:@"chinaunionpay"];
        [supportedNetworksMapping setObject:PKPaymentNetworkInterac forKey:@"interac"];
    }

    if (@available(iOS 10.1, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkJCB forKey:@"jcb"];
        [supportedNetworksMapping setObject:PKPaymentNetworkSuica forKey:@"suica"];
    }

    if (@available(iOS 10.3, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkCarteBancaire forKey:@"cartebancaires"];
        [supportedNetworksMapping setObject:PKPaymentNetworkIDCredit forKey:@"idcredit"];
        [supportedNetworksMapping setObject:PKPaymentNetworkQuicPay forKey:@"quicpay"];
    }

    if (@available(iOS 11.0, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkCarteBancaires forKey:@"cartebancaires"];
    }

    if (@available(iOS 12.0, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkMaestro forKey:@"maestro"];

    }

    if (@available(iOS 12.1.1, *)) {
        [supportedNetworksMapping setObject:PKPaymentNetworkMada forKey:@"mada"];
    }

    NSArray *supportedNetworksProp = props[@"supportedNetworks"];
    NSMutableArray *supportedNetworks = [NSMutableArray array];
    for (NSString *supportedNetwork in supportedNetworksProp) {
        if(supportedNetworksMapping[supportedNetwork] != nil){
            [supportedNetworks addObject: supportedNetworksMapping[supportedNetwork]];
        }
    }

    return supportedNetworks;
}

- (NSArray<PKPaymentSummaryItem *> *_Nonnull)getPaymentSummaryItems:(NSDictionary *_Nonnull)props
{
    NSMutableArray <PKPaymentSummaryItem *> * paymentSummaryItems = [NSMutableArray array];

    NSArray *displayItems = props[@"paymentSummaryItems"];
    if (displayItems.count > 0) {
        for (NSDictionary *displayItem in displayItems) {
            NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:displayItem[@"amount"]];
            NSString *label = displayItem[@"label"];
            [paymentSummaryItems addObject: [PKPaymentSummaryItem summaryItemWithLabel:label amount:amount]];
        }
    }

    return paymentSummaryItems;
}

- (void) paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                        didAuthorizePayment:(PKPayment *)payment
                                 completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    self.completion = completion;
    if (self.requestPaymentResolve != NULL) {
        NSString *paymentData = [[NSString alloc] initWithData:payment.token.paymentData encoding:NSUTF8StringEncoding];
        NSMutableDictionary *paymentResponse = [[NSMutableDictionary alloc]initWithCapacity:4];
        [paymentResponse setObject:paymentData forKey:@"paymentData"];
        [paymentResponse setObject:payment.token.transactionIdentifier forKey:@"transactionId"];
        [paymentResponse setObject:payment.token.paymentMethod.displayName forKey:@"displayName"];
        [paymentResponse setObject:payment.token.paymentMethod.network forKey:@"network"];
        NSString *type = nil;
        switch (payment.token.paymentMethod.type) {
            case PKPaymentMethodTypeDebit:
                type = @"debit";
                break;
                case PKPaymentMethodTypeStore:
                type = @"store";
                break;
                case PKPaymentMethodTypeCredit:
                type = @"credit";
                break;
                case PKPaymentMethodTypePrepaid:
                type = @"prepaid";
                break;
                case PKPaymentMethodTypeUnknown:
                type = @"unknown";
                break;
            default:
                break;
        }
        [paymentResponse setObject:type forKey:@"type"];
        NSError *error;
        NSData *json = [NSJSONSerialization dataWithJSONObject:paymentResponse options:NSJSONWritingPrettyPrinted error: &error];

        self.requestPaymentResolve([[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding]);
        self.requestPaymentResolve = NULL;
    }
}

- (void)paymentAuthorizationViewControllerDidFinish:(nonnull PKPaymentAuthorizationViewController *)controller {
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller dismissViewControllerAnimated:YES completion:^void {
            if (self.completeResolve != NULL) {
                self.completeResolve(nil);
                self.completeResolve = NULL;
            }
            if (self.requestPaymentResolve != NULL) {
                self.requestPaymentResolve(nil);
                self.requestPaymentResolve = NULL;
            }
        }];
    });
}

@end
