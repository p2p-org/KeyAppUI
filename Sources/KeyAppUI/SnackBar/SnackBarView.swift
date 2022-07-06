import BEPureLayout
import Foundation
import PureLayout
import UIKit

public class SnackBarView: BECompositionView {
    // MARK: -

    public var text: String {
        didSet { titleView.text = text }
    }
    
    public var icon: UIImage {
        didSet { iconView.image = icon }
    }

    let container = BERef<UIView>()
    let leadingSpacing = BERef<UIView>()
    let titleView = BERef<UILabel>()
    let iconView = BERef<UIImageView>()
    let trailing: UIView?

    var appearance: Appearance = Appearance(
        textFontSize: 15.0,
        textFontWeight: .regular,
        textFont: .systemFont(ofSize: 15.0),
        textColor: .white
    )

    public init(
        icon: UIImage,
        text: String,
        trailing: UIView? = nil
    ) {
        self.icon = icon
        self.text = text
        self.trailing = trailing
        
        super.init()
    }

    // MARK: -
    
    override public func build() -> UIView {
        BEContainer {
            BEHStack(spacing: 18, alignment: .center, distribution: .fill) {
                // Leading
                BEContainer()
                    .frame(width: 0)
                    .bind(leadingSpacing)

                UIImageView(
                    width: 24,
                    height: 24,
                    image: icon,
                    contentMode: .scaleAspectFit,
                    tintColor: appearance.iconTintColor)
                    .frame(width: 24, height: 24)
                    .bind(iconView)

                UILabel(
                    text: text,
                    font: appearance.textFont,
                    textColor: Asset.Colors.snow.color,
                    numberOfLines: appearance.numberOnLines
                ).bind(titleView)
                .margin(.init(top: 18, left: 0, bottom: 18, right: 0))
                .setup { view in
                    view.setContentHuggingPriority(.required, for: .horizontal)
                    view.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
                
                BEContainer()
                    .frame(width: 0)
                    .bind(leadingSpacing)
                
                UIView.spacer

                if let trailing = trailing { trailing }
            }
        }.backgroundColor(color: Asset.Colors.night.color)
        .box(cornerRadius: appearance.cornerRadius)
        .border(width: 1, color: appearance.borderColor)
        .bind(container)
        .setup { cont in
            guard let content = cont.viewWithTag(1) else { return }
            let constraint: NSLayoutConstraint = cont.autoMatch(.width, to: .width, of: content, withMultiplier: 1.0, relation: .greaterThanOrEqual)
            let height = cont.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
            height.isActive = true
            constraint.priority = .defaultLow
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SnackBarView {
    /// Structure describing appearance
    struct Appearance {
        var textFontSize: CGFloat
        var textFontWeight: UIFont.Weight
        var textFont: UIFont
        var textColor: UIColor
        var cornerRadius: CGFloat = 13
        var backgroundColor: UIColor = .init(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
        var borderColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.2)
        var iconTintColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        var numberOnLines = 2
    }
}
