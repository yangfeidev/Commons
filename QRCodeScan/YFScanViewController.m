//
//  YFScanViewController.m
//
//  Created by YangFei on 2017/11/9.
//  Copyright © 2017年 JBL. All rights reserved.
//

#import "YFScanViewController.h"
#import <AVFoundation/AVFoundation.h>


#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds

#define ScanRectW 250

#define ScanRectX   (SCREEN_WIDTH-ScanRectW)/2
#define ScanRectY   (SCREEN_HEIGHT-ScanRectW)/2

#define kScanRect CGRectMake(ScanRectX, ScanRectY, ScanRectW, ScanRectW)

@interface YFScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    int offsetY;
    NSTimer *timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic) AVCaptureDevice *device;
@property (strong,nonatomic) AVCaptureDeviceInput *input;
@property (strong,nonatomic) AVCaptureMetadataOutput *output;
@property (strong,nonatomic) AVCaptureSession *session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (nonatomic, strong) UIImageView *scanLine;

@end

@implementation YFScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setCropRect:kScanRect];
    [self setupCamera];
}

- (void)configUI {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"scanBg"];
    [self.view addSubview:imageView];
    
    offsetY = 0;
    _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(ScanRectX, ScanRectY, ScanRectW, 2)];
    _scanLine.image = [UIImage imageNamed:@"scanLine"];
    [self.view addSubview:_scanLine];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];
    
}


- (void)scanAnimation {

    offsetY += 2;
    if (offsetY >= ScanRectY) {
        offsetY = 0;
    }
    _scanLine.frame = CGRectMake(ScanRectX, ScanRectY+offsetY, ScanRectW, 2);
}


- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);

    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    [cropLayer setNeedsDisplay];
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera {
  
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat left = ScanRectX/SCREEN_WIDTH;
    CGFloat top = ScanRectY/SCREEN_HEIGHT;
    CGFloat width = ScanRectW/SCREEN_WIDTH;
    CGFloat height = ScanRectW/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    // Session
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetHigh;
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if (metadataObjects.count) {
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        stringValue = metadataObject.stringValue;
        //TODO: 处理得到扫描后的字符串 stringValue
        
        
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

@end
