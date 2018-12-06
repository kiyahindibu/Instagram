//
//  Post.swift
//  Instagram
//
//  Created by Trustin Harris on 3/9/18.
//  Copyright © 2018 Trustin Harris. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
      
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground { (success: Bool, error: Error?) in
            completion!(success, error)
        }
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
