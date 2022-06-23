import BEPureLayout
import Foundation
import UIKit

public class SnackBar {
    private var snackBarViewController: SnackBarViewController

    @discardableResult
    public init(icon: UIImage, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        snackBarViewController = SnackBarViewController(icon: icon, text: text, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }

    /// Show snackbar on top of view controller.
    ///
    /// - Parameters:
    ///   - presentingViewController: a target view controller
    ///   - autoDismiss: user can dismiss the snackbar
    public func show(in presentingViewController: UIViewController, autoDismiss: Bool = true) {
        snackBarViewController.presenter = presentingViewController
        snackBarViewController.autodismiss = autoDismiss
        SnackBarManager.shared.present(snackBarViewController)
    }

    public static func hide(animated _: Bool = true) {
        SnackBarManager.shared.dismissCurrent()
    }
}
