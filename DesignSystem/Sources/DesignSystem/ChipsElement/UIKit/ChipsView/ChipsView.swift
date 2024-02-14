import UIKit

class ChipsView: UIView {
    private var iconImageView: UIImageView?
    private var deleteButton: UIButton?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = .blue
        return label
    }()
    
    var primaryColor: UIColor
    var secondaryColor: UIColor
    
    var onDelete: (() -> Void)?
    
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    init(model: ChipsModel) {
        self.primaryColor = model.primaryColor
        self.secondaryColor = model.secondaryColor
        
        self.iconImageView = model.icon != nil ? UIImageView(image: UIImage(systemName: model.icon!)) : nil
        self.deleteButton = model.isDeletable ? UIButton(type: .custom) : nil
                
        super.init(frame: .zero)
        setupUI()
        label.text = model.name
        
        if let deleteButton = deleteButton {
            deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            deleteButton.tintColor = .gray
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            deleteButton.isUserInteractionEnabled = true
        }
        
        if !model.isUnselectable {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chipTapped))
            addGestureRecognizer(tapGesture)
        }
        
        updateAppearance()
    }
    
    init(isSelected: Bool = false, name: String, isDeletable: Bool = false, isUnselectable: Bool = false, icon: UIImage? = nil, primaryColor: UIColor = .systemBlue, secondaryColor: UIColor = .white) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.iconImageView = icon != nil ? UIImageView(image: icon) : nil
        self.deleteButton = isDeletable ? UIButton(type: .custom) : nil
        
        super.init(frame: .zero)
        setupUI()
        label.text = name
        
        if let deleteButton = deleteButton {
            deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            deleteButton.tintColor = .gray
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            deleteButton.isUserInteractionEnabled = true
        }
        
        if !isUnselectable {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chipTapped))
            addGestureRecognizer(tapGesture)
        }
        
        updateAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        removeConstraints(constraints)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var labelConstraints = [
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ]
        
        if let iconImageView = iconImageView {
            addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            labelConstraints.append(contentsOf: [
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconImageView.widthAnchor.constraint(equalToConstant: 20),
                iconImageView.heightAnchor.constraint(equalToConstant: 20),
                label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4)
            ])
        } else {
            labelConstraints.append(label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8))
        }
        
        if let deleteButton = deleteButton {
            addSubview(deleteButton)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            deleteButton.isUserInteractionEnabled = true
            labelConstraints.append(contentsOf: [
                deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
                deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                deleteButton.widthAnchor.constraint(equalToConstant: 20),
                deleteButton.heightAnchor.constraint(equalToConstant: 20),
                label.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8)
            ])
        } else {
            labelConstraints.append(label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8))
        }
        labelConstraints.append(label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8))
        NSLayoutConstraint.activate(labelConstraints)
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = primaryColor.cgColor
    }

    
    private func updateAppearance() {
        if isSelected {
            backgroundColor = primaryColor
            label.textColor = secondaryColor
            layer.borderColor = primaryColor.cgColor
            iconImageView?.tintColor = secondaryColor
        } else {
            backgroundColor = secondaryColor
            label.textColor = primaryColor
            layer.borderColor = primaryColor.cgColor
            iconImageView?.tintColor = primaryColor
        }
    }
    
    @objc private func deleteButtonTapped() {
        onDelete?()
    }
    
    @objc private func chipTapped() {
        isSelected = !isSelected
    }
    
    func update(with model: ChipsModel) {
        self.primaryColor = model.primaryColor
        self.secondaryColor = model.secondaryColor

        label.text = model.name

        if let iconName = model.icon {
            if iconImageView == nil {
                self.iconImageView = UIImageView(image: UIImage(systemName: iconName))
                addSubview(iconImageView!) // Add icon image view to the view hierarchy
            } else {
                iconImageView?.image = UIImage(systemName: iconName)
            }
        } else {
            iconImageView?.removeFromSuperview()
            self.iconImageView = nil
        }

        if model.isDeletable {
            if deleteButton == nil {
                self.deleteButton = UIButton(type: .custom)
                deleteButton?.isUserInteractionEnabled = true
                deleteButton?.setImage(UIImage(systemName: "xmark"), for: .normal)
                deleteButton?.tintColor = .gray
                deleteButton?.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
                addSubview(deleteButton!)
            } else {
                deleteButton?.isHidden = false
            }
        } else {
            deleteButton?.removeFromSuperview()
            self.deleteButton = nil
        }

        if model.isSelected {
            self.isSelected = true
        } else {
            self.isSelected = false
        }

        if model.isUnselectable {
            if let tapGesture = gestureRecognizers?.first(where: { $0 is UITapGestureRecognizer }) {
                removeGestureRecognizer(tapGesture)
            }
        } else {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chipTapped))
            addGestureRecognizer(tapGesture)
        }

        setupUI()
        updateAppearance()
    }
}


