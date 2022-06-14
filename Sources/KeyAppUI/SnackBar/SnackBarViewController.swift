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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let barView = SnackBarView(icon: icon, text: text, buttonTitle: buttonTitle, buttonAction: buttonAction)
        view = barView
        
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    var offSet: CGPoint = .zero
    lazy var  verticalConstraint: NSLayoutConstraint = {view.centerYAnchor.constraint(equalTo: view.centerYAnchor)}()
//    horizontalConstraint.isActive = true
//    let verticalConstraint = view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//    verticalConstraint.isActive = true
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {

    }
    
}

extension SnackBarViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        SnackBarPresentation(presentedViewController: presented, presenting: presenting)
    }
    
    public func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController,
      source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
      return SlideDownAnimator(show: true)
    }

    public func animationController(
      forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlideDownAnimator(show: false)
    }
}
