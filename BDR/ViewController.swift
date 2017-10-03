//
//  ViewController.swift
//  BDR
//
//  Created by Mobile Developer on 9/23/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var screenphoto: UIImage?
//    var cameraImage: UIImageView!
    @IBOutlet weak var ScreenShotButton: UIButton!
    @IBOutlet weak var CameraButton: UIButton!
    @IBOutlet weak var ScreenshotStatus: UISwitch!
    @IBOutlet weak var CameraStatus: UISwitch!
    
    var cameraView : UIView! = nil
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var background_task: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var m_bStartTimer: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        startBackgroundTask()
        ScreenshotStatus.isOn = false
        CameraStatus.isOn = false
        ScreenShotButton.isHidden = true
        CameraButton.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ScreenshotButtonClicked(_ sender: UIButton) {
        GetScreenshot()
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "ScreenShowViewController") as! ScreenShowViewController
        viewController.photo = screenphoto
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func CameraPhotoButtonClicked(_ sender: UIButton) {
        GetCameraPhoto()
    }
    @IBAction func ScreenshotSwitch(_ sender: UISwitch) {
        if ScreenshotStatus.isOn == true {
            ScreenShotButton.isHidden = false
        } else {
            ScreenShotButton.isHidden = true
        }
    }
    
    @IBAction func CameraSwitch(_ sender: UISwitch) {
        if CameraStatus.isOn == true {
            CameraButton.isHidden = false
        } else {
            CameraButton.isHidden = true
        }
    }
    
    func startBackgroundTask() {
        let application : UIApplication = UIApplication.shared
        background_task = application.beginBackgroundTask(expirationHandler: {
            application.endBackgroundTask(self.background_task)
        })
        
        DispatchQueue.global(qos: .background).async {
            
            //            self.m_bStartTimer = true;
            while (true) {
                print("Running in the background!")
                self.backgroundThread()
                Thread.sleep(forTimeInterval: 1.0)
            }
        }
    }
    
    func backgroundThread() {
        if ScreenshotStatus.isOn == true {
            ScreenShotButton.isHidden = false
        } else {
            ScreenShotButton.isHidden = true
        }
        if CameraStatus.isOn == true {
            CameraButton.isHidden = false
        } else {
            CameraButton.isHidden = true
        }
    }
    
    func GetScreenshot() {
        ScreenShotButton.isHidden = true
        CameraButton.isHidden = true
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        screenphoto = image
        //Save it to the camera roll
        //UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        print("Success")
        if ScreenshotStatus.isOn == true {
            ScreenShotButton.isHidden = false
        } else {
            ScreenShotButton.isHidden = true
        }
        if CameraStatus.isOn == true {
            CameraButton.isHidden = false
        } else {
            CameraButton.isHidden = true
        }
    }
    
    func GetCameraPhoto() {
        ScreenShotButton.isHidden = true
        CameraButton.isHidden = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        if ScreenshotStatus.isOn == true {
            ScreenShotButton.isHidden = false
        } else {
            ScreenShotButton.isHidden = true
        }
        if CameraStatus.isOn == true {
            CameraButton.isHidden = false
        } else {
            CameraButton.isHidden = true
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "ScreenShowViewController") as! ScreenShowViewController
            viewController.photo = pickedImage
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        picker.dismiss(animated: true, completion: nil)

    }
}
