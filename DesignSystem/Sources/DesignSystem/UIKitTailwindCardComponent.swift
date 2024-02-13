//
//  UIKitTailwindCardComponent.swift
//
//
//  Created by Карим Хамид on 05.02.2024.
//
//
//  UIKitTailwindCardComponent.swift
//
//
//  Created by Карим Хамид on 05.02.2024.
//

import UIKit

enum LayoutConstants {
    static let imageViewHeight: CGFloat = 150
    static let topPadding: CGFloat = 16
    static let leadingPadding: CGFloat = 16
    static let trailingPadding: CGFloat = -16
    static let titleLabelTopPadding: CGFloat = 16
    static let mainTextLabelTopPadding: CGFloat = 4
    static let footerTextLabelTopPadding: CGFloat = 24
    static let checkmarkImageViewSize: CGFloat = 24
}


@available(iOS 13, *)
class UIKitCardView: UIView {
    var title: String
    var mainText: String
    var footerText: String
    var imageBackgroundColor: UIColor

    private var isSelected: Bool = false {
        didSet {
            updateSelectionState()
        }
    }

    private let imageView = UIView()
    private let titleLabel = UILabel()
    private let mainTextLabel = UILabel()
    private let footerTextLabel = UILabel()
    private let checkmarkImageView = UIImageView()

    init(title: String, mainText: String, footerText: String, imageBackgroundColor: UIColor) {
        self.title = title
        self.mainText = mainText
        self.footerText = footerText
        self.imageBackgroundColor = imageBackgroundColor
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        addGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer
    }
    
    private func setupCardContent() {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        mainTextLabel.text = mainText
        mainTextLabel.font = UIFont.systemFont(ofSize: 16)
        mainTextLabel.numberOfLines = 0
        footerTextLabel.text = footerText
        footerTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .blue
        checkmarkImageView.isHidden = true
    }
    
    private func setupCard() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private func setupViews() {
        imageView.backgroundColor = imageBackgroundColor

        let path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer

        setupCard()

        setupCardContent()

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(mainTextLabel)
        addSubview(footerTextLabel)
        addSubview(checkmarkImageView)
    }


    private func setupLayout() {
        for element in [imageView, titleLabel, mainTextLabel, footerTextLabel, checkmarkImageView]{
             element.translatesAutoresizingMaskIntoConstraints = false
         }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            mainTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            mainTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            footerTextLabel.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: 24),
            footerTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            footerTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            footerTextLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16),

            checkmarkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            checkmarkImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSelection))
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func toggleSelection() {
        isSelected.toggle()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    private func updateSelectionState() {
        checkmarkImageView.isHidden = !isSelected
        self.layer.borderWidth = isSelected ? 4 : 0
        self.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.clear.cgColor
    }
}
