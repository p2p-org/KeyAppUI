import BEPureLayout
import Foundation
import UIKit

public class SnackBar {
    private var snackBarViewController: SnackBarViewController

    @discardableResult
    public init(title: String? = nil, icon: UIImage? = nil, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        snackBarViewController = SnackBarViewController(title: title, icon: icon, text: text, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }

    /// Show snackbar on top of view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: a target view controller
    ///   - autoDismiss: user can dismiss the snackbar
    ///   - dismissCompletion: completion called after dismiss
    public func show(in presentingViewController: UIViewController, autoDismiss: Bool = true, dismissCompletion: (() -> Void)? = nil) {
        snackBarViewController.presenter = presentingViewController
        snackBarViewController.autodismiss = autoDismiss
        snackBarViewController.dismissCompletion = dismissCompletion
        SnackBarManager.shared.present(snackBarViewController)
    }

    public static func hide(animated _: Bool = true) {
        SnackBarManager.shared.dismissCurrent()
    }
}
