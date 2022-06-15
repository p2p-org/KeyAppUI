import BEPureLayout
import Foundation
import PureLayout
import UIKit

public class SnackBarView: BECompositionView {
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

    let trailing: UIView?

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
        icon _: UIImage,
        text: String,
        trailing: UIView? = nil
    ) {
        self.text = text
        self.trailing = trailing
        
        super.init()
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

    private func makeButton(title _: String) -> TextButton {
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

    override public func build() -> UIView {
        BEContainer {
            BEHStack(spacing: 18, alignment: .center, distribution: .fill) {
                // Leading
                BEContainer()
                    .frame(width: 4)
                    .bind(leadingSpacing)

                icon(with: .add)
                    .frame(width: 24, height: 24)

                UILabel(
                    text: self.text,
                    font: appearance.textFont,
                    textColor: Asset.Colors.snow.color,
                    numberOfLines: appearance.numberOnLines
                )
                .bind(titleView)
                .padding(.init(only: [.top, .bottom], inset: 18))

                UIView.spacer

                // Swift 5.7 with `if let trailing {...} would be nice :)
                if let trailing = trailing { trailing }
            }
        }.backgroundColor(color: Asset.Colors.night.color)
            .frame(height: 56)
            .box(cornerRadius: appearance.cornerRadius)
            .bind(container)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
