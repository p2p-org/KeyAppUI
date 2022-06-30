import BEPureLayout
import PureLayout
import UIKit

public class BaseCell: BECollectionCell {
    
    // MARK: - View References
    
    private let container = BERef<UIView>()
    
    private var left: BaseCellLeftView?
    private var right: BaseCellRightView?
    
    // MARK: -
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    public override func build() -> UIView {
        BEHStack(spacing: 0, alignment: .center, distribution: .fill) {
            if let left = left {
                left.padding(.init(only: .left, inset: 17))
            }
            if let right = right {
                BESpacer(.horizontal)
                right.padding(.init(only: .right, inset: 19))
            }
        }
        .bind(container)
        .padding(.init(top: 12, left: 0, bottom: 12, right: 0))
    }
    
    public func configure(with item: BaseCellItem) {
        self.left = .init(
            image: item.image,
            title: item.title,
            subtitle: item.subtitle,
            subtitle2: item.subtitle2
        )
        
        self.right = .init(
            text: item.rightView?.text,
            subtext: item.rightView?.subtext,
            image: item.rightView?.image,
            isChevroneVisible: item.rightView?.isChevronVisible ?? false,
            badge: item.rightView?.badge,
            yellowBadge: item.rightView?.yellowBadge,
            checkbox: item.rightView?.checkbox,
            switch: item.rightView?.`switch`,
            isCheckmark: item.rightView?.isCheckmark ?? false
        )
        
        let child = build()
        contentView.addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    public override func prepareForReuse() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}


public struct BaseCellItem {
    public var title: String?
    public var subtitle: String?
    public var subtitle2: String?
    public var image: UIImage?
    public var rightView: BaseCellRightViewItem?
    
    public init(
        title: String?,
        subtitle: String?,
        subtitle2: String?,
        image: UIImage?,
        rightView: BaseCellRightViewItem?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.subtitle2 = subtitle2
        self.image = image
        self.rightView = rightView
    }
}
