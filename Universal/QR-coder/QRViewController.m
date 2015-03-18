//
//  QRViewController.m
//  BeaconDemo
//
//  Created by CampRay-Jason on 15-3-10.
//  Change by Jason

#import "QRViewController.h"

@interface QRViewController (){
   
}

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupCamera];
}

- (void)viewDidAppear:(BOOL)animated{
       // _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(imgAnimotion) userInfo:nil repeats:YES];
    
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// core code
- (void)setupCamera
{
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    // 条码类型
    self.output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview QR windows
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    self.preview.frame =CGRectMake(0,0,self.QRView.frame.size.width,self.QRView.frame.size.height);
    [self.QRView.layer addSublayer:self.preview];
    
    // Start
    [self.session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // QR sesult string
    NSString *stringValue;
    
    if ([metadataObjects count] >0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    

    // QR result is JSON string
//    NSData *jsonData = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSDictionary *childDic;
//    if (jsonData) {
//        childDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
//        if (childDic == nil) {
//            NSLog(@"------------------json parse failed \r\n");
//            return;
//        }
//
//    }else{
//        assert(@"------------------QRcontent is nil");
//    }
    
    // present show mode
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)Cancle:(id)sender {
    // present show mode
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
