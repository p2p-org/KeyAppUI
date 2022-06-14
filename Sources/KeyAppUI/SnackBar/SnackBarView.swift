import UIKit

public class SnackBarView: UIView {
    
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

    private let container = UIStackView(axis: .horizontal)
    private var buttonAction: (() -> Void)?

    var appearance = Appearance(
        textFontSize: 15.0,
        textFontWeight: .regular,
        textFont: .systemFont(ofSize: 15.0),
        textColor: .white,
        buttonTitleFontSize: 14.0,
        buttonTitleFontWeight: .bold,
        buttonTitleTextColor: UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
    )

    init() {
        super.init(frame: .zero)

        container.layer.cornerRadius = appearance.cornerRadius
        addSubview(container)
        container.autoPinEdgesToSuperviewEdges()
        container.backgroundColor = appearance.backgroundColor
        container.border(
            width: 1,
            color: appearance.borderColor
        )
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    public convenience init(
        icon: UIImage,
        text: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.init()
        self.buttonAction = buttonAction

        let icon = UIImageView(width: 24, height: 24, image: icon)
            .padding(.init(top: 16, left: 20, bottom: 16, right: 15))
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true

        var label: UIView = makeLabel(text: text)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label = label.padding(.init(top: 12, left: 0, bottom: 12, right: 0))

        var button: UIView?
        if let buttonTitle = buttonTitle, let _ = buttonAction {
            button = makeButton(title: buttonTitle)
                .setTarget(target: self, action: #selector(actionSelector), for: .touchDown)
                .padding(.init(only: .right, inset: 12))
            button?.setContentHuggingPriority(.defaultLow, for: .horizontal)
            button?.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        commonInit(leftView: icon, centerView: label, rightView: button)
    }

    private func commonInit(leftView: UIView, centerView: UIView, rightView: UIView?) {
        var arrangeViews = [leftView]

        if let rightView = rightView {
            arrangeViews.append(UIView())
            arrangeViews.append(centerView)
            arrangeViews.append(UIView())
            arrangeViews.append(rightView)
        } else {
            arrangeViews.append(centerView)
            arrangeViews.append(UIView())
        }
        container.addArrangedSubviews(arrangeViews)
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

    private func makeButton(title: String) -> UIButton {
        UIButton(
            backgroundColor: appearance.buttonBackgroundColor,
            label: title,
            labelFont: UIFont.systemFont(
                ofSize: appearance.buttonTitleFontSize,
                weight: appearance.buttonTitleFontWeight
            ),
            textColor: appearance.buttonTitleTextColor,
            contentInsets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionSelector() {
        buttonAction?()
    }
}
