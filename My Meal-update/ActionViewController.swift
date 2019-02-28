//
//  ActionViewController.swift
//  My Meal
//
//  Created by 肖梦真 on 2/20/19.
//  Copyright © 2019 mengzhenxiao. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var selectedImageName: String?
    @IBOutlet weak var imageNameInput: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    // Callback method to be defined in parent view controller.
    var didSaveElement: ((_ element: Element) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func imagelibrary(_ sender: UIButton) {
        // Create and present image picker using photo library.
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate   = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    
    @IBAction func handleSaveButton(_ sender: UIButton) {
        // Get current time and date.
    
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        // get the date time String from the date object
        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
        
        let dateString = formatter.string(from: currentDateTime)
        
        let element = Element(imageName: self.selectedImageName ?? "default-image", date: dateString)
        didSaveElement?(element)
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getCameraButton(_ sender: UIButton) {
        // Create and present image picker using photo library.
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate   = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.selectedImageView.image = selectedImage
        
        
        // save image to FileManager
        // use hashValue of selectedImage as imageName
        saveImage(image: selectedImage, imageName: String(selectedImage.hashValue))
        
        // Dismiss image picker after making selection.
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage, imageName: String) {
        // create an instance of the FileManager
        let fileManager = FileManager.default
        
        // get the file system image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        
        // get the jpeg data of this image
        let data = image.jpegData(compressionQuality: 0.8)
        
        // Save the image name.
        selectedImageName = imageName
        
        // store the image in document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    


}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
