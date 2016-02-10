//
//  UITextField+kvi_Validation.h
//  TenInstitute
//
//  Created by Vasyl Khmil on 11/13/15.
//  Copyright © 2015 com.n-ix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (kvi_Validation)

@property (nonatomic, strong, nullable) IBInspectable NSString *validationRegex;

@property (nonatomic, strong, nullable) IBInspectable UIColor *invalidStateColor;

@property (nonatomic, strong, nullable) IBInspectable UIColor *validStateColor;

@property (nonatomic) IBInspectable NSUInteger minimalNumberOfCharacters;

@property (nonatomic) IBInspectable NSUInteger maximalNumberOfCharacters;

@property (nonatomic) IBInspectable BOOL showErrorMessage;

@property (nonatomic) IBInspectable BOOL showErrorImage;

@property (nonatomic) CGFloat borderWidth;

@property (nonatomic, strong, nullable) IBInspectable NSString *errorMessage;

@property (nonatomic, strong, nullable) IBOutlet UILabel *errorMessageLabel;

@property (nonatomic, strong, nullable) IBOutlet UIImageView *errorImageView;

@property (nonatomic, strong, nullable) IBOutlet UITextField *equalContentTextField;

@property (nonatomic, readonly) BOOL isValid;

- (BOOL)checkIfIsValidAndUpdateValidationState;

+ (void)checkAllVisibleFieldsIfIsValidWithMatchedFields:(NSArray *__autoreleasing  _Nullable * _Nullable)matchedFields
                                          faildedFields:(NSArray *__autoreleasing  _Nullable * _Nullable)failedFields
                                           updateStates:(BOOL)updateStates;

+ (void)checkAllFieldsIfIsValidOnView:(nonnull UIView *)view
                  withMatchedFields:(NSArray *__autoreleasing  _Nullable * _Nullable)matchedFields
                      faildedFields:(NSArray *__autoreleasing  _Nullable * _Nullable)failedFields
                       updateStates:(BOOL)updateStates;

- (void)updateState:(BOOL)isValid;

@end
