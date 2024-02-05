//
//  File.swift
//
//
//  Created by Илья on 01.02.2024.
//

import UIKit

@available(iOS 13.0, *)
class ImageCarouselView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let cellIdentifier = "CarouselCell"
    private var currentIndex = 0
    private var style: HSEStyle
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    private let buttonsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var photoArray: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    init(images: [UIImage], style: HSEStyle) {
        self.style = style
        super.init(frame: .zero)
        self.photoArray = images
        setupCollectionView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        self.style = HSEStyle(tintColor: "#000000")
        super.init(coder: coder)
        setupCollectionView()
        setupButtons()
    }
    
    private func setupButtons() {
        leftButton.addForButton(style: style)
        rightButton.addForButton(style: style)
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        addSubview(leftButton)
        addSubview(rightButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -15),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            rightButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -15),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(withImages images: [UIImage]) {
        photoArray = images
    }
    
    // Обработчик нажатия кнопки "Влево"
    @objc private func leftButtonTapped() {
        let newIndex = max(currentIndex - 1, 0)
        collectionView.scrollToItem(at: IndexPath(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
        selectCard(at: newIndex, animated: true)
    }
    
    // Обработчик нажатия кнопки "Вправо"
    @objc private func rightButtonTapped() {
        let newIndex = min(currentIndex + 1, collectionView.numberOfItems(inSection: 0) - 1)
        collectionView.scrollToItem(at: IndexPath(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
        selectCard(at: newIndex, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Unable to dequeue MyCollectionViewCell")
        }
        cell.setup(image: photoArray[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let cellWidth = min(screenWidth / 3, 110.0)
        
        let selectedCardSize = CGSize(width: cellWidth, height: 160)
        let unselectedCardSize = CGSize(width: cellWidth, height: 100)
        
        return indexPath.item == currentIndex ? selectedCardSize : unselectedCardSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCard(at: indexPath.item, animated: true)
    }
    
    private func selectCard(at index: Int, animated: Bool) {
        currentIndex = index
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.collectionView.collectionViewLayout.invalidateLayout()
            }
        } else {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}


// Пример использования оставоляю в комментариях.
// Для внедрения ImageCarouselView в свой UIViewController
// необходимо правильно и аккуратно настроить констрейнты.


//class ViewController: UIViewController {
//
//    private let imageCarouselView = ImageCarouselView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .orange
//
//        imageCarouselView.configure(withImages: [UIImage(named: "dog1")!, UIImage(named: "dog2")!, UIImage(named: "dog3")!, UIImage(named: "dog4")!, UIImage(named: "dog5")!, UIImage(named: "dog6")!, UIImage(named: "dog7")!])
//               view.addSubview(imageCarouselView)
//
//               // Добавьте ограничения (constraints) или используйте Auto Layout в зависимости от вашей разметки
//               imageCarouselView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageCarouselView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            imageCarouselView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            imageCarouselView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            imageCarouselView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//    }
//
//}
