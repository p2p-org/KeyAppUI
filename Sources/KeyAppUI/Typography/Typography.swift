import UIKit

extension UIFont {
    
    /// Typography styles
    enum Style {
        case caption2
        case caption1
        case footnote
        case subheadline
        case callout
        case headline
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
        case .caption2:
            fontSize = 11
        case .caption1:
            fontSize = 12
        case .footnote:
            fontSize = 13
        case .subheadline:
            fontSize = 15
        case .callout:
            fontSize = 16
        case .headline:
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
        case .caption2:
            lineHeight = 12
        case .caption1, .footnote:
            lineHeight = 16
        case .subheadline, .callout:
            lineHeight = 20
        case .headline, .title3:
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
        case .caption2:
            letterSpacing = 0.07
        case .caption1:
            letterSpacing = 0
        case .footnote:
            letterSpacing = -0.08
        case .subheadline:
            letterSpacing = -0.24
        case .callout:
            letterSpacing = -0.32
        case .headline:
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
