import UIKit

public class SnackBarViewController: UIViewController {
    let leadingTitle: String?
    let icon: UIImage?
    let text: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    weak var presenter: UIViewController?

    var autodismiss = true

    public init(title: String? = nil, icon: UIImage?, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        self.leadingTitle = title
        self.icon = icon
        self.text = text
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        let button = buttonTitle != nil ? TextButton(title: buttonTitle ?? "", style: .primary, size: .small) : nil
        let snackBar = SnackBarView(
            title: leadingTitle,
            icon: icon,
            text: text,
            trailing: button
        ).onTap(buttonAction ?? {})
        snackBar.appearance.numberOnLines
        snackBar.setNeedsLayout()
        snackBar.layoutIfNeeded()
        view = snackBar
    }
}

extension SnackBarViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source _: UIViewController
    ) -> UIPresentationController? {
        SnackBarPresentation(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(
        forPresented _: UIViewController,
        presenting _: UIViewController,
        source _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlideDownAnimator(show: true)
    }

    public func animationController(
        forDismissed _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlideDownAnimator(show: false)
    }
}
