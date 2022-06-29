import Foundation
import UIKit
import BEPureLayout

public class BaseCellLeftView: BECompositionView {

    // MARK: -
    
    private(set) var image: UIImage?
    private(set) var title: String?
    private(set) var subtitle: String?
    private(set) var subtitle2: String?
    
    public init(
        image: UIImage? = nil,
        title: String? = nil,
        subtitle: String? = nil,
        subtitle2: String? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.subtitle2 = subtitle2
        
        super.init()
    }
    
    // MARK: -
    
    open override func build() -> UIView {
        BEHStack(spacing: 14, alignment: .center) {
            if let image = image {
                BECenter {
                    UIImageView(width: 20, height: 20, image: image)
                }.padding(.init(top: 0, left: 11, bottom: 0, right: 13))
            }
            
            BEVStack(spacing: 4, alignment: .fill, distribution: .fillProportionally) {
                if let title = title {
                    UILabel().withAttributedText(
                        UIFont.text(title, of: .text2)
                    ).setup { label in
                        label.numberOfLines = 0
                        label.setContentHuggingPriority(.defaultLow, for: .vertical)
                        label.setContentCompressionResistancePriority(.required, for: .vertical)
                        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        label.setContentCompressionResistancePriority(.required, for: .horizontal)
                    }.padding(.init(only: .bottom, inset: titleBottomPadding()))
                }
                
                if let subtitle = subtitle {
                    UILabel().withAttributedText(
                        UIFont.text(subtitle, of: .label1)
                            .withForegroundColor(Asset.Colors.night.color)
                    ).setup { label in
                        label.numberOfLines = 0
                        label.setContentHuggingPriority(.defaultLow, for: .vertical)
                        label.setContentCompressionResistancePriority(.required, for: .vertical)
                        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        label.setContentCompressionResistancePriority(.required, for: .horizontal)
                    }.padding(.init(only: .bottom, inset: subtitle2 != nil ? 3 : 0))
                }
                
                if let subtitle2 = subtitle2 {
                    UILabel().withAttributedText(
                        UIFont.text(subtitle2, of: .label1)
                            .withForegroundColor(Asset.Colors.mountain.color)
                    ).setup { label in
                        label.numberOfLines = 0
                        label.setContentHuggingPriority(.defaultLow, for: .vertical)
                        label.setContentCompressionResistancePriority(.required, for: .vertical)
                        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
                        label.setContentCompressionResistancePriority(.required, for: .horizontal)
                    }
                }
            }
        }
    }
    
    private func titleBottomPadding() -> CGFloat { subtitle != nil ? 9 : ((subtitle2 != nil) ? 2 : 0) }
    
}
