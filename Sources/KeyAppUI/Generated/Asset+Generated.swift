// swiftlint:disable all
/// Attention: Changes made to this file will not have any effect and will be reverted 
/// when building the project. Please adjust the Stencil template `asset_extensions.stencil` instead.
/// See https://github.com/SwiftGen/SwiftGen#bundled-templates-vs-custom-ones for more information.

import UIKit

// MARK: - Private Helper -

private final class BundleToken {}
private let bundle = Bundle(for: BundleToken.self)

// MARK: - Colors -

extension UIColor {
    static let cloud = UIColor(named: "Cloud", in: bundle, compatibleWith: nil)!
    static let lime = UIColor(named: "Lime", in: bundle, compatibleWith: nil)!
    static let mint = UIColor(named: "Mint", in: bundle, compatibleWith: nil)!
    static let mountain = UIColor(named: "Mountain", in: bundle, compatibleWith: nil)!
    static let night = UIColor(named: "Night", in: bundle, compatibleWith: nil)!
    static let rain = UIColor(named: "Rain", in: bundle, compatibleWith: nil)!
    static let rose = UIColor(named: "Rose", in: bundle, compatibleWith: nil)!
    static let sky = UIColor(named: "Sky", in: bundle, compatibleWith: nil)!
    static let smoke = UIColor(named: "Smoke", in: bundle, compatibleWith: nil)!
    static let snow = UIColor(named: "Snow", in: bundle, compatibleWith: nil)!
    static let sun = UIColor(named: "Sun", in: bundle, compatibleWith: nil)!
}

// MARK: - Images -

extension UIImage {
    static let send = UIImage(named: "send", in: bundle, compatibleWith: nil)!
    static let add = UIImage(named: "add", in: bundle, compatibleWith: nil)!
    static let addBox = UIImage(named: "add_box", in: bundle, compatibleWith: nil)!
    static let addCircle = UIImage(named: "add_circle", in: bundle, compatibleWith: nil)!
    static let addCircleOutline = UIImage(named: "add_circle_outline", in: bundle, compatibleWith: nil)!
    static let appleLogo = UIImage(named: "apple_logo", in: bundle, compatibleWith: nil)!
    static let apps = UIImage(named: "apps", in: bundle, compatibleWith: nil)!
    static let archive = UIImage(named: "archive", in: bundle, compatibleWith: nil)!
    static let arrowBack = UIImage(named: "arrow_back", in: bundle, compatibleWith: nil)!
    static let arrowBackIos = UIImage(named: "arrow_back_ios", in: bundle, compatibleWith: nil)!
    static let arrowDownward = UIImage(named: "arrow_downward", in: bundle, compatibleWith: nil)!
    static let arrowDropDown = UIImage(named: "arrow_drop_down", in: bundle, compatibleWith: nil)!
    static let arrowDropDownCircle = UIImage(named: "arrow_drop_down_circle", in: bundle, compatibleWith: nil)!
    static let arrowDropUp = UIImage(named: "arrow_drop_up", in: bundle, compatibleWith: nil)!
    static let arrowForward = UIImage(named: "arrow_forward", in: bundle, compatibleWith: nil)!
    static let arrowForwardIos = UIImage(named: "arrow_forward_ios", in: bundle, compatibleWith: nil)!
    static let arrowLeft = UIImage(named: "arrow_left", in: bundle, compatibleWith: nil)!
    static let arrowRight = UIImage(named: "arrow_right", in: bundle, compatibleWith: nil)!
    static let arrowUpward = UIImage(named: "arrow_upward", in: bundle, compatibleWith: nil)!
    static let attribution = UIImage(named: "attribution", in: bundle, compatibleWith: nil)!
    static let backspace = UIImage(named: "backspace", in: bundle, compatibleWith: nil)!
    static let ballot = UIImage(named: "ballot", in: bundle, compatibleWith: nil)!
    static let block = UIImage(named: "block", in: bundle, compatibleWith: nil)!
    static let cancel = UIImage(named: "cancel", in: bundle, compatibleWith: nil)!
    static let check = UIImage(named: "check", in: bundle, compatibleWith: nil)!
    static let chevronLeft = UIImage(named: "chevron_left", in: bundle, compatibleWith: nil)!
    static let chevronRight = UIImage(named: "chevron_right", in: bundle, compatibleWith: nil)!
    static let clear = UIImage(named: "clear", in: bundle, compatibleWith: nil)!
    static let close = UIImage(named: "close", in: bundle, compatibleWith: nil)!
    static let copy = UIImage(named: "copy", in: bundle, compatibleWith: nil)!
    static let create = UIImage(named: "create", in: bundle, compatibleWith: nil)!
    static let cut = UIImage(named: "cut", in: bundle, compatibleWith: nil)!
    static let deleteSweep = UIImage(named: "delete_sweep", in: bundle, compatibleWith: nil)!
    static let drafts = UIImage(named: "drafts", in: bundle, compatibleWith: nil)!
    static let expandLess = UIImage(named: "expand_less", in: bundle, compatibleWith: nil)!
    static let expandMore = UIImage(named: "expand_more", in: bundle, compatibleWith: nil)!
    static let fileCopy = UIImage(named: "file_copy", in: bundle, compatibleWith: nil)!
    static let filterList = UIImage(named: "filter_list", in: bundle, compatibleWith: nil)!
    static let firstPage = UIImage(named: "first_page", in: bundle, compatibleWith: nil)!
    static let flag = UIImage(named: "flag", in: bundle, compatibleWith: nil)!
    static let fontDownload = UIImage(named: "font_download", in: bundle, compatibleWith: nil)!
    static let forward = UIImage(named: "forward", in: bundle, compatibleWith: nil)!
    static let fullscreen = UIImage(named: "fullscreen", in: bundle, compatibleWith: nil)!
    static let fullscreenExit = UIImage(named: "fullscreen_exit", in: bundle, compatibleWith: nil)!
    static let gesture = UIImage(named: "gesture", in: bundle, compatibleWith: nil)!
    static let howToReg = UIImage(named: "how_to_reg", in: bundle, compatibleWith: nil)!
    static let howToVote = UIImage(named: "how_to_vote", in: bundle, compatibleWith: nil)!
    static let inbox = UIImage(named: "inbox", in: bundle, compatibleWith: nil)!
    static let lastPage = UIImage(named: "last_page", in: bundle, compatibleWith: nil)!
    static let link = UIImage(named: "link", in: bundle, compatibleWith: nil)!
    static let linkOff = UIImage(named: "link_off", in: bundle, compatibleWith: nil)!
    static let lowPriority = UIImage(named: "low_priority", in: bundle, compatibleWith: nil)!
    static let mail = UIImage(named: "mail", in: bundle, compatibleWith: nil)!
    static let markunread = UIImage(named: "markunread", in: bundle, compatibleWith: nil)!
    static let menu = UIImage(named: "menu", in: bundle, compatibleWith: nil)!
    static let moreHoriz = UIImage(named: "more_horiz", in: bundle, compatibleWith: nil)!
    static let moreVert = UIImage(named: "more_vert", in: bundle, compatibleWith: nil)!
    static let moveToInbox = UIImage(named: "move_to_inbox", in: bundle, compatibleWith: nil)!
    static let nextWeek = UIImage(named: "next_week", in: bundle, compatibleWith: nil)!
    static let outlinedFlag = UIImage(named: "outlined_flag", in: bundle, compatibleWith: nil)!
    static let paste = UIImage(named: "paste", in: bundle, compatibleWith: nil)!
    static let redo = UIImage(named: "redo", in: bundle, compatibleWith: nil)!
    static let refresh = UIImage(named: "refresh", in: bundle, compatibleWith: nil)!
    static let remove = UIImage(named: "remove", in: bundle, compatibleWith: nil)!
    static let removeCircle = UIImage(named: "remove_circle", in: bundle, compatibleWith: nil)!
    static let removeCircleOutline = UIImage(named: "remove_circle_outline", in: bundle, compatibleWith: nil)!
    static let reply = UIImage(named: "reply", in: bundle, compatibleWith: nil)!
    static let replyAll = UIImage(named: "reply_all", in: bundle, compatibleWith: nil)!
    static let report = UIImage(named: "report", in: bundle, compatibleWith: nil)!
    static let reportGmailerrorred = UIImage(named: "report_gmailerrorred", in: bundle, compatibleWith: nil)!
    static let reportOff = UIImage(named: "report_off", in: bundle, compatibleWith: nil)!
    static let save = UIImage(named: "save", in: bundle, compatibleWith: nil)!
    static let saveAlt = UIImage(named: "save_alt", in: bundle, compatibleWith: nil)!
    static let selectAll = UIImage(named: "select_all", in: bundle, compatibleWith: nil)!
    static let send = UIImage(named: "send", in: bundle, compatibleWith: nil)!
    static let sort = UIImage(named: "sort", in: bundle, compatibleWith: nil)!
    static let subdirectoryArrowLeft = UIImage(named: "subdirectory_arrow_left", in: bundle, compatibleWith: nil)!
    static let subdirectoryArrowRight = UIImage(named: "subdirectory_arrow_right", in: bundle, compatibleWith: nil)!
    static let textFormat = UIImage(named: "text_format", in: bundle, compatibleWith: nil)!
    static let unarchive = UIImage(named: "unarchive", in: bundle, compatibleWith: nil)!
    static let undo = UIImage(named: "undo", in: bundle, compatibleWith: nil)!
    static let unfoldLess = UIImage(named: "unfold_less", in: bundle, compatibleWith: nil)!
    static let unfoldMore = UIImage(named: "unfold_more", in: bundle, compatibleWith: nil)!
    static let waves = UIImage(named: "waves", in: bundle, compatibleWith: nil)!
    static let weekend = UIImage(named: "weekend", in: bundle, compatibleWith: nil)!
    static let whereToVote = UIImage(named: "where_to_vote", in: bundle, compatibleWith: nil)!
}

