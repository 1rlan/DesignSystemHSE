import UIKit

class ChipContainerViewController: UIViewController {
    var viewModel = ChipsViewModel()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: "ChipCell")
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        setupChips()
    }

    private func setupChips() {
        collectionView.reloadData()
    }
}

extension ChipContainerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.chipsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipCell", for: indexPath) as! ChipCollectionViewCell
        cell.configure(with: viewModel.chipsArray[indexPath.item])
        cell.onDelete = { [weak self] in
            self?.viewModel.removeChip(withId: self?.viewModel.chipsArray[indexPath.item].id ?? UUID())
            self?.setupChips()
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chipModel = viewModel.chipsArray[indexPath.item]
        let chipView = ChipsView(model: chipModel)
        
        // Set up a temporary superview
        let superview = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
        superview.addSubview(chipView)
        
        // Layout the chip view within the superview
        chipView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chipView.topAnchor.constraint(equalTo: superview.topAnchor),
            chipView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            chipView.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
        
        // Force layout to calculate the size
        superview.layoutIfNeeded()
        
        // Get the size of the chip view
        var size = chipView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        chipView.removeFromSuperview()
        
        return size
    }

}
