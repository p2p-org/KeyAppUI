import UIKit
import BEPureLayout
import Foundation
import PureLayout

public class SnackBarView: UIView {
    
    // MARK: -
    
    public var text: String {
        didSet { titleView.text = text }
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
        var numberOnLines = 2
    }
    
    let container = BERef<UIView>()
    let leadingSpacing = BERef<UIView>()
    let trailingSpacing = BERef<UIView>()
    let titleView = BERef<UILabel>()
    let buttonView = BERef<UIView>()

    var appearance = Appearance(
        textFontSize: 15.0,
        textFontWeight: .regular,
        textFont: .systemFont(ofSize: 15.0),
        textColor: .white,
        buttonTitleFontSize: 14.0,
        buttonTitleFontWeight: .bold,
        buttonTitleTextColor: UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
    )

    public init(
        icon: UIImage,
        text: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        
        self.text = text
        super.init(frame: .zero)
        
//        let icon = UIImageView(width: 24, height: 24, image: icon)
//            .padding(.init(top: 16, left: 20, bottom: 16, right: 15))
//        icon.contentMode = .scaleAspectFill
//        icon.clipsToBounds = true
//
//        var label: UIView = makeLabel(text: text)
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        label = label.padding(.init(top: 12, left: 0, bottom: 12, right: 0))
//
//        var button: UIView?
//        if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
//            button = makeButton(title: buttonTitle).onTap(buttonAction)
////                .setTarget(target: self, action: #selector(actionSelector), for: .touchDown)
////                .padding(.init(only: .right, inset: 12))
//            button?.setContentHuggingPriority(.defaultLow, for: .horizontal)
//            button?.setContentCompressionResistancePriority(.required, for: .horizontal)
//        }
//        commonInit(leftView: icon, centerView: label, rightView: button)
        
        
        // Build
        let child = build()
        addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
    }
    
    // MARK: -
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel(
            text: text,
            textSize: appearance.textFontSize,
            weight: appearance.textFontWeight,
            numberOfLines: appearance.numberOnLines,
            textAlignment: .left
        )
        label.textColor = appearance.textColor
        return label
    }

    private func makeButton(title: String) -> TextButton {
        TextButton.style(
            title: "Button",
            style: .primary,
            size: .small
        )
//        UIButton(
//            backgroundColor: appearance.buttonBackgroundColor,
//            label: title,
//            labelFont: UIFont.systemFont(
//                ofSize: appearance.buttonTitleFontSize,
//                weight: appearance.buttonTitleFontWeight
//            ),
//            textColor: appearance.buttonTitleTextColor,
//            contentInsets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
//        )
    }
    
    private func icon(with image: UIImage) -> UIView {
        let icon = UIImageView(width: 24, height: 24, image: image)
        icon.contentMode = .scaleAspectFit
        return icon
    }
    
    func build() -> UIView {
        BEContainer {
            BEHStack(spacing: 18, alignment: .center, distribution: .fillProportionally) {
                // Leading
//                BEContainer()
//                    .frame(width: 4)
//                    .bind(leadingSpacing)
                
//                icon(with: .add)
//                    .frame(width: 24, height: 24)

                    UILabel(
                        text: self.text,
                        font: appearance.textFont,
                        textColor: Asset.Colors.snow.color,
                        numberOfLines: appearance.numberOnLines
                    ).bind(titleView)
                        .padding(.init(only: [.top, .bottom], inset: 18))
//                        .setup { view in
//                            view.setContentHuggingPriority(.required, for: .horizontal)
//                            view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//                        }
                UIView.spacer
//                BEHStack(spacing: 0, alignment: .trailing, distribution: .fill) {
                    TextButton.style(
                        title: "Button",
                        style: .ghostLime,
                        size: .small
                    ).bind(buttonView)
//                    .setup { view in
//                        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
//                        view.setContentCompressionResistancePriority(.required, for: .horizontal)
//                    }
//                }

            }.withTag(1)
        }.backgroundColor(color: Asset.Colors.night.color)
        .box(cornerRadius: appearance.cornerRadius)
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
