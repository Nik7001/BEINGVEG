//
//  EditProfileVC.swift
//  BeingVegetarian
//
//  Created by Narendra Thakur on 14/07/19.
//  Copyright © 2019 Narendra thakur. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    @IBOutlet weak var pfImage: UIImageView!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
   
    var imagePicker = UIImagePickerController()
    var choosenImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        self.pfImage.layer.cornerRadius = self.pfImage.bounds.size.height / 2
        self.pfImage.clipsToBounds = true
        self.pfImage.layer.borderWidth = 1
        self.pfImage.layer.borderColor = UIColor.clear.cgColor
        self.pfImage.layer.masksToBounds = true
        let dict =  AppUserDefault.getUserDetails()
        print("dict111",dict)
        txtEmail.text = dict.GetString(forKey: "email")
        txtFirstName.text = dict.GetString(forKey: "first_name")
        txtLastName.text = dict.GetString(forKey: "last_name")
        txtPhone.text = dict.GetString(forKey: "mobile_no")
        let urlstring = dict.GetString(forKey: "picture")
        pfImage.sd_setImage(with: URL(string:urlstring), placeholderImage: UIImage(named: "user"))
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let image = UIImage(named: "logo")
        setTitle("   ", andImage: image!)
        
    }
    
    @IBAction func btnImage(_ sender: Any) {let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnSave(_ sender: Any) {
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let leftViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.homevc = nvc
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        UIApplication.shared.delegate?.window??.rootViewController = slideMenuController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            choosenImage = image
        } else if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            choosenImage = image
            
            
            
        }
        
        self.pfImage.image = choosenImage
        //let imgdata = UIImageJPEGRepresentation(choosenImage, 0.5)
        
        picker.dismiss(animated: true, completion: nil);
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    
}

