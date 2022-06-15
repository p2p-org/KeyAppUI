import UIKit
import BEPureLayout
import Foundation
import PureLayout

public class SnackBarView: UIView {
    
    // MARK: -
    
    public var text: String {
        didSet { titleView.text = text }
    }
    
    public var buttonTitle: String? {
        didSet { buttonView.title = buttonTitle ?? "" }
    }
    
    public var icon: UIImage {
        didSet { iconView.image = icon }
    }
    
    /// Structure describing
    struct Appearance {
        var textFontSize: CGFloat
        var textFontWeight: UIFont.Weight
        var textFont: UIFont
        var textColor: UIColor
        var buttonTitleFontSize: CGFloat
        var buttonTitleFontWeight: UIFont.Weight
        var buttonTitleTextColor: UIColor
        var cornerRadius: CGFloat = 13
        var backgroundColor: UIColor = .init(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
        var borderColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.2)
        var buttonBackgroundColor: UIColor = .clear
        var iconTintColor: UIColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        var numberOnLines = 2
    }
    
    let container = BERef<UIView>()
    let leadingSpacing = BERef<UIView>()
    let trailingSpacing = BERef<UIView>()
    let titleView = BERef<UILabel>()
    let buttonView = BERef<TextButton>()
    let iconView = BERef<UIImageView>()

    var appearance: Appearance = Appearance(
        textFontSize: 15.0,
        textFontWeight: .regular,
        textFont: .systemFont(ofSize: 15.0),
        textColor: .white,
        buttonTitleFontSize: 14.0,
        buttonTitleFontWeight: .bold,
        buttonTitleTextColor: UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
    ) {
        didSet {
            
        }
    }
    
    private let buttonAction: (() -> Void)?

    public init(
        icon: UIImage,
        text: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.buttonAction = buttonAction
        self.text = text
        self.buttonTitle = buttonTitle
        self.icon = icon
        super.init(frame: .zero)

        // Build
        let child = build()
        addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: -
    
    func build() -> UIView {
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
                    text: self.text,
                    font: appearance.textFont,
                    textColor: Asset.Colors.snow.color,
                    numberOfLines: appearance.numberOnLines
                ).bind(titleView)
                    .padding(.init(only: [.top, .bottom], inset: 18))

                UIView.spacer

                TextButton.style(
                    title: buttonTitle ?? "",
                    style: .ghostLime,
                    size: .small
                ).bind(buttonView)
                .onTap(buttonAction ?? {})

            }.withTag(1)
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
