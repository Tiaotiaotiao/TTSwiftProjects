//
//  CameraViewController.swift
//  Scrollview
//
//  Created by Tiaotiao on 2020/2/24.
//  Copyright © 2020 Tiaotiao. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var cameraResultImgView: UIImageView!
    @IBOutlet weak var photographBtn: UIButton!
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    // MARK: - Lifecycle (deinit init viewDidLoad memoryWarning...)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewLayer?.frame = cameraView.bounds
    }
    
    func initSubView() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
       
        
        //        if #available(iOS 10.2, *) {
        //            let device1 = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInDualCamera, for: AVMediaType.video, position: AVCaptureDevice.Position.front)
        //        } else {
        //            // Fallback on earlier versions
        //        }
        
        guard let device = AVCaptureDevice.devices(for: .video).first else {
            return
        }

        var input: AVCaptureDeviceInput!
        var inputError: Error?
        
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch let error as NSError {
            inputError = error
        }
        
        // 判断下input
        guard inputError == nil && captureSession?.canAddInput(input) != nil else {
            return
        }
        
        captureSession?.addInput(input)
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        // 判断下stillImageOutput
        guard let stillImageOutputReal = stillImageOutput else {
            return
        }
        
        guard captureSession?.canAddOutput(stillImageOutputReal) == true else {
            return
        }
        
        captureSession?.addOutput(stillImageOutputReal)
        
        // 判断下captureSession
        guard let captureSessionReal = captureSession  else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSessionReal)
        previewLayer?.videoGravity = .resizeAspect
        previewLayer?.connection?.videoOrientation = .portrait
        
        cameraView.layer.addSublayer(previewLayer!)
        captureSession?.startRunning()
        
        cameraResultImgView.isHidden = true;
    }
    
    // MARK: - Public

    // MARK: - Event Respone
        
    @IBAction func photographBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            takePhotoAction()
        } else {
            captureSession?.startRunning()
            cameraResultImgView.isHidden = true
        }
    }
    
    // MARK: - Delegate
    
    // MARK: - Private
    
    func takePhotoAction() {
        
        // 先判断下能不能连接
        guard let outputConnection = stillImageOutput?.connection(with: AVMediaType.video) else {
            return
        }
        
        stillImageOutput?.captureStillImageAsynchronously(from: outputConnection, completionHandler: { (sampleBuffer, error) in 
        
            guard let sampleBufferReal = sampleBuffer else {
                return
            }

            let cfData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBufferReal)
            guard let cgDataProvider: CGDataProvider = CGDataProvider(data: cfData! as CFData) else {
                return
            }
            
            guard let cgImg: CGImage = CGImage(jpegDataProviderSource: cgDataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) else {
                return
            }

            self.cameraResultImgView.image = UIImage.init(cgImage: cgImg, scale: 1.0, orientation: UIImage.Orientation.right)
            self.cameraResultImgView.isHidden = false
            self.captureSession?.stopRunning()
        })
    }
    
    // MARK: - Lazy

    // MARK: - Supperclass
    
    // MARK: - NSObject

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
