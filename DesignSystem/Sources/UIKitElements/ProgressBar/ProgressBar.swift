//
//  ProgressBar.swift
//
//  Created by Irlan Abushakhmanov on 03.02.2024.
//

import UIKit
import DesignSystem

final public class ProgressBar: UIView {
    // MARK: Private Properties

    private let style: HSEStyle
    private var progress: CGFloat = 0

    private lazy var ringLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = .round
        layer.strokeColor = style.rawForegroungColor?.cgColor
        return layer
    }()

    private lazy var barLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = .round
        layer.strokeColor = style.rawBackgroungColor?.cgColor
        return layer
    }()

    // MARK: - Initialization

    public init(style: HSEStyle) {
        self.style = style
        super.init(frame: .zero)
        layoutViews()
        setProgress(value: progress)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        configureBar()
    }

    // MARK: - Public methods

    public func setProgress(value: CGFloat) {
        let oldProgress = ringLayer.presentation()?.strokeEnd ?? progress

        progress = max(min(value, 1), 0)
        print(progress)
        ringLayer.strokeEnd = progress
        makeAnimation(oldProgress: oldProgress)
    }

    // MARK: - Private methods

    private func makeAnimation(oldProgress: CGFloat) {
        CATransaction.begin()
        let path = #keyPath(CAShapeLayer.strokeEnd)
        let fill = CABasicAnimation(keyPath: path)
        fill.fromValue = oldProgress
        fill.toValue = progress
        fill.duration = 2.0
        fill.timingFunction = CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
        ringLayer.add(fill, forKey: "fill")
        CATransaction.commit()
    }

    private func layoutViews() {
        preservesSuperviewLayoutMargins = true
        layer.addSublayer(barLayer)
        layer.addSublayer(ringLayer)
    }

    private func configureBar() {
        let backgroundPath = UIBezierPath()
        backgroundPath.move(to: CGPoint(x: 0, y: bounds.midY))
        backgroundPath.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
        barLayer.path = backgroundPath.cgPath
        barLayer.lineWidth = frame.height

        let foregroundPath = UIBezierPath()
        foregroundPath.move(to: CGPoint(x: 0, y: bounds.midY))
        foregroundPath.addLine(to: CGPoint(x: bounds.width, y: bounds.midY))
        ringLayer.path = foregroundPath.cgPath
        ringLayer.lineWidth = frame.height
    }
}



#Preview {
    let style = HSEStyle(
        backgroundColor: "#e0c477",
        foregroungColor: "#fa8b02"
    )
    let pb = ProgressBar(style: style)

    NSLayoutConstraint.activate([
        pb.heightAnchor.constraint(equalToConstant: 30),
        pb.widthAnchor.constraint(equalToConstant: 300)
    ])

    return pb
}
