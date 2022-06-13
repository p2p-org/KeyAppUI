// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Icons {
  public static let apps24px = ImageAsset(name: "apps_24px")
  public static let arrowBack24px = ImageAsset(name: "arrow_back_24px")
  public static let arrowBackIos24px = ImageAsset(name: "arrow_back_ios_24px")
  public static let arrowDownward24px = ImageAsset(name: "arrow_downward_24px")
  public static let arrowDropDown24px = ImageAsset(name: "arrow_drop_down_24px")
  public static let arrowDropDownCircle24px = ImageAsset(name: "arrow_drop_down_circle_24px")
  public static let arrowDropUp24px = ImageAsset(name: "arrow_drop_up_24px")
  public static let arrowForward24px = ImageAsset(name: "arrow_forward_24px")
  public static let arrowForwardIos24px = ImageAsset(name: "arrow_forward_ios_24px")
  public static let arrowLeft24px = ImageAsset(name: "arrow_left_24px")
  public static let arrowRight24px = ImageAsset(name: "arrow_right_24px")
  public static let arrowUpward24px = ImageAsset(name: "arrow_upward_24px")
  public static let cancel24px = ImageAsset(name: "cancel_24px")
  public static let check24px = ImageAsset(name: "check_24px")
  public static let checkBox24px = ImageAsset(name: "check_box_24px")
  public static let checkBoxOutlineBlank24px = ImageAsset(name: "check_box_outline_blank_24px")
  public static let chevronLeft24px = ImageAsset(name: "chevron_left_24px")
  public static let chevronRight24px = ImageAsset(name: "chevron_right_24px")
  public static let close24px = ImageAsset(name: "close_24px")
  public static let expandLess24px = ImageAsset(name: "expand_less_24px")
  public static let expandMore24px = ImageAsset(name: "expand_more_24px")
  public static let firstPage24px = ImageAsset(name: "first_page_24px")
  public static let fullscreen24px = ImageAsset(name: "fullscreen_24px")
  public static let fullscreenExit24px = ImageAsset(name: "fullscreen_exit_24px")
  public static let indeterminateCheckBox24px = ImageAsset(name: "indeterminate_check_box_24px")
  public static let lastPage24px = ImageAsset(name: "last_page_24px")
  public static let menu24px = ImageAsset(name: "menu_24px")
  public static let moreHoriz24px = ImageAsset(name: "more_horiz_24px")
  public static let moreVert24px = ImageAsset(name: "more_vert_24px")
  public static let radioButtonChecked24px = ImageAsset(name: "radio_button_checked_24px")
  public static let radioButtonUnchecked24px = ImageAsset(name: "radio_button_unchecked_24px")
  public static let refresh24px = ImageAsset(name: "refresh_24px")
  public static let star24px = ImageAsset(name: "star_24px")
  public static let starBorder24px = ImageAsset(name: "star_border_24px")
  public static let starBorderPurple50024px = ImageAsset(name: "star_border_purple500_24px")
  public static let starHalf24px = ImageAsset(name: "star_half_24px")
  public static let starOutline24px = ImageAsset(name: "star_outline_24px")
  public static let starPurple50024px = ImageAsset(name: "star_purple500_24px")
  public static let subdirectoryArrowLeft24px = ImageAsset(name: "subdirectory_arrow_left_24px")
  public static let subdirectoryArrowRight24px = ImageAsset(name: "subdirectory_arrow_right_24px")
  public static let toggleOff24px = ImageAsset(name: "toggle_off_24px")
  public static let toggleOn24px = ImageAsset(name: "toggle_on_24px")
  public static let unfoldLess24px = ImageAsset(name: "unfold_less_24px")
  public static let unfoldMore24px = ImageAsset(name: "unfold_more_24px")

  // swiftlint:disable trailing_comma
  public static let allImages: [ImageAsset] = [
    apps24px,
    arrowBack24px,
    arrowBackIos24px,
    arrowDownward24px,
    arrowDropDown24px,
    arrowDropDownCircle24px,
    arrowDropUp24px,
    arrowForward24px,
    arrowForwardIos24px,
    arrowLeft24px,
    arrowRight24px,
    arrowUpward24px,
    cancel24px,
    check24px,
    checkBox24px,
    checkBoxOutlineBlank24px,
    chevronLeft24px,
    chevronRight24px,
    close24px,
    expandLess24px,
    expandMore24px,
    firstPage24px,
    fullscreen24px,
    fullscreenExit24px,
    indeterminateCheckBox24px,
    lastPage24px,
    menu24px,
    moreHoriz24px,
    moreVert24px,
    radioButtonChecked24px,
    radioButtonUnchecked24px,
    refresh24px,
    star24px,
    starBorder24px,
    starBorderPurple50024px,
    starHalf24px,
    starOutline24px,
    starPurple50024px,
    subdirectoryArrowLeft24px,
    subdirectoryArrowRight24px,
    toggleOff24px,
    toggleOn24px,
    unfoldLess24px,
    unfoldMore24px,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
