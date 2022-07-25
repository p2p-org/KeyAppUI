import UIKit
import BEPureLayout

class TextField: UITextField {
    
    let leftPadding: CGFloat = 16
    
    // MARK: - Ref

    let coverViewRef = BERef<UIView>()
    let placeholderContainerRef = BERef<UIView>()
    var placeholderRef = BERef<UILabel>()
    var placeholderLeadingRef = BERef<UIView>()
    
    // MARK: -
    
    override var font: UIFont? {
        didSet {
            placeholderRef.font = font
        }
    }
    
    public var constantPlaceholder: String? {
        didSet {
            placeholderRef.text = constantPlaceholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let place = placeholderView()
        insertSubview(place, at: 0)
        insertSubview(placeholderCoverView(), aboveSubview: place)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeholderView() -> UIView {
        UILabel(text: constantPlaceholder,
                font: self.font,
                textColor: Asset.Colors.night.color.withAlphaComponent(0.3)
        )
            .bind(placeholderRef)
    }
    
    func placeholderCoverView() -> UIView {
        UIView().bind(coverViewRef).setup { vv in
            vv.backgroundColor = Asset.Colors.rain.color
            vv.isUserInteractionEnabled = false
        }
    }
    
    func update() {
        guard let placeholder = constantPlaceholder, let text = self.text, let font = self.font else { return }
        let endIndex = min(text.count, placeholder.count)
        let placeholderSubstring = placeholder[0..<endIndex]
        coverViewRef.view?.frame = CGRect(
            x: leadingInset,
            y: 12,
            width: String(placeholderSubstring).widthOfString(usingFont: font),
            height: self.layer.bounds.height
        )
        placeholderRef.view?.frame = placeholderRect(forBounds: bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        update()
    }
    
    // MARK: -

    var leadingInset: CGFloat {
        max(self.leftViewRect(forBounds: bounds).width, leftPadding)
    }
    
    var trailingInset: CGFloat {
        max(self.rightViewRect(forBounds: bounds).width, leftPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: leadingInset, y: 0, width: bounds.width - leadingInset - trailingInset, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: leadingInset, y: 0, width: bounds.width - leadingInset - trailingInset, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: leadingInset, y: 0, width: bounds.width - leadingInset - trailingInset, height: bounds.height)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return CGRect(
            x: rect.origin.x + leftPadding,
            y: rect.origin.y,
            width: rect.width + leftPadding + leftPadding/2,
            height: rect.height
        )
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return CGRect(
            x: rect.origin.x - leftPadding,
            y: rect.origin.y,
            width: rect.width + leftPadding + leftPadding/2,
            height: rect.height
        )
    }

}
