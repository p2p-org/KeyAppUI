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
            makeLetter(asset: Asset.MaterialIcon.k)
                .frame(width: 12.9, height: 21.6)
                .padding(UIEdgeInsets(top: .zero, left: .zero, bottom: 7, right: .zero))
            makeLetter(asset: Asset.MaterialIcon.e)
                .frame(width: 14.2, height: 14.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 0.6))
            makeLetter(asset: Asset.MaterialIcon.y)
                .frame(width: 14.4, height: 21.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 5.7))
            makeLetter(asset: Asset.MaterialIcon.a)
                .frame(width: 14.8, height: 14.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 3.7))
            makeLetter(asset: Asset.MaterialIcon.p1)
                .frame(width: 14.7, height: 21.6)
                .padding(UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 2))
            makeLetter(asset: Asset.MaterialIcon.p2)
                .frame(width: 14.7, height: 21.6)
                .padding(.init(only: .top, inset: 7))
        }
        .bind(hStack)
        .padding(.init(only: .top, inset: Constants.centerOffset))
        .centered(.horizontal)
        .centered(.vertical)
        .backgroundColor(color: Asset.Colors.lime.color)
    }
    
    override func layout() {
        let size = hStack.view!.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let view = UIView(width: size.width + Constants.overlayOffset, height: size.height + Constants.overlayOffset, backgroundColor: Asset.Colors.lime.color)
            .padding(.init(only: .top, inset: Constants.centerOffset))
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
    
    func makeLetter(asset: ImageAsset) -> UIImageView {
        let view = UIImageView(image: asset.image)
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
            self?.lineLayer.path = textPosition == .down ? nil : endPath
            if let handler = self?.completionHandler, textPosition == .down {
                handler()
            }
            else {
                self?.animateText(delay: 0.1, position: textPosition.toggle())
            }
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

// MARK: - New implementation

public class SplashView2: UIView {

    public dynamic var progress: CGFloat = 0 {
        didSet {
            progressLayer.progress = progress
        }
    }

    fileprivate var progressLayer: SplashLayer2 {
        return layer as! SplashLayer2
    }

    override public class var layerClass: AnyClass {
        return SplashLayer2.self
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    public func animate() {
        let animation = CABasicAnimation(keyPath: "progress")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.repeatCount = .greatestFiniteMagnitude
        layer.add(animation, forKey: nil)
    }
}

/*
* Concepts taken from:
* https://stackoverflow.com/a/37470079
*/
private extension SplashLayer2 {
    enum Constants {
        static let overlayOffset: CGFloat = 2
        static let underlineHeight: CGFloat = 3
        static let textOffset: CGFloat = 55
        static let centerOffset: CGFloat = 22
    }
}

fileprivate class SplashLayer2: CALayer {
    @NSManaged var progress: CGFloat
    let startAngle: CGFloat = 1.5 * .pi
    let twoPi: CGFloat = 2 * .pi
    let halfPi: CGFloat = .pi / 2


    override class func needsDisplay(forKey key: String) -> Bool {
        if key == #keyPath(progress) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }

    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)

        UIGraphicsPushContext(ctx)
        
        drawLetters()
        drawLine()
        
        UIGraphicsPopContext()
    }
    
    private func drawLine() {
        let x: CGFloat
        let width: CGFloat
        
        if progress <= 0.25 {
            x = 0
            width = 0
        } else if progress <= 0.5 {
            x = 0
            width = (progress - 0.25) * bounds.width / 0.25
        } else if progress <= 0.75 {
            x = 0
            width = bounds.width
        } else {
            x = (progress - 0.75) * bounds.width / 0.25
            width = bounds.width - x
        }

        Asset.Colors.night.color.set()
        let rect = CGRect(x: x, y: bounds.height - Constants.underlineHeight, width: width, height: Constants.underlineHeight)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.underlineHeight/2)
        path.fill()
    }
    
    private func drawLetters() {
        let assets: [(UIImage, CGSize, UIEdgeInsets)] = [
            (Asset.MaterialIcon.k.image, CGSize(width: 12.9, height: 21.6), UIEdgeInsets(top: .zero, left: .zero, bottom: 7, right: .zero)),
            (Asset.MaterialIcon.e.image, CGSize(width: 14.2, height: 14.6), UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 0.6)),
            (Asset.MaterialIcon.y.image, CGSize(width: 14.4, height: 21.6), UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 5.7)),
            (Asset.MaterialIcon.a.image, CGSize(width: 14.8, height: 14.6), UIEdgeInsets(top: 7, left: .zero, bottom: 7, right: 3.7)),
            (Asset.MaterialIcon.p1.image, CGSize(width: 14.7, height: 21.6), UIEdgeInsets(top: 7, left: .zero, bottom: .zero, right: 2)),
            (Asset.MaterialIcon.p2.image, CGSize(width: 14.7, height: 21.6), .init(only: .top, inset: 7))
        ]
        
        var x: CGFloat = 0
        for (index, asset) in assets.enumerated() {
            var y: CGFloat = asset.2.top
            
            if progress <= 0.25 {
                y += ((0.25 - progress) / 0.25) * (bounds.maxY + CGFloat(10 * index))
            }
            
            let rect = CGRect(x: x, y: y, width: asset.1.width, height: asset.1.height)
            x += asset.1.width + asset.2.right
            asset.0.draw(in: rect)
        }
    }
}
