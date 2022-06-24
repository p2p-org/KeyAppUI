import UIKit
import BEPureLayout

private extension SplashView {
    enum Constants {
        static let overlayOffset: CGFloat = 2
        static let underlineHeight: CGFloat = 1.5
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

    private let text: String

    private var hStack = BERef<BEHStack>()
    private let lineLayer = CAShapeLayer()

    public init(text: String) {
        self.text = text
        super.init()
    }

    override func build() -> UIView {
        BEHStack(spacing: 0) {
            for char in text {
                makeLetterLabel(text: String(char))
            }
        }
            .bind(hStack)
            .padding(.init(only: .top, inset: 20))
            .centered(.horizontal)
            .centered(.vertical)
            .backgroundColor(color: Asset.Colors.lime.color)
    }
    
    override func layout() {
        let size = hStack.view!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let view = UIView(width: size.width, height: size.height, backgroundColor: Asset.Colors.lime.color)
            .padding(.init(only: .top, inset: 20))
            .centered(.horizontal)
            .centered(.vertical)
        addSubview(view)
        
        lineLayer.strokeColor = Asset.Colors.night.color.cgColor
        lineLayer.lineCap = .round
        lineLayer.lineWidth = Constants.underlineHeight
        layer.addSublayer(lineLayer)
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

    private func animateText(delay: Double = .zero, position: TextPosition) {
        var delay = delay

        let letterViews = hStack.view!.arrangedSubviews.compactMap {$0 as? UILabel}
        for i in 0..<letterViews.count {
            let label = letterViews[i]

            if label.text?.isEmpty == true { continue }

            delay += 0.05
            UIView.animate(
                withDuration: 0.4,
                delay: delay,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.curveEaseOut]) {
                    let value = (Constants.textOffset / 2 ) + Constants.overlayOffset * 2 + Constants.underlineHeight

                    if position == .up {
                        label.center.y -= value
                    }
                    else {
                        label.center.y += value
                    }
                
                } completion: { finished in
                    guard finished && i == letterViews.count - 1 else { return }
                    self.animateLine(textPosition: position)
                }
        }
    }

    private func animateLine(textPosition: TextPosition) {
        let endPath = endLinePath(for: textPosition)
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startLinePath(for: textPosition)
        animation.toValue = endPath
        animation.duration = 0.3
        CATransaction.setCompletionBlock { [weak self] in
            self?.lineLayer.path = endPath
            if textPosition == .down {
                self?.lineLayer.path = nil // remove dot after completion
            }
            self?.animateText(delay: 0.1, position: textPosition.toggle())
//            if textPosition == .down {
//                self?.completionHandler?()
//            }
        }
        lineLayer.add(animation, forKey: "path")
        CATransaction.commit()
    }

    private func startLinePath(for position: TextPosition) -> CGPath {
        let frame = getFrameForLine()
        return CGPath(rect: CGRect(x: frame.minX, y: frame.minY, width: position == .up ? .zero: frame.width, height: Constants.underlineHeight), transform: nil)
    }

    private func endLinePath(for position: TextPosition) -> CGPath {
        let frame = getFrameForLine()
        let x: CGFloat
        let width: CGFloat
        if position == .up {
            x = frame.minX
            width = frame.width
        }
        else {
            x = frame.maxX
            width = .zero
        }
        return CGPath(rect: CGRect(x: x, y: frame.minY, width: width, height: Constants.underlineHeight), transform: nil)
    }
    
    private func getFrameForLine() -> CGRect {
        let frame = hStack.view!.superview!.convert(hStack.frame, to: self)
        return .init(x: frame.minX, y: frame.minY+Constants.overlayOffset, width: frame.width, height: frame.height)
    }
}
