//
//  ViewController.swift
//  imagePicker
//
//  Created by Печик Ирина on 01.02.2024.
//

import UIKit

class AvatarController: UIViewController {
    let avatarView = AvatarView()
    let imagePickerManager = ImagePickerManager()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    private func configureUI() {
        view.addSubview(avatarView)
        avatarView.pinHorizontal(to: view)
        avatarView.pinTop(to: view.topAnchor)
        avatarView.pinBottom(to: view.bottomAnchor)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        avatarView.avatarImage.isUserInteractionEnabled = true
        avatarView.avatarImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /// Pick image from gallery or camera.
    @objc
    private func pickImage() {
        imagePickerManager.pickImage(viewController: self) {
            image in self.avatarView.avatarImage.image = image
        } deleteComplition: {
            image in self.avatarView.avatarImage.image = image
        }
    }
}


