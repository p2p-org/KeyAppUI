import UIKit

public extension UIFont {
    
    /// Typography styles
    enum Style: String, CaseIterable {
        case label2
        case label1
        case text4
        case text3
        case text2
        case text1
        case title3
        case title2
        case title1
        case largeTitle
    }
    
    /// Font by style and weight
    static func font(of style: Style, weight: Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: fontSize(of: style), weight: weight)
    }
    
    /// Attributed string of selected style and weight
    static func text(_ text: String, of style: Style, weight: Weight = .regular) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineHeight(for: style)
        let string = NSAttributedString(string: text, attributes: [
            .font: font(of: style, weight: weight),
            .paragraphStyle: paragraph,
            .kern: letterSpacibg(for: style)
        ])
        return string
    }
    
    // MARK: -
    
    private static func fontSize(of style: Style) -> CGFloat {
        var fontSize: CGFloat = 11
        switch style {
        case .label2:
            fontSize = 11
        case .label1:
            fontSize = 12
        case .text4:
            fontSize = 13
        case .text3:
            fontSize = 15
        case .text2:
            fontSize = 16
        case .text1:
            fontSize = 17
        case .title3:
            fontSize = 20
        case .title2:
            fontSize = 22
        case .title1:
            fontSize = 28
        case .largeTitle:
            fontSize = 34
        }
        return fontSize
    }
    
    private static func lineHeight(for style: Style) -> CGFloat {
        var lineHeight: CGFloat = 12
        switch style {
        case .label2:
            lineHeight = 12
        case .label1, .text4:
            lineHeight = 16
        case .text3, .text2:
            lineHeight = 20
        case .text1, .title3:
            lineHeight = 24
        case .title2:
            lineHeight = 28
        case .title1:
            lineHeight = 32
        case .largeTitle:
            lineHeight = 40
        }
        return lineHeight
    }
    
    private static func letterSpacibg(for style: Style) -> CGFloat {
        var letterSpacing = 0.07
        switch style {
        case .label2:
            letterSpacing = 0.07
        case .label1:
            letterSpacing = 0
        case .text4:
            letterSpacing = -0.08
        case .text3:
            letterSpacing = -0.24
        case .text2:
            letterSpacing = -0.32
        case .text1:
            letterSpacing = -0.41
        case .title3:
            letterSpacing = 0.38
        case .title2:
            letterSpacing = 0.35
        case .title1:
            letterSpacing = 0.36
        case .largeTitle:
            letterSpacing = 0.37
        }
        return letterSpacing
    }
}
