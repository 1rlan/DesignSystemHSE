//
//  InformationInputView.swift
//  imagePicker
//
//  Created by Печик Ирина on 01.02.2024.
//

import UIKit

class AvatarView: UIView, UITextFieldDelegate {
    private struct Constants {
        // Constants for avatar image.
        static let avatarRadius: CGFloat = 120
        static let avatarSize: CGFloat = 240
    }
    // MARK: - Fields
    let avatarImage = UIImageView()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureAvatar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Объявляем аватарку.
    private func configureAvatar() {
        self.addSubview(avatarImage)
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = Constants.avatarRadius
        avatarImage.backgroundColor = .gray
        
        avatarImage.setHeight(Constants.avatarSize)
        avatarImage.setWidth(Constants.avatarSize)
        avatarImage.pinTop(to: self.safeAreaLayoutGuide.topAnchor)
        avatarImage.pinCenterX(to: self)
        avatarImage.image = UIImage(named: "avatar")
    }
}

