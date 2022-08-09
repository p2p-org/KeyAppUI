import UIKit

public struct SliderButtonAppearance {
    /// A background color of button.
    let backgroundColor: UIColor

    /// A title color of button
    let titleColor: UIColor

    /// A font of title
    let font: UIFont

    /// An icon tint color
    let iconColor: UIColor

    /// An icon background color
    let iconBackgroundColor: UIColor

    public init(
        backgroundColor: UIColor,
        titleColor: UIColor,
        font: UIFont,
        iconColor: UIColor,
        iconBackgroundColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.font = font
        self.iconColor = iconColor
        self.iconBackgroundColor = iconBackgroundColor
    }

    public static func `default`() -> Self {
        .init(
            backgroundColor: Asset.Colors.night.color,
            titleColor: Asset.Colors.snow.color,
            font: .systemFont(ofSize: 16, weight: .semibold),
            iconColor: Asset.Colors.night.color,
            iconBackgroundColor: Asset.Colors.lime.color
        )
    }
}
