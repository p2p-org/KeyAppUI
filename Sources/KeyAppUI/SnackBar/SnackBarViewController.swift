import UIKit

public class SnackBarViewController: UIViewController {
    let icon: UIImage
    let text: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    weak var presenter: UIViewController?
    lazy var panGestureRecognizer: PanDirectionGestureRecognizer = {
        let gesture = PanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(handlePanGesture(_:)))
        gesture.cancelsTouchesInView = false
        return gesture
    }()

    var autodismiss = true

    public init(icon: UIImage, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
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
        let barView = SnackBarView(
            icon: icon,
            text: text,
            trailing: TextButton.style(title: text, style: .primary, size: .medium)
        )
        
        view = barView

        view.addGestureRecognizer(panGestureRecognizer)
    }

    var offSet: CGPoint = .zero
    lazy var verticalConstraint: NSLayoutConstraint = view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    horizontalConstraint.isActive = true
//    let verticalConstraint = view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    verticalConstraint.isActive = true

    @objc func handlePanGesture(_: UIPanGestureRecognizer) {}
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
