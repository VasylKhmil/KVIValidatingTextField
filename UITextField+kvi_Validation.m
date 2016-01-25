//
//  UITextField+kvi_Validation.m
//  TenInstitute
//
//  Created by Vasyl Khmil on 11/13/15.
//  Copyright © 2015 com.n-ix. All rights reserved.
//

#import "UITextField+kvi_Validation.h"
#import <objc/runtime.h>

@implementation UITextField (kvi_Validation)
@dynamic validationRegex, minimalNumberOfCharacters, maximalNumberOfCharacters, isValid, invalidStateColor, validStateColor;

#pragma mark - Properties(Assotiation)

- (void)setInvalidStateColor:(nullable UIColor *)invalidStateColor {
    objc_setAssociatedObject(self, @selector(invalidStateColor), invalidStateColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)invalidStateColor {
    return objc_getAssociatedObject(self, @selector(invalidStateColor));
}

- (void)setValidStateColor:(nullable UIColor *)invalidStateColor {
    objc_setAssociatedObject(self, @selector(validStateColor), invalidStateColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)validStateColor {
    return objc_getAssociatedObject(self, @selector(validStateColor));
}

- (void)setMinimalNumberOfCharacters:(NSUInteger)minimalNumberOfCharacters {
    objc_setAssociatedObject(self, @selector(minimalNumberOfCharacters), @(minimalNumberOfCharacters), OBJC_ASSOCIATION_RETAIN);
}

- (NSUInteger)minimalNumberOfCharacters {
    NSNumber *minimalNumber = objc_getAssociatedObject(self, @selector(minimalNumberOfCharacters));
    return minimalNumber.integerValue;
}

- (void)setMaximalNumberOfCharacters:(NSUInteger)maximalNumberOfCharacters {
    objc_setAssociatedObject(self, @selector(maximalNumberOfCharacters), @(maximalNumberOfCharacters), OBJC_ASSOCIATION_RETAIN);
}

- (NSUInteger)maximalNumberOfCharacters {
    NSNumber *maximalNumber = (NSNumber *)objc_getAssociatedObject(self, @selector(maximalNumberOfCharacters));
    return maximalNumber == nil ? INT_MAX : maximalNumber.integerValue;
}

- (void)setValidationRegex:(nullable NSString *)validationRegex {
    objc_setAssociatedObject(self, @selector(validationRegex), validationRegex, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)validationRegex {
    return objc_getAssociatedObject(self, @selector(validationRegex));
}

#pragma mark - Properties(Validation)

- (BOOL)isValid {
    
    return self.matchRegex &&
        (self.text.length <= self.maximalNumberOfCharacters) &&
        (self.text.length >= self.minimalNumberOfCharacters);
}

- (BOOL)matchRegex {
    
    if (self.validationRegex != nil) {
        NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.validationRegex];
        return [regexPredicate evaluateWithObject:self.text];
    }
    
    return TRUE;
}

#pragma mark - Public 

- (BOOL)checkIfIsValidAndUpdateValidationState {
    BOOL isValid = self.isValid;
    
    [self updateState:isValid];
    
    return isValid;
}

+ (void)checkAllVisibleFieldsIfIsValidWithMatchedFields:(NSArray *__autoreleasing  _Nullable *)matchedFields
                                          faildedFields:(NSArray *__autoreleasing  _Nullable *)failedFields
                                           updateStates:(BOOL)updateStates {
    
    UIView *rootView = [UIApplication sharedApplication].delegate.window;

    [self checkAllFieldsIfIsValidOnView:rootView
                    withMatchedFields:matchedFields
                        faildedFields:failedFields
                         updateStates:updateStates];
    
}

+ (void)checkAllFieldsIfIsValidOnView:(UIView *)view
                  withMatchedFields:(NSArray *__autoreleasing  _Nullable *)matchedFields
                      faildedFields:(NSArray *__autoreleasing  _Nullable *)failedFields
                       updateStates:(BOOL)updateStates {
    
    NSMutableArray *matched = [NSMutableArray new];
    NSMutableArray *failed = [NSMutableArray new];
    
    [self enumerateAllTextFieldFromView:view
                            withHandler:^(UITextField *textField) {
                                if (!textField.hidden) {
                                    BOOL isValid = textField.isValid;
                                    
                                    if (isValid) {
                                        [matched addObject:textField];
                                        
                                    } else {
                                        [failed addObject:textField];
                                    }
                                    
                                    if (updateStates) {
                                        [textField updateState:isValid];
                                    }
                                }
                            }];
    
    if (matchedFields != nil) {
        *matchedFields = [[NSArray alloc] initWithArray:matched];
    }
    
    if (failedFields != nil) {
        *failedFields = [[NSArray alloc] initWithArray:failed];
    }
}

#pragma mark - Private

+ (void)enumerateAllTextFieldFromView:(UIView *)startView withHandler:(void (^)(UITextField *textField))handler {
    for (UIView *subview in startView.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            handler((UITextField *)subview);
            
        } else {
            [self enumerateAllTextFieldFromView:subview
                                    withHandler:handler];
        }
    }
}

- (void)updateState:(BOOL)isValid {
    UIColor *validColor = self.validStateColor;
    UIColor *invalidColor = self.invalidStateColor;
    
    validColor = (validColor == nil) ? [UIColor clearColor] : validColor;
    invalidColor = (invalidColor == nil) ? [UIColor redColor] : invalidColor;
    
    self.layer.borderWidth = isValid ? 0 : 2;
    self.layer.borderColor = isValid ? validColor.CGColor : invalidColor.CGColor;
}

@end
