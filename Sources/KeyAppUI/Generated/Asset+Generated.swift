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
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Colors {
    public static let cloud = ColorAsset(name: "Cloud")
    public static let lime = ColorAsset(name: "Lime")
    public static let mint = ColorAsset(name: "Mint")
    public static let mountain = ColorAsset(name: "Mountain")
    public static let night = ColorAsset(name: "Night")
    public static let rain = ColorAsset(name: "Rain")
    public static let rose = ColorAsset(name: "Rose")
    public static let sky = ColorAsset(name: "Sky")
    public static let smoke = ColorAsset(name: "Smoke")
    public static let snow = ColorAsset(name: "Snow")
    public static let sun = ColorAsset(name: "Sun")
    // swiftlint:disable trailing_comma
    public static let allColors: [ColorAsset] = [
      cloud,
      lime,
      mint,
      mountain,
      night,
      rain,
      rose,
      sky,
      smoke,
      snow,
      sun,
    ]
    public static let allImages: [ImageAsset] = [
    ]
    // swiftlint:enable trailing_comma
  }
  public enum MaterialIcon {
    public static let _3dRotation24px = ImageAsset(name: "3d_rotation_24px")
    public static let accessibility24px = ImageAsset(name: "accessibility_24px")
    public static let accessibilityNew24px = ImageAsset(name: "accessibility_new_24px")
    public static let accessible24px = ImageAsset(name: "accessible_24px")
    public static let accessibleForward24px = ImageAsset(name: "accessible_forward_24px")
    public static let accountBalance24px = ImageAsset(name: "account_balance_24px")
    public static let accountBalanceWallet24px = ImageAsset(name: "account_balance_wallet_24px")
    public static let accountBox24px = ImageAsset(name: "account_box_24px")
    public static let accountCircle24px = ImageAsset(name: "account_circle_24px")
    public static let add24px = ImageAsset(name: "add_24px")
    public static let addShoppingCart24px = ImageAsset(name: "add_shopping_cart_24px")
    public static let alarm24px = ImageAsset(name: "alarm_24px")
    public static let alarmAdd24px = ImageAsset(name: "alarm_add_24px")
    public static let alarmOff24px = ImageAsset(name: "alarm_off_24px")
    public static let alarmOn24px = ImageAsset(name: "alarm_on_24px")
    public static let allInbox24px = ImageAsset(name: "all_inbox_24px")
    public static let allOut24px = ImageAsset(name: "all_out_24px")
    public static let android24px = ImageAsset(name: "android_24px")
    public static let announcement24px = ImageAsset(name: "announcement_24px")
    public static let arrowRightAlt24px = ImageAsset(name: "arrow_right_alt_24px")
    public static let aspectRatio24px = ImageAsset(name: "aspect_ratio_24px")
    public static let assessment24px = ImageAsset(name: "assessment_24px")
    public static let assignment24px = ImageAsset(name: "assignment_24px")
    public static let assignmentInd24px = ImageAsset(name: "assignment_ind_24px")
    public static let assignmentLate24px = ImageAsset(name: "assignment_late_24px")
    public static let assignmentReturn24px = ImageAsset(name: "assignment_return_24px")
    public static let assignmentReturned24px = ImageAsset(name: "assignment_returned_24px")
    public static let assignmentTurnedIn24px = ImageAsset(name: "assignment_turned_in_24px")
    public static let autorenew24px = ImageAsset(name: "autorenew_24px")
    public static let backup24px = ImageAsset(name: "backup_24px")
    public static let book24px = ImageAsset(name: "book_24px")
    public static let bookmark24px = ImageAsset(name: "bookmark_24px")
    public static let bookmarkBorder24px = ImageAsset(name: "bookmark_border_24px")
    public static let bookmarks24px = ImageAsset(name: "bookmarks_24px")
    public static let bugReport24px = ImageAsset(name: "bug_report_24px")
    public static let build24px = ImageAsset(name: "build_24px")
    public static let cached24px = ImageAsset(name: "cached_24px")
    public static let calendarToday24px = ImageAsset(name: "calendar_today_24px")
    public static let calendarViewDay24px = ImageAsset(name: "calendar_view_day_24px")
    public static let cameraEnhance24px = ImageAsset(name: "camera_enhance_24px")
    public static let cardGiftcard24px = ImageAsset(name: "card_giftcard_24px")
    public static let cardMembership24px = ImageAsset(name: "card_membership_24px")
    public static let cardTravel24px = ImageAsset(name: "card_travel_24px")
    public static let changeHistory24px = ImageAsset(name: "change_history_24px")
    public static let checkCircle24px = ImageAsset(name: "check_circle_24px")
    public static let checkCircleOutline24px = ImageAsset(name: "check_circle_outline_24px")
    public static let chromeReaderMode24px = ImageAsset(name: "chrome_reader_mode_24px")
    public static let class24px = ImageAsset(name: "class_24px")
    public static let code24px = ImageAsset(name: "code_24px")
    public static let commute24px = ImageAsset(name: "commute_24px")
    public static let compareArrows24px = ImageAsset(name: "compare_arrows_24px")
    public static let contactSupport24px = ImageAsset(name: "contact_support_24px")
    public static let copyright24px = ImageAsset(name: "copyright_24px")
    public static let creditCard24px = ImageAsset(name: "credit_card_24px")
    public static let dashboard24px = ImageAsset(name: "dashboard_24px")
    public static let dateRange24px = ImageAsset(name: "date_range_24px")
    public static let delete24px = ImageAsset(name: "delete_24px")
    public static let deleteForever24px = ImageAsset(name: "delete_forever_24px")
    public static let deleteOutline24px = ImageAsset(name: "delete_outline_24px")
    public static let description24px = ImageAsset(name: "description_24px")
    public static let dns24px = ImageAsset(name: "dns_24px")
    public static let done24px = ImageAsset(name: "done_24px")
    public static let doneAll24px = ImageAsset(name: "done_all_24px")
    public static let doneOutline24px = ImageAsset(name: "done_outline_24px")
    public static let donutLarge24px = ImageAsset(name: "donut_large_24px")
    public static let donutSmall24px = ImageAsset(name: "donut_small_24px")
    public static let dragIndicator24px = ImageAsset(name: "drag_indicator_24px")
    public static let eject24px = ImageAsset(name: "eject_24px")
    public static let error24px = ImageAsset(name: "error_24px")
    public static let errorOutline24px = ImageAsset(name: "error_outline_24px")
    public static let euroSymbol24px = ImageAsset(name: "euro_symbol_24px")
    public static let event24px = ImageAsset(name: "event_24px")
    public static let eventSeat24px = ImageAsset(name: "event_seat_24px")
    public static let exitToApp24px = ImageAsset(name: "exit_to_app_24px")
    public static let explore24px = ImageAsset(name: "explore_24px")
    public static let exploreOff24px = ImageAsset(name: "explore_off_24px")
    public static let extension24px = ImageAsset(name: "extension_24px")
    public static let face24px = ImageAsset(name: "face_24px")
    public static let faceUnlock24px = ImageAsset(name: "face_unlock_24px")
    public static let favorite24px = ImageAsset(name: "favorite_24px")
    public static let favoriteBorder24px = ImageAsset(name: "favorite_border_24px")
    public static let feedback24px = ImageAsset(name: "feedback_24px")
    public static let findInPage24px = ImageAsset(name: "find_in_page_24px")
    public static let findReplace24px = ImageAsset(name: "find_replace_24px")
    public static let fingerprint24px = ImageAsset(name: "fingerprint_24px")
    public static let flightLand24px = ImageAsset(name: "flight_land_24px")
    public static let flightTakeoff24px = ImageAsset(name: "flight_takeoff_24px")
    public static let flipToBack24px = ImageAsset(name: "flip_to_back_24px")
    public static let flipToFront24px = ImageAsset(name: "flip_to_front_24px")
    public static let gTranslate24px = ImageAsset(name: "g_translate_24px")
    public static let gavel24px = ImageAsset(name: "gavel_24px")
    public static let getApp24px = ImageAsset(name: "get_app_24px")
    public static let gif24px = ImageAsset(name: "gif_24px")
    public static let grade24px = ImageAsset(name: "grade_24px")
    public static let groupWork24px = ImageAsset(name: "group_work_24px")
    public static let help24px = ImageAsset(name: "help_24px")
    public static let helpOutline24px = ImageAsset(name: "help_outline_24px")
    public static let highlightOff24px = ImageAsset(name: "highlight_off_24px")
    public static let history24px = ImageAsset(name: "history_24px")
    public static let home24px = ImageAsset(name: "home_24px")
    public static let horizontalSplit24px = ImageAsset(name: "horizontal_split_24px")
    public static let hourglassEmpty24px = ImageAsset(name: "hourglass_empty_24px")
    public static let hourglassFull24px = ImageAsset(name: "hourglass_full_24px")
    public static let http24px = ImageAsset(name: "http_24px")
    public static let https24px = ImageAsset(name: "https_24px")
    public static let importantDevices24px = ImageAsset(name: "important_devices_24px")
    public static let info24px2 = ImageAsset(name: "info_24px 2")
    public static let info24px = ImageAsset(name: "info_24px")
    public static let input24px = ImageAsset(name: "input_24px")
    public static let invertColors24px = ImageAsset(name: "invert_colors_24px")
    public static let label24px2 = ImageAsset(name: "label_24px 2")
    public static let label24px = ImageAsset(name: "label_24px")
    public static let labelImportant24px2 = ImageAsset(name: "label_important_24px 2")
    public static let labelImportant24px = ImageAsset(name: "label_important_24px")
    public static let labelOff24px = ImageAsset(name: "label_off_24px")
    public static let language24px = ImageAsset(name: "language_24px")
    public static let launch24px = ImageAsset(name: "launch_24px")
    public static let lightbulb24px = ImageAsset(name: "lightbulb_24px")
    public static let lineStyle24px = ImageAsset(name: "line_style_24px")
    public static let lineWeight24px = ImageAsset(name: "line_weight_24px")
    public static let list24px = ImageAsset(name: "list_24px")
    public static let lock24px2 = ImageAsset(name: "lock_24px 2")
    public static let lock24px = ImageAsset(name: "lock_24px")
    public static let lockOpen24px = ImageAsset(name: "lock_open_24px")
    public static let loyalty24px = ImageAsset(name: "loyalty_24px")
    public static let markunreadMailbox24px = ImageAsset(name: "markunread_mailbox_24px")
    public static let maximize24px = ImageAsset(name: "maximize_24px")
    public static let minimize24px = ImageAsset(name: "minimize_24px")
    public static let motorcycle24px = ImageAsset(name: "motorcycle_24px")
    public static let noteAdd24px = ImageAsset(name: "note_add_24px")
    public static let notificationImportant24px = ImageAsset(name: "notification_important_24px")
    public static let offlineBolt24px = ImageAsset(name: "offline_bolt_24px")
    public static let offlinePin24px = ImageAsset(name: "offline_pin_24px")
    public static let opacity24px = ImageAsset(name: "opacity_24px")
    public static let openInBrowser24px = ImageAsset(name: "open_in_browser_24px")
    public static let openInNew24px = ImageAsset(name: "open_in_new_24px")
    public static let openWith24px = ImageAsset(name: "open_with_24px")
    public static let pageview24px = ImageAsset(name: "pageview_24px")
    public static let panTool24px = ImageAsset(name: "pan_tool_24px")
    public static let payment24px = ImageAsset(name: "payment_24px")
    public static let permCameraMic24px = ImageAsset(name: "perm_camera_mic_24px")
    public static let permContactCalendar24px = ImageAsset(name: "perm_contact_calendar_24px")
    public static let permDataSetting24px = ImageAsset(name: "perm_data_setting_24px")
    public static let permDeviceInformation24px = ImageAsset(name: "perm_device_information_24px")
    public static let permIdentity24px = ImageAsset(name: "perm_identity_24px")
    public static let permMedia24px = ImageAsset(name: "perm_media_24px")
    public static let permPhoneMsg24px = ImageAsset(name: "perm_phone_msg_24px")
    public static let permScanWifi24px = ImageAsset(name: "perm_scan_wifi_24px")
    public static let pets24px = ImageAsset(name: "pets_24px")
    public static let pictureInPicture24px = ImageAsset(name: "picture_in_picture_24px")
    public static let pictureInPictureAlt24px = ImageAsset(name: "picture_in_picture_alt_24px")
    public static let playForWork24px = ImageAsset(name: "play_for_work_24px")
    public static let polymer24px = ImageAsset(name: "polymer_24px")
    public static let powerSettingsNew24px = ImageAsset(name: "power_settings_new_24px")
    public static let pregnantWoman24px = ImageAsset(name: "pregnant_woman_24px")
    public static let print24px = ImageAsset(name: "print_24px")
    public static let queryBuilder24px = ImageAsset(name: "query_builder_24px")
    public static let questionAnswer24px = ImageAsset(name: "question_answer_24px")
    public static let receipt24px = ImageAsset(name: "receipt_24px")
    public static let recordVoiceOver24px = ImageAsset(name: "record_voice_over_24px")
    public static let redeem24px = ImageAsset(name: "redeem_24px")
    public static let removeShoppingCart24px = ImageAsset(name: "remove_shopping_cart_24px")
    public static let reorder24px = ImageAsset(name: "reorder_24px")
    public static let reportProblem24px = ImageAsset(name: "report_problem_24px")
    public static let restore24px = ImageAsset(name: "restore_24px")
    public static let restoreFromTrash24px = ImageAsset(name: "restore_from_trash_24px")
    public static let restorePage24px = ImageAsset(name: "restore_page_24px")
    public static let room24px = ImageAsset(name: "room_24px")
    public static let roundedCorner24px = ImageAsset(name: "rounded_corner_24px")
    public static let rowing24px = ImageAsset(name: "rowing_24px")
    public static let schedule24px = ImageAsset(name: "schedule_24px")
    public static let search24px = ImageAsset(name: "search_24px")
    public static let settings24px = ImageAsset(name: "settings_24px")
    public static let settingsApplications24px = ImageAsset(name: "settings_applications_24px")
    public static let settingsBackupRestore24px = ImageAsset(name: "settings_backup_restore_24px")
    public static let settingsBluetooth24px = ImageAsset(name: "settings_bluetooth_24px")
    public static let settingsBrightness24px = ImageAsset(name: "settings_brightness_24px")
    public static let settingsCell24px = ImageAsset(name: "settings_cell_24px")
    public static let settingsEthernet24px = ImageAsset(name: "settings_ethernet_24px")
    public static let settingsInputAntenna24px = ImageAsset(name: "settings_input_antenna_24px")
    public static let settingsInputComponent24px = ImageAsset(name: "settings_input_component_24px")
    public static let settingsInputComposite24px = ImageAsset(name: "settings_input_composite_24px")
    public static let settingsInputHdmi24px = ImageAsset(name: "settings_input_hdmi_24px")
    public static let settingsInputSvideo24px = ImageAsset(name: "settings_input_svideo_24px")
    public static let settingsOverscan24px = ImageAsset(name: "settings_overscan_24px")
    public static let settingsPhone24px = ImageAsset(name: "settings_phone_24px")
    public static let settingsPower24px = ImageAsset(name: "settings_power_24px")
    public static let settingsRemote24px = ImageAsset(name: "settings_remote_24px")
    public static let settingsVoice24px = ImageAsset(name: "settings_voice_24px")
    public static let shop24px = ImageAsset(name: "shop_24px")
    public static let shopTwo24px = ImageAsset(name: "shop_two_24px")
    public static let shoppingBasket24px = ImageAsset(name: "shopping_basket_24px")
    public static let shoppingCart24px = ImageAsset(name: "shopping_cart_24px")
    public static let speakerNotes24px = ImageAsset(name: "speaker_notes_24px")
    public static let speakerNotesOff24px = ImageAsset(name: "speaker_notes_off_24px")
    public static let spellcheck24px = ImageAsset(name: "spellcheck_24px")
    public static let starRate18px = ImageAsset(name: "star_rate_18px")
    public static let stars24px = ImageAsset(name: "stars_24px")
    public static let store24px = ImageAsset(name: "store_24px")
    public static let subject24px = ImageAsset(name: "subject_24px")
    public static let supervisedUserCircle24px = ImageAsset(name: "supervised_user_circle_24px")
    public static let supervisorAccount24px = ImageAsset(name: "supervisor_account_24px")
    public static let swapHoriz24px = ImageAsset(name: "swap_horiz_24px")
    public static let swapHorizontalCircle24px = ImageAsset(name: "swap_horizontal_circle_24px")
    public static let swapVert24px = ImageAsset(name: "swap_vert_24px")
    public static let swapVerticalCircle24px = ImageAsset(name: "swap_vertical_circle_24px")
    public static let systemVerticalAlt24px = ImageAsset(name: "system_vertical_alt_24px")
    public static let tab24px = ImageAsset(name: "tab_24px")
    public static let tabUnselected24px = ImageAsset(name: "tab_unselected_24px")
    public static let textRotateUp24px = ImageAsset(name: "text_rotate_up_24px")
    public static let textRotateVertical24px = ImageAsset(name: "text_rotate_vertical_24px")
    public static let textRotationAngleDown24px = ImageAsset(name: "text_rotation_angle_down_24px")
    public static let textRotationAngleUp24px = ImageAsset(name: "text_rotation_angle_up_24px")
    public static let textRotationDown24px = ImageAsset(name: "text_rotation_down_24px")
    public static let textRotationNone24px = ImageAsset(name: "text_rotation_none_24px")
    public static let theaters24px = ImageAsset(name: "theaters_24px")
    public static let thumbDown24px = ImageAsset(name: "thumb_down_24px")
    public static let thumbUp24px = ImageAsset(name: "thumb_up_24px")
    public static let thumbsUpDown24px = ImageAsset(name: "thumbs_up_down_24px")
    public static let timeline24px = ImageAsset(name: "timeline_24px")
    public static let toc24px = ImageAsset(name: "toc_24px")
    public static let today24px = ImageAsset(name: "today_24px")
    public static let toll24px = ImageAsset(name: "toll_24px")
    public static let touchApp24px = ImageAsset(name: "touch_app_24px")
    public static let trackChanges24px = ImageAsset(name: "track_changes_24px")
    public static let translate24px = ImageAsset(name: "translate_24px")
    public static let trendingDown24px = ImageAsset(name: "trending_down_24px")
    public static let trendingFlat24px = ImageAsset(name: "trending_flat_24px")
    public static let trendingUp24px = ImageAsset(name: "trending_up_24px")
    public static let turnedIn24px = ImageAsset(name: "turned_in_24px")
    public static let turnedInNot24px = ImageAsset(name: "turned_in_not_24px")
    public static let update24px = ImageAsset(name: "update_24px")
    public static let verifiedUser24px = ImageAsset(name: "verified_user_24px")
    public static let verticalSplit24px = ImageAsset(name: "vertical_split_24px")
    public static let viewAgenda24px = ImageAsset(name: "view_agenda_24px")
    public static let viewArray24px = ImageAsset(name: "view_array_24px")
    public static let viewCarousel24px = ImageAsset(name: "view_carousel_24px")
    public static let viewColumn24px = ImageAsset(name: "view_column_24px")
    public static let viewDay24px = ImageAsset(name: "view_day_24px")
    public static let viewHeadline24px = ImageAsset(name: "view_headline_24px")
    public static let viewList24px = ImageAsset(name: "view_list_24px")
    public static let viewModule24px = ImageAsset(name: "view_module_24px")
    public static let viewQuilt24px = ImageAsset(name: "view_quilt_24px")
    public static let viewStream24px = ImageAsset(name: "view_stream_24px")
    public static let viewWeek24px = ImageAsset(name: "view_week_24px")
    public static let visibility24px = ImageAsset(name: "visibility_24px")
    public static let visibilityOff24px = ImageAsset(name: "visibility_off_24px")
    public static let voiceOverOff24px = ImageAsset(name: "voice_over_off_24px")
    public static let warning24px = ImageAsset(name: "warning_24px")
    public static let warningAmber24px = ImageAsset(name: "warning_amber_24px")
    public static let watchLater24px = ImageAsset(name: "watch_later_24px")
    public static let work24px = ImageAsset(name: "work_24px")
    public static let workOff24px = ImageAsset(name: "work_off_24px")
    public static let workOutline24px = ImageAsset(name: "work_outline_24px")
    public static let youtubeSearchedFor24px = ImageAsset(name: "youtube_searched_for_24px")
    public static let zoomIn24px = ImageAsset(name: "zoom_in_24px")
    public static let zoomOut24px = ImageAsset(name: "zoom_out_24px")
    // swiftlint:disable trailing_comma
    public static let allColors: [ColorAsset] = [
    ]
    public static let allImages: [ImageAsset] = [
      _3dRotation24px,
      accessibility24px,
      accessibilityNew24px,
      accessible24px,
      accessibleForward24px,
      accountBalance24px,
      accountBalanceWallet24px,
      accountBox24px,
      accountCircle24px,
      add24px,
      addShoppingCart24px,
      alarm24px,
      alarmAdd24px,
      alarmOff24px,
      alarmOn24px,
      allInbox24px,
      allOut24px,
      android24px,
      announcement24px,
      arrowRightAlt24px,
      aspectRatio24px,
      assessment24px,
      assignment24px,
      assignmentInd24px,
      assignmentLate24px,
      assignmentReturn24px,
      assignmentReturned24px,
      assignmentTurnedIn24px,
      autorenew24px,
      backup24px,
      book24px,
      bookmark24px,
      bookmarkBorder24px,
      bookmarks24px,
      bugReport24px,
      build24px,
      cached24px,
      calendarToday24px,
      calendarViewDay24px,
      cameraEnhance24px,
      cardGiftcard24px,
      cardMembership24px,
      cardTravel24px,
      changeHistory24px,
      checkCircle24px,
      checkCircleOutline24px,
      chromeReaderMode24px,
      class24px,
      code24px,
      commute24px,
      compareArrows24px,
      contactSupport24px,
      copyright24px,
      creditCard24px,
      dashboard24px,
      dateRange24px,
      delete24px,
      deleteForever24px,
      deleteOutline24px,
      description24px,
      dns24px,
      done24px,
      doneAll24px,
      doneOutline24px,
      donutLarge24px,
      donutSmall24px,
      dragIndicator24px,
      eject24px,
      error24px,
      errorOutline24px,
      euroSymbol24px,
      event24px,
      eventSeat24px,
      exitToApp24px,
      explore24px,
      exploreOff24px,
      extension24px,
      face24px,
      faceUnlock24px,
      favorite24px,
      favoriteBorder24px,
      feedback24px,
      findInPage24px,
      findReplace24px,
      fingerprint24px,
      flightLand24px,
      flightTakeoff24px,
      flipToBack24px,
      flipToFront24px,
      gTranslate24px,
      gavel24px,
      getApp24px,
      gif24px,
      grade24px,
      groupWork24px,
      help24px,
      helpOutline24px,
      highlightOff24px,
      history24px,
      home24px,
      horizontalSplit24px,
      hourglassEmpty24px,
      hourglassFull24px,
      http24px,
      https24px,
      importantDevices24px,
      info24px2,
      info24px,
      input24px,
      invertColors24px,
      label24px2,
      label24px,
      labelImportant24px2,
      labelImportant24px,
      labelOff24px,
      language24px,
      launch24px,
      lightbulb24px,
      lineStyle24px,
      lineWeight24px,
      list24px,
      lock24px2,
      lock24px,
      lockOpen24px,
      loyalty24px,
      markunreadMailbox24px,
      maximize24px,
      minimize24px,
      motorcycle24px,
      noteAdd24px,
      notificationImportant24px,
      offlineBolt24px,
      offlinePin24px,
      opacity24px,
      openInBrowser24px,
      openInNew24px,
      openWith24px,
      pageview24px,
      panTool24px,
      payment24px,
      permCameraMic24px,
      permContactCalendar24px,
      permDataSetting24px,
      permDeviceInformation24px,
      permIdentity24px,
      permMedia24px,
      permPhoneMsg24px,
      permScanWifi24px,
      pets24px,
      pictureInPicture24px,
      pictureInPictureAlt24px,
      playForWork24px,
      polymer24px,
      powerSettingsNew24px,
      pregnantWoman24px,
      print24px,
      queryBuilder24px,
      questionAnswer24px,
      receipt24px,
      recordVoiceOver24px,
      redeem24px,
      removeShoppingCart24px,
      reorder24px,
      reportProblem24px,
      restore24px,
      restoreFromTrash24px,
      restorePage24px,
      room24px,
      roundedCorner24px,
      rowing24px,
      schedule24px,
      search24px,
      settings24px,
      settingsApplications24px,
      settingsBackupRestore24px,
      settingsBluetooth24px,
      settingsBrightness24px,
      settingsCell24px,
      settingsEthernet24px,
      settingsInputAntenna24px,
      settingsInputComponent24px,
      settingsInputComposite24px,
      settingsInputHdmi24px,
      settingsInputSvideo24px,
      settingsOverscan24px,
      settingsPhone24px,
      settingsPower24px,
      settingsRemote24px,
      settingsVoice24px,
      shop24px,
      shopTwo24px,
      shoppingBasket24px,
      shoppingCart24px,
      speakerNotes24px,
      speakerNotesOff24px,
      spellcheck24px,
      starRate18px,
      stars24px,
      store24px,
      subject24px,
      supervisedUserCircle24px,
      supervisorAccount24px,
      swapHoriz24px,
      swapHorizontalCircle24px,
      swapVert24px,
      swapVerticalCircle24px,
      systemVerticalAlt24px,
      tab24px,
      tabUnselected24px,
      textRotateUp24px,
      textRotateVertical24px,
      textRotationAngleDown24px,
      textRotationAngleUp24px,
      textRotationDown24px,
      textRotationNone24px,
      theaters24px,
      thumbDown24px,
      thumbUp24px,
      thumbsUpDown24px,
      timeline24px,
      toc24px,
      today24px,
      toll24px,
      touchApp24px,
      trackChanges24px,
      translate24px,
      trendingDown24px,
      trendingFlat24px,
      trendingUp24px,
      turnedIn24px,
      turnedInNot24px,
      update24px,
      verifiedUser24px,
      verticalSplit24px,
      viewAgenda24px,
      viewArray24px,
      viewCarousel24px,
      viewColumn24px,
      viewDay24px,
      viewHeadline24px,
      viewList24px,
      viewModule24px,
      viewQuilt24px,
      viewStream24px,
      viewWeek24px,
      visibility24px,
      visibilityOff24px,
      voiceOverOff24px,
      warning24px,
      warningAmber24px,
      watchLater24px,
      work24px,
      workOff24px,
      workOutline24px,
      youtubeSearchedFor24px,
      zoomIn24px,
      zoomOut24px,
    ]
    // swiftlint:enable trailing_comma
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

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
