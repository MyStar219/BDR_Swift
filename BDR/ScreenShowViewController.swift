//
//  ScreenShowViewController.swift
//  BDR
//
//  Created by Mobile Developer on 9/23/17.
//  Copyright © 2017 Mobile Developer. All rights reserved.
//

import UIKit

class ScreenShowViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var Show_Image: UIImageView!
    var photo: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Show_Image.image=photo
        self.BackButton.isHidden = true
    
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ScreenShowViewController.someAction(_:)))
        self.view.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    func someAction(_ sender:UITapGestureRecognizer){

        // do other task
        if BackButton.isHidden == true {
            self.BackButton.isHidden = false
        } else {
            self.BackButton.isHidden = true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
