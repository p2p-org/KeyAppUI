import UIKit
import BEPureLayout

private extension SplashView {
    enum Constants {
        static let overlayOffset: CGFloat = 2
        static let underlineHeight: CGFloat = 1.5
        static let textOffset: CGFloat = 55
        static let centerOffset: CGFloat = 22
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

    private var hStack = BERef<BEHStack>()
    private let lineLayer = CAShapeLayer()

    override func build() -> UIView {
        BEHStack(spacing: .zero) {
            makeLetter(image: .k)
                .frame(width: 12.9, height: 21.6)
                .padding(UIEdgeInsets(top: .zero, left: .zero, bottom: 7, right: .zero))
            makeLetter(image: .e)
                .frame(width: 14.2, height: 14.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 0.6))
            makeLetter(image: .y)
                .frame(width: 14.4, height: 21.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 5.7))
            makeLetter(image: .a)
                .frame(width: 14.8, height: 14.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 3.7))
            makeLetter(image: .p1)
                .frame(width: 14.7, height: 21.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 2))
            makeLetter(image: .p2)
                .frame(width: 14.7, height: 21.6)
                .padding(.init(only: .top, inset: 7))
        }
            .bind(hStack)
            .padding(.init(only: .top, inset: Constants.centerOffset))
            .centered(.horizontal)
            .centered(.vertical)
            .backgroundColor(color: .lime)
    }

    override func layout() {
        let size = hStack.view!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let view = UIView(width: size.width + Constants.overlayOffset, height: size.height + Constants.overlayOffset, backgroundColor: .lime)
            .padding(.init(only: .top, inset: Constants.centerOffset))
            .centered(.horizontal)
            .centered(.vertical)
        addSubview(view)

        lineLayer.strokeColor = UIColor.night.cgColor
        lineLayer.lineCap = .round
        lineLayer.lineWidth = Constants.underlineHeight
        layer.addSublayer(lineLayer)
    }

    func animate() {
        animateText(position: .up)
    }
}

private extension SplashView {

    func makeLetter(image: UIImage) -> UIImageView {
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        return view
    }

    private func animateText(delay: Double = .zero, position: TextPosition) {
        var delay = delay

        let letterViews = hStack.view!.arrangedSubviews
        for i in 0..<letterViews.count {
            let label = letterViews[i]

            delay += 0.05
            UIView.animate(
                withDuration: 0.4,
                delay: delay,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: [.curveEaseOut]) {
                    let value = Constants.textOffset / 2 + Constants.overlayOffset + Constants.underlineHeight

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
                self?.completionHandler?()
            }
            self?.animateText(delay: 0.1, position: textPosition.toggle())
        }
        lineLayer.add(animation, forKey: "path")
        CATransaction.commit()
    }

    private func startLinePath(for position: TextPosition) -> CGPath {
        let frame = getFrameForLine()
        return linePath(for: CGRect(x: frame.minX, y: frame.minY, width: position == .up ? .zero: frame.width, height: Constants.underlineHeight))
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
        return linePath(for: CGRect(x: x, y: frame.minY, width: width, height: Constants.underlineHeight))
    }

    private func linePath(for rect: CGRect) -> CGPath {
        return UIBezierPath(roundedRect: rect, cornerRadius: 2).cgPath
    }

    private func getFrameForLine() -> CGRect {
        let frame = hStack.view!.superview!.convert(hStack.frame, to: self)
        return .init(x: frame.minX, y: frame.minY+Constants.overlayOffset, width: frame.width, height: frame.height)
    }
}
