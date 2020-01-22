//
//  UIImage+WebP.h
//  SDWebImage
//  TransitSTLApp
//
//  Created by Nitin Saklecha on 29/06/18.
//  Copyright © 2018 ArnaSoftech Pvt.Ltd. All rights reserved.

#ifdef SD_WEBP

#import <UIKit/UIKit.h>

// Fix for issue #416 Undefined symbols for architecture armv7 since WebP introduction when deploying to device
void WebPInitPremultiplyNEON(void);

void WebPInitUpsamplersNEON(void);

void VP8DspInitNEON(void);

@interface UIImage (WebP)

+ (UIImage *)sd_imageWithWebPData:(NSData *)data;

@end

#endif
