//
//  UIImage+Tools.m
//  FSUtils
//
//  Created by Jan Lubeck on 13/03/2018.
//  Copyright © 2018 Fyrastudio. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)
-(UIImage*)resize{
	int kMinUploadResolution = 1136 * 640;
	
	//Resize the image
	float factor;
	float resol = self.size.height*self.size.width;
	if (resol > kMinUploadResolution){
		factor = sqrt(resol/kMinUploadResolution)*2;
		return [self scaleDownWithSize:CGSizeMake(self.size.width/factor, self.size.height/factor)];
	}
	
	return self;
}

-(NSString*)toBase64{
	UIImage *img = [self resize];
	
	//Compress the image
	int kMaxUploadSize = 50000; //50KB
	CGFloat compression = 0.9f;
	CGFloat maxCompression = 0.1f;
	
	NSString *base64 = [UIImageJPEGRepresentation(img, compression) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
	
	while ([base64 length] > kMaxUploadSize && compression > maxCompression)
	{
		compression -= 0.25;
		base64 = [UIImageJPEGRepresentation(img, compression) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
	}
	
	return base64;
}

-(UIImage*)scaleDownWithSize:(CGSize)newSize{
	UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
	[self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}

@end
