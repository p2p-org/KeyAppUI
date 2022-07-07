import BEPureLayout
import PureLayout
import UIKit

public enum BadgeViewStyle {
    case basic
    case yellow
}

public class BadgeView: BECompositionView {

    private let style: BadgeViewStyle
    private(set) var text: String
    
    private var box = BERef<UIView>()
    
    public init(text: String, style: BadgeViewStyle = .basic) {
        self.style = style
        self.text = text
        super.init(frame: .zero)
    }
    
    public override func build() -> UIView {
        UILabel().withAttributedText(.attributedString(with: text, of: fontStyle)
            .withForegroundColor(textColor)
        )
        .setup({ label in
            label.setContentHuggingPriority(.defaultLow, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
        })
        .frame(height: height)
        .padding(padding)
        .box(cornerRadius: cornerRadius)
        .backgroundColor(color: backgroundColor())
    }
    
    // MARK: -
    
    private func backgroundColor() -> UIColor {
        switch style {
        case .yellow:
            return .lime
        case .basic:
            return .mountain
        }
    }
    
    private var fontStyle: UIFont.Style {
        switch style {
        case .basic:
            return .label2
        case .yellow:
            return .text4
        }
    }
    
    private var textColor: UIColor {
        switch style {
        case .basic:
            return .snow
        case .yellow:
            return .mountain
        }
    }
    
    private var cornerRadius: CGFloat {
        if case .yellow = style { return 10 } else { return 8 }
    }
    
    private var height: CGFloat {
        if case .yellow = style { return 20 } else { return 15 }
    }
    
    private var padding: UIEdgeInsets {
        switch style {
        case .basic:
            return .init(top: 0, left: 5, bottom: 1, right: 4)
        case .yellow:
            return .init(top: 0, left: 9, bottom: 0, right: 9)
        }
    }
    
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
}
