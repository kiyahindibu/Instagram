//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Trustin Harris on 2/25/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var vc = UIImagePickerController()
    
    @IBOutlet weak var PostedPic: UIImageView!
    @IBOutlet weak var PicCaption: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        
        
        self.present(vc, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        // Do something with the images (based on your use case)
        // Dismiss UIImagePickerController to go back to your original view controller
        PostedPic.image = editedImage
        
        
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func UploadButton(_ sender: Any) {
        
        if self.PicCaption.text == nil {
            PicCaption.text = " "
        }
        
        Post.postUserImage(image: PostedPic.image, withCaption: PicCaption?.text) { (success: Bool, error: Error?) in
            self.PicCaption.text = nil
            self.PostedPic.image = nil
        }
        
    }
    
    
    
    
    
    
}






