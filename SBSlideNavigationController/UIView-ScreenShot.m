//
//  Created by marco on 25/05/13.
//  Edited by Alberto on 17/07/2013.
//
//
//


#import "UIView+ScreenShot.h"
#import "QuartzCore/QuartzCore.h"


@implementation UIView (ScreenShot)

CGImageRef UIGetScreenImage(void);

+ (UIImage *)screenShotForView:(UIView *)view
{
  return [view screenShot];
}

- (UIImage *)screenShot {
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height,
          navBarHeight = self.firstAvailableUIViewController.navigationController.navigationBar.frame.size.height,
          sum = statusBarHeight+navBarHeight;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        // Retina display
        sum *= 2;
    } 
    
    CGImageRef screen = UIGetScreenImage();
    UIImage *image = [UIImage imageWithCGImage:screen];
    CGImageRelease(screen);
    
    CGRect rect = CGRectMake(0, sum, image.size.width, image.size.height-sum);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;  
}

@end
