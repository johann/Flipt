//
//  Barcode.h
//  featurebuild
//
//  Created by Jake Widmer on 10/5/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import AVFoundation;

@interface Barcode : NSObject

+ (Barcode * )processMetadataObject:(AVMetadataMachineReadableCodeObject*) code;
- (NSString *) getBarcodeType;
- (NSString *) getBarcodeData;
- (void) printBarcodeData;
@end
