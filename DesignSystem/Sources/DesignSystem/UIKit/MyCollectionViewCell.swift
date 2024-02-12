//
//  File.swift
//
//
//  Created by Илья on 05.02.2024.
//

import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    func setup(image: UIImage) {
        imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    private func setupImageView() {
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        // Добавление UIImageView к ячейке
        contentView.addSubview(imageView)
        
        // Настройка layout constraints (положение и размер) для UIImageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

