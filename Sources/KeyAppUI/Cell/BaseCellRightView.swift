import UIKit
import BEPureLayout

public protocol BaseCellRightViewDelegate: AnyObject {
    func checkboxDidChange(value: Bool)
    func switchDidChange(value: Bool)
}

public struct BaseCellRightViewItem {
    public var text: String?
    public var subtext: String?
    public var image: UIImage?
    public var isChevronVisible: Bool
    public var badge: String?
    public var yellowBadge: String?
    public var checkbox: Bool?
    public var `switch`: Bool?
    public var isCheckmark: Bool = false
    
    public init(
        text: String? = nil,
        subtext: String? = nil,
        image: UIImage? = nil,
        isChevronVisible: Bool = false,
        badge: String? = nil,
        yellowBadge: String? = nil,
        checkbox: Bool? = nil,
        switch: Bool? = nil,
        isCheckmark: Bool? = false
    ) {
        self.text = text
        self.subtext = subtext
        self.image = image
        self.isChevronVisible = isChevronVisible
        self.badge = badge
        self.yellowBadge = yellowBadge
        self.checkbox = checkbox
        self.`switch` = `switch`
        self.isCheckmark = isCheckmark ?? false
    }
}


public class BaseCellRightView: BECompositionView {

    public init(item: BaseCellRightViewItem) {
        self.text = item.text
        self.subtext = item.subtext
        self.image = item.image
        self.isChevronVisible = item.isChevronVisible
        self.badge = item.badge
        self.yellowBadge = item.yellowBadge
        self.checkbox = item.checkbox
        self.switch = item.switch
        self.isCheckmark = item.isCheckmark
        
        super.init()
    }
    
    var text: String?
    var subtext: String?
    var image: UIImage?
    var isChevronVisible: Bool
    var badge: String?
    var yellowBadge: String?
    var checkbox: Bool?
    var `switch`: Bool?
    var isCheckmark: Bool = false
    
    weak var delegate: BaseCellRightViewDelegate?
    
    // MARK: -
    
    private var switchView = BERef<UISwitch>()
    private var checkboxView = BERef<BECheckbox>()
    
    public override func build() -> UIView {
        BEHStack(spacing: 0, alignment: .fill, distribution: .fill) {
            textSubtextView()

            if let badge = badge {
                BadgeView(text: badge, style: .basic).padding(.init(only: .left, inset: subtext != nil ? 9 : 0))
            }

            if let `switch` = `switch` {
                UISwitch().setup({ elem in
                    elem.onTintColor = .night
                })
                .frame(width: 51, height: 31)
                .bind(switchView)
                .setup { elem in
                    elem.isOn = `switch`
                    switchView.view?.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
                }
            } else if let isChecked = checkbox {
                BECheckbox(width: 18, height: 18, backgroundColor: .clear, cornerRadius: 2)
                    .setup { checkbox in
                        checkbox.layer.borderColor = UIColor.black.cgColor
                        checkbox.isSelected = isChecked
                        checkbox.addTarget(self, action: #selector(checkboxDidChange(_:)), for: .valueChanged)
                    }
            }

            if let image = image {
                UIImageView(image: image, contentMode: .scaleAspectFit)
                    .padding(.init(top: 0, left: 12, bottom: 0, right: 0))
            } else if isCheckmark {
                UIImageView(image: .check, contentMode: .scaleAspectFit)
                    .padding(.init(top: 0, left: 12, bottom: 0, right: -5))
            }

            if isChevronVisible {
                UIImageView(
                    image: .chevronRight,
                    contentMode: .center,
                    tintColor: .mountain
                )
                .frame(width: 8)
                .padding(.init(top: 0, left: badge != nil ? 8 : 14, bottom: 0, right: 6))
            }
        }
    }
    
    // MARK: - Helpers
    
    private func textSubtextView() -> UIView {
        BEVStack(spacing: 7, alignment: .fill, distribution: .fillProportionally) {
            if let text = text {
                UILabel().withAttributedText(
                    UIFont.text(text, of: .text3, weight: .bold)
                        .withForegroundColor(.night)
                ).setup { label in
                    label.textAlignment = .right
                    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    label.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            }
            
            if let yellowBadge = yellowBadge {
                BadgeView(text: yellowBadge, style: .yellow)
            }
            
            if let subtext = subtext {
                UILabel().withAttributedText(
                    UIFont.text(subtext, of: .label1)
                        .withForegroundColor(.mountain)
                ).setup { label in
                    label.textAlignment = .right
                    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
                    label.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            }
        }
    }
    
    private func subtextRightPadding() -> CGFloat {
        image != nil || badge != nil ? 8 : 0
    }
    
    // MARK: - Actions
    
    @objc func switchDidChange(_ elem: UISwitch) {
        delegate?.switchDidChange(value: elem.isOn)
    }
    
    @objc func checkboxDidChange(_ checkbox: UISwitch) {
        delegate?.switchDidChange(value: checkbox.isOn)
    }
    
}
