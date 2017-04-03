//
//  BookViewController.swift
//  BooksLibrary
//
//  Created by Richard on 4/2/17.
//  Copyright © 2017 ELION. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var volume : Books? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if volume != nil {
            bookImageView.image = UIImage(data: volume!.cover as! Data)
            titleTextField.text = volume!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        bookImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if volume != nil {
            
            volume!.title = titleTextField.text
            volume!.cover = UIImagePNGRepresentation(bookImageView.image!) as NSData!
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let book = Books(context: context)
            book.title = titleTextField.text
            book.cover = UIImagePNGRepresentation(bookImageView.image!) as NSData!
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(volume!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    
}
