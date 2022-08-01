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

public class LineView: UIView {
    
    /// The progress bar which adjusts width based on progress.
    private var progressBar: UIView!
    
    /// Progress on the track [0.0, 1.0]. Animatable.
    @objc public dynamic var progress: CGFloat {
        set { progressLayer.progress = newValue }
        get { return progressLayer.progress }
    }
    
    /// Display color of the progress bar. Animatable.
    @objc public dynamic var color: UIColor {
        set { progressLayer.color = newValue.cgColor }
        get { return UIColor(cgColor: progressLayer.color) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.progress = 0.0
        self.color = .black
        
        progressBar = UIView(frame: .zero)
        progressBar.backgroundColor = color
        addSubview(progressBar)
    }
    
    public override class var layerClass: AnyClass {
        return LineLayer.self
    }
    
    private var progressLayer: LineLayer {
        return layer as! LineLayer
    }
    
    public override func display(_ layer: CALayer) {
        guard let presentationLayer = layer.presentation() as? LineLayer else {
            return
        }
        
        // Use presentationLayer's interpolated property value(s) to update UI components.
        let progress = max(0.0, min(1.0, presentationLayer.progress))
        
        // frame
        let x: CGFloat
        let width: CGFloat
        
        if progress <= 0.25 {
            x = 0
            width = 0
        } else if progress <= 0.5 {
            x = 0
            width = (progress - 0.25) * layer.bounds.width / 0.25
        } else if progress <= 0.75 {
            x = 0
            width = layer.bounds.width
        } else {
            x = (progress - 0.75) * layer.bounds.width / 0.25
            width = layer.bounds.width - x
        }
        
        progressBar.frame = CGRect(x: x, y: 0, width: width, height: bounds.height)
        progressBar.backgroundColor = UIColor(cgColor: presentationLayer.color)
        progressBar.layer.cornerRadius = bounds.height / 2
    }
}

/// A backing layer for ProgressView which supports certain animatable values.
fileprivate class LineLayer: CALayer {
    @NSManaged var progress: CGFloat
    @NSManaged var color: CGColor
    
    // Whenever a new presentation layer is created, this function is called and makes a COPY of the object.
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? LineLayer {
            progress = layer.progress
            color = layer.color
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if isAnimationKeySupported(key) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if LineLayer.isAnimationKeySupported(event) {
            // Copy animation context and mutate as needed
            guard let animation = currentAnimationContext(in: self)?.copy() as? CABasicAnimation else {
                setNeedsDisplay()
                return nil
            }
            
            animation.keyPath = event
            if let presentation = presentation() {
                animation.fromValue = presentation.value(forKeyPath: event)
            }
            animation.toValue = nil
            return animation
        }
        
        return super.action(forKey: event)
    }
    
    private class func isAnimationKeySupported(_ key: String) -> Bool {
        return key == #keyPath(progress) || key == #keyPath(color)
    }
    
    private func currentAnimationContext(in layer: CALayer) -> CABasicAnimation? {
        /// The UIView animation implementation is private, so to check if the view is animating and
        /// get its property keys we can use the key "backgroundColor" since its been a property of
        /// UIView which has been forever and returns a CABasicAnimation.
        return action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation
    }
}
