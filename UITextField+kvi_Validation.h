//
//  UITextField+kvi_Validation.h
//  TenInstitute
//
//  Created by Vasyl Khmil on 11/13/15.
//  Copyright © 2015 com.n-ix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (kvi_Validation)

@property (nonatomic, strong) IBInspectable NSString *validationRegex;

@property (nonatomic, strong) IBInspectable UIColor *invalidStateColor;

@property (nonatomic, strong) IBInspectable UIColor *validStateColor;

@property (nonatomic) IBInspectable NSUInteger minimalNumberOfCharacters;

@property (nonatomic) IBInspectable NSUInteger maximalNumberOfCharacters;




@property (nonatomic, readonly) BOOL isValid;

- (BOOL)checkIfIsValidAndUpdateValidationState;
+ (void)checkAllVisibleFieldsIfIsValidWithMatchedFields:(NSArray **)matchedFields
                                          faildedFields:(NSArray **)failedFields
                                           updateStates:(BOOL)updateStates;

@end
