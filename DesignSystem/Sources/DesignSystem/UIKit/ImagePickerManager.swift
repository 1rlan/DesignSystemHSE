//
//  ImagePickerManager.swift
//  imagePicker
//
//  Created by Печик Ирина on 01.02.2024.
//

import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var viewController: UIViewController?
    var picker = UIImagePickerController()
    var complition: ((UIImage) -> ())?
    var deleteComplition: ((UIImage) -> ())?
    var alert = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
    
    override init() {
        super.init()
        let cameraAction = UIAlertAction(title: "Камера", style: .default) {
            UIAlertAction in
            self.openCamera()
        }
        let galleryActioon = UIAlertAction(title: "Галлерея", style: .default) {
            UIAlertAction in
             self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {
            UIAlertAction in
            self.deleteImage()
        }
        picker.allowsEditing = true
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryActioon)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
    }
    
    func pickImage(viewController: UIViewController, complition: ((UIImage) -> ())?,
                   deleteComplition: ((UIImage) -> ())?) {
        self.complition = complition
        self.deleteComplition = deleteComplition
        self.viewController = viewController
        viewController.present(alert, animated: true)
    }
    
    func openGallery() {
        alert.dismiss(animated: true)
        picker.sourceType = .photoLibrary
        viewController!.present(picker, animated: true)
    }
    
    func openCamera() {
        alert.dismiss(animated: true)
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            viewController!.present(picker, animated: true)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Внимание", message: "Камера недоступна", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    
    func deleteImage() {
        self.deleteComplition?(UIImage(named: "avatar")!)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.complition?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

