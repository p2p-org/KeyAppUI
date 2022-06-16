import BEPureLayout
import Foundation
import UIKit

public class SnackBar {
    
    public func show(in presentingViewController: UIViewController, autoDismiss: Bool = true) {
        snackBarViewController.presenter = presentingViewController
        snackBarViewController.autodismiss = autoDismiss
        SnackBarManager.shared.present(snackBarViewController)
    }
    
    private var snackBarViewController: SnackBarViewController
    
    @discardableResult
    public init(icon: UIImage, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        snackBarViewController = SnackBarViewController(icon: icon, text: text, buttonTitle: buttonTitle, buttonAction: buttonAction)
    }
    
    public func onTap(_ tap: (SnackBarViewController) -> Void) {
        tap(snackBarViewController)
    }
    
    public static func hide(animated: Bool = true) {
        SnackBarManager.shared.dismissCurrent()
    }
    
}
