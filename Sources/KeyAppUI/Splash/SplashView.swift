import UIKit
import BEPureLayout

private extension SplashView {
    enum Constants {
        static let overlayOffset: CGFloat = 2
        static let underlineHeight: CGFloat = 3
        static let overlayHeight: CGFloat = 100
        static let textOffset: CGFloat = 55
    }

    enum TextPosition {
        case up, down

        func toggle() -> TextPosition {
            self == .up ? .down : .up
        }
    }
}

final class SplashView: BECompositionView {

    var completionHandler: (() -> Void)?

    private let text: String

    private let rootView = BERef<UIView>()
    private var letterViews: [BERef<UILabel>] = []
    private let textHelperView = BERef<BEHStack>()
    private var lineLayer: CAShapeLayer?

    public init(text: String) {
        self.text = text
        super.init()
    }

    override func build() -> UIView {
        let view = UIView().bind(rootView)
        view.backgroundColor = Asset.Colors.lime.color

        let textView = BEHStack(spacing: .zero) {
            return text.map { makeLetterLabel(text: String($0)) }
        }.bind(textHelperView)

        view.addSubview(textView)

        let labels = text.map { char -> UILabel in
            let label = makeLetterLabel(text: String(char))
            let ref = BERef<UILabel>()
            _ = label.bind(ref)
            self.letterViews.append(ref)
            return label
        }

        for i in 0..<labels.count {
            view.addSubview(labels[i])
            if i == 0 {
                labels[i].autoPinEdge(.leading, to: .leading, of: textView)
                labels[i].autoPinEdge(.top, to: .top, of: textView)
            }
            else {
                labels[i].autoPinEdge(.leading, to: .trailing, of: labels[i-1])
                labels[i].autoPinEdge(.bottom, to: .bottom, of: labels[i-1])
            }
        }
        
        let overlayView = BEView()
            .backgroundColor(color: Asset.Colors.lime.color)

        view.addSubview(overlayView)

        textView.autoAlignAxis(.vertical, toSameAxisOf: view)
        textView.autoAlignAxis(.horizontal, toSameAxisOf: view, withOffset: Constants.textOffset)

        overlayView.autoPinEdge(.top, to: .top, of: textView, withOffset: -Constants.overlayOffset)
        overlayView.autoMatch(.width, to: .width, of: textView)
        overlayView.autoSetDimension(.height, toSize: Constants.overlayHeight)
        overlayView.autoPinEdge(.leading, to: .leading, of: textView)

        return view
    }

    func animate() {
        animateText(position: .up)
    }
}

private extension SplashView {

    func makeLetterLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.font(of: .title1, weight: .medium)
        label.textColor = Asset.Colors.night.color
        return label
    }

    private func animateText(position: TextPosition) {
        var delay = Double.zero

        for i in 0..<letterViews.count {
            let label = letterViews[i]

            if label.text?.isEmpty == true { continue }

            delay += 0.05
            UIView.animate(
                withDuration: 0.4,
                delay: delay,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.curveEaseInOut]) {
                    let value = (Constants.textOffset / 2 ) + Constants.overlayOffset * 2 + Constants.underlineHeight

                    if position == .up {
                        label.center.y -= value
                    }
                    else {
                        label.center.y += value
                    }
                
                } completion: { finished in
                    guard finished && i == self.letterViews.count - 1 else { return }
                    self.animateLine(textPosition: position)
                }
        }
    }

    private func animateLine(textPosition: TextPosition) {
        if lineLayer == nil {
            let shapeLayer = CAShapeLayer()
            drawLine(shapeLayer: shapeLayer)
            lineLayer = shapeLayer
        }

        guard let lineLayer = lineLayer else { return }
        let endPath = endLinePath(for: textPosition)
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startLinePath(for: textPosition)
        animation.toValue = endPath
        animation.duration = 0.3
        CATransaction.setCompletionBlock { [weak self] in
            self?.lineLayer?.path = endPath
            self?.animateText(position: textPosition.toggle())
            if textPosition == .down {
                self?.completionHandler?()
            }
        }
        lineLayer.add(animation, forKey: "path")
        CATransaction.commit()
    }

    private func startLinePath(for position: TextPosition) -> CGPath {
        let width: CGFloat
        if position == .up {
            width = .zero
        }
        else {
            width = textHelperView.frame.width
        }
        return CGPath(rect: CGRect(x: textHelperView.frame.minX, y: textHelperView.frame.minY, width: width, height: Constants.underlineHeight), transform: nil)
    }

    private func endLinePath(for position: TextPosition) -> CGPath {
        let x: CGFloat
        let width: CGFloat
        if position == .up {
            x = textHelperView.frame.minX
            width = textHelperView.frame.width
        }
        else {
            x = textHelperView.frame.maxX
            width = .zero
        }
        return CGPath(rect: CGRect(x: x, y: textHelperView.frame.minY, width: width, height: Constants.underlineHeight), transform: nil)
    }

    func drawLine(shapeLayer: CAShapeLayer) {
        let rect = CGRect(
            x: textHelperView.frame.minX,
            y: textHelperView.frame.minY,
            width: .zero,
            height: Constants.underlineHeight
        )
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 2)
        shapeLayer.masksToBounds = true
        shapeLayer.frame = self.rootView.bounds
        shapeLayer.strokeColor = Asset.Colors.night.color.cgColor
        shapeLayer.fillColor = Asset.Colors.night.color.cgColor
        shapeLayer.path = path.cgPath
        self.rootView.view?.layer.addSublayer(shapeLayer)
    }
}
