import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    var onDelete: (() -> Void)?

    private var chipView: ChipsView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        chipView = ChipsView(model: ChipsModel(name: ""))
        chipView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chipView)

        NSLayoutConstraint.activate([
            chipView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chipView.topAnchor.constraint(equalTo: topAnchor),
            chipView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chipView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with model: ChipsModel) {
        chipView.update(with: model)
        chipView.onDelete = { [weak self] in
            self?.onDelete?()
        }
    }
}
