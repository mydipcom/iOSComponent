//
//  QRViewController.h
//  BeaconDemo
//
//  Created by CampRay-Jason on 15-3-10.
//  Change by Jason
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>




@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;

// QRView
@property (weak, nonatomic) IBOutlet UIView *QRView;

// back foo
- (IBAction)Cancle:(id)sender;

@end
