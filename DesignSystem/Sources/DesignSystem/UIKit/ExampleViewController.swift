//
//  ViewController.swift
//  chipscomponentuikit
//
//  Created by Nikita Shubin on 02.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var chipContainerViewController: ChipContainerViewController = {
        let viewModel = ChipsViewModel(chipsArray: [
            ChipsModel(name: "Unselectable deletable button", isDeletable: true, isUnselectable: true),
            ChipsModel(name: "deletable", isDeletable: true),
            ChipsModel(isSelected: true, name: "Unselectable selected", isUnselectable: true),
            ChipsModel(name: "Item With Different Colors", primaryColor: .systemGreen, secondaryColor: .systemGray3),
            ChipsModel(name: "s"),
            ChipsModel(name: "Item icon", icon: "star"),
            ChipsModel(name: "Deletable chip icon", isDeletable: true, icon: "heart.fill"),
        ])
        let viewController = ChipContainerViewController()
        viewController.viewModel = viewModel
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        
        addChild(chipContainerViewController)
        chipContainerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chipContainerViewController.view)
        NSLayoutConstraint.activate([
            chipContainerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chipContainerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chipContainerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chipContainerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        chipContainerViewController.didMove(toParent: self)
    }
}

