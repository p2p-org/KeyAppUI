import BEPureLayout
import Foundation
import UIKit

extension SnackBar {
    @discardableResult
    convenience init(title: String? = nil, icon: UIImage? = nil, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        let button = buttonTitle != nil ? TextButton(title: buttonTitle ?? "", style: .primary, size: .small) : nil
        self.init(title: title, icon: icon, text: text, trailing: button)
    }
    
    /// Show snackbar on top of view controller.
    ///
    /// - Parameters:
    ///   - view: a target view controller
    ///   - autoDismiss: user can dismiss the snackbar
    ///   - dismissCompletion: completion called after dismiss
    public func show(in view: UIView, autoDismiss: Bool = true, dismissCompletion: (() -> Void)? = nil) {
        view.addSubview(self)
        autoPinEdgesToSuperviewEdges()
        snackBarViewController.presenter = view
        snackBarViewController.autodismiss = autoDismiss
        snackBarViewController.dismissCompletion = dismissCompletion
        SnackBarManager.shared.present(snackBarViewController)
    }

    public static func hide(animated _: Bool = true) {
        SnackBarManager.shared.dismissCurrent()
    }
}
