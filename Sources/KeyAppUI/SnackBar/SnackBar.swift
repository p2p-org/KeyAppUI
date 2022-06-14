import BEPureLayout
import Foundation
import UIKit

protocol SnackBarManagerDelegate {
    func snackBarDidDismiss()
}

fileprivate class SnackBarManager: SnackBarManagerDelegate {
    
    static let shared = SnackBarManager()
    
    private init() {}
    
    var queue = SynchronizedArray<SnackBarViewController>()
    
    var isPresenting = false
    
    // MARK: - SnackBarManagerDelegate
    
    func snackBarDidDismiss() {
        isPresenting = false
    }
    
    func present(_ vc: SnackBarViewController) {
        queue.append(vc)
        present()
    }
    
    func present() {
        guard !isPresenting, let snackBarViewController = self.queue.first() else { return }
        isPresenting = true
        snackBarViewController.presenter?.present(snackBarViewController, animated: true)
    }
    
    func dismiss() {
        guard isPresenting, let first = self.queue.first() else { return }
        _ = queue.removeFirst()
        first.dismiss(animated: true) { [weak self] in
            self?.isPresenting = false
            self?.present()
        }
    }
    
}

public class SnackBar {
    
    public func show(in presentingViewController: UIViewController) {
        snackBarViewController.presenter = presentingViewController
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
        SnackBarManager.shared.dismiss()
    }
    
}

public class SnackBarPresentation: UIPresentationController {
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView,
            let presentedView = presentedView else { return .zero }
        let inset: CGFloat = 16

        // Make sure to account for the safe area insets
        let safeAreaFrame = containerView.bounds
            .inset(by: containerView.safeAreaInsets)

        let targetWidth = safeAreaFrame.width - 2 * inset
        let fittingSize = CGSize(
            width: targetWidth,
            height: UIView.layoutFittingCompressedSize.height
        )
        let targetHeight = presentedView.systemLayoutSizeFitting(
            fittingSize, withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow).height

        var frame = safeAreaFrame
        frame.origin.x += inset
        frame.origin.y += inset
        frame.size.width = targetWidth
        frame.size.height = targetHeight
        return frame
    }
    
//    public override func presentationTransitionWillBegin() {
//        guard let presentedView = presentedView else { return }
////        presentedView.alpha = 0
////
//        containerView?.addSubview(presentedView)
////
////        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
////            self.presentedView?.alpha = 1.0
////        })
//
//        super.presentationTransitionWillBegin()
//    }
    
//    public override var presentedView: UIView? {
//        super.presentedView?.frame = frameOfPresentedViewInContainerView
//        return super.presentedView
//    }
//
//
//    public override func containerViewDidLayoutSubviews() {
//        super.containerViewDidLayoutSubviews()
//        presentedView?.frame = frameOfPresentedViewInContainerView
//    }
    
    

    private var calculatedFrameOfPresentedViewInContainerView = CGRect.zero
    private var shouldSetFrameWhenAccessingPresentedView = false

    public override var presentedView: UIView? {
     if shouldSetFrameWhenAccessingPresentedView {
         super.presentedView?.frame = calculatedFrameOfPresentedViewInContainerView
     }

     return super.presentedView
    }

    public override func presentationTransitionDidEnd(_ completed: Bool) {
     super.presentationTransitionDidEnd(completed)
     shouldSetFrameWhenAccessingPresentedView = completed
    }

    public override func dismissalTransitionWillBegin() {
     super.dismissalTransitionWillBegin()
     shouldSetFrameWhenAccessingPresentedView = false
    }

    public override func containerViewDidLayoutSubviews() {
     super.containerViewDidLayoutSubviews()
     calculatedFrameOfPresentedViewInContainerView = frameOfPresentedViewInContainerView
    }

}

public class SnackBarViewController: UIViewController {
    
    let icon: UIImage
    let text: String
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    fileprivate weak var presenter: UIViewController?
    
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
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.view.frame)
    }
}

public class SnackBarView: UIView {
    
    /// Structure describing
    struct Appearance {
        var textFontSize: CGFloat
        var textFontWeight: UIFont.Weight
        var textFont: UIFont
        var textColor: UIColor
        var buttonTitleFontSize: CGFloat
        var buttonTitleFontWeight: UIFont.Weight
        var buttonTitleTextColor: UIColor
        var cornerRadius: CGFloat = 13
        var backgroundColor: UIColor = .init(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
        var borderColor: UIColor = .init(red: 1, green: 1, blue: 1, alpha: 0.2)
        var buttonBackgroundColor: UIColor = .clear
        var numberOnLines = 2
    }

    private let container = UIStackView(axis: .horizontal)
    private var buttonAction: (() -> Void)?

    var appearance = Appearance(
        textFontSize: 15.0,
        textFontWeight: .regular,
        textFont: .systemFont(ofSize: 15.0),
        textColor: .white,
        buttonTitleFontSize: 14.0,
        buttonTitleFontWeight: .bold,
        buttonTitleTextColor: UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
    )

    init() {
        super.init(frame: .zero)

        container.layer.cornerRadius = appearance.cornerRadius
        addSubview(container)
        container.autoPinEdgesToSuperviewEdges()
        container.backgroundColor = appearance.backgroundColor
        container.border(
            width: 1,
            color: appearance.borderColor
        )
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    public convenience init(icon: UIImage, text: String, buttonTitle: String? = nil, buttonAction: (() -> Void)? = nil) {
        self.init()
        self.buttonAction = buttonAction

        let icon = UIImageView(width: 24, height: 24, image: icon)
            .padding(.init(top: 16, left: 20, bottom: 16, right: 15))
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true

        var label: UIView = makeLabel(text: text)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label = label.padding(.init(top: 12, left: 0, bottom: 12, right: 0))

        var button: UIView?
        if let buttonTitle = buttonTitle, let _ = buttonAction {
            button = makeButton(title: buttonTitle)
                .setTarget(target: self, action: #selector(actionSelector), for: .touchDown)
                .padding(.init(only: .right, inset: 12))
            button?.setContentHuggingPriority(.defaultLow, for: .horizontal)
            button?.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        commonInit(leftView: icon, centerView: label, rightView: button)
    }

    private func commonInit(leftView: UIView, centerView: UIView, rightView: UIView?) {
        var arrangeViews = [leftView]

        if let rightView = rightView {
            arrangeViews.append(UIView())
            arrangeViews.append(centerView)
            arrangeViews.append(UIView())
            arrangeViews.append(rightView)
        } else {
            arrangeViews.append(centerView)
            arrangeViews.append(UIView())
        }
        container.addArrangedSubviews(arrangeViews)
    }
    
    // MARK: -
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel(
            text: text,
            textSize: appearance.textFontSize,
            weight: appearance.textFontWeight,
            numberOfLines: appearance.numberOnLines,
            textAlignment: .left
        )
        label.textColor = appearance.textColor
        return label
    }

    private func makeButton(title: String) -> UIButton {
        UIButton(
            backgroundColor: appearance.buttonBackgroundColor,
            label: title,
            labelFont: UIFont.systemFont(
                ofSize: appearance.buttonTitleFontSize,
                weight: appearance.buttonTitleFontWeight
            ),
            textColor: appearance.buttonTitleTextColor,
            contentInsets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func actionSelector() {
        buttonAction?()
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
////        print(self.frame)
//    }
}

class SlideDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// Wether its showing or dismissing
    private var showing = true
    
    init(show: Bool = true) {
        self.showing = show
    }
    
    func transitionDuration(
      using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
      return 0.3
    }

    func animateTransition(
      using transitionContext: UIViewControllerContextTransitioning
    ) {
        let key: UITransitionContextViewControllerKey = showing ? .to : .from
        guard let controller = transitionContext.viewController(forKey: key)
          else { return }
          
        // 2
        if showing {
          transitionContext.containerView.addSubview(controller.view)
        }

        // 3
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = -presentedFrame.height
          
        // 4
        let initialFrame = showing ? dismissedFrame : presentedFrame
        let finalFrame = showing ? presentedFrame : dismissedFrame
          
        // 5
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        // TODO: Add spring animation
        UIView.animate(
          withDuration: animationDuration,
          animations: {
            controller.view.frame = finalFrame
//              transitionContext.containerView.ges
        }, completion: { finished in
            if !self.showing {
                controller.view.removeFromSuperview()
            } else {
//                transitionContext.containerView.removeFromSuperview()
            }
            transitionContext.completeTransition(finished)
        })
    }
    func animationEnded(_ transitionCompleted: Bool) {

    }
}

// TODO: Move to separate helper file

public class SynchronizedArray<T> {
    private var array: [T] = []
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)

    public func append(_ newElement: T) {
        accessQueue.async(qos: .default, flags: .barrier) {
            self.array.append(newElement)
        }
    }

    public func remove(at index: Int) {
        accessQueue.async(qos: .default, flags: .barrier) {
            self.array.remove(at: index)
        }
    }
    
    public func removeFirst() -> T? {
        var el: T?
        accessQueue.async(qos: .default, flags: .barrier) {
            let index = 0
            guard self.array.count > index else { return }
            el = self.array[index]
            self.array.remove(at: index)
        }
        return el
    }

    public var count: Int {
        var count = 0
        accessQueue.sync {
            count = self.array.count
        }
        return count
    }

    public func first() -> T? {
        var element: T?
        accessQueue.sync {
            if !self.array.isEmpty {
                element = self.array[0]
            }
        }

        return element
    }

    public subscript(index: Int) -> T {
        set {
            accessQueue.async(qos: .default, flags: .barrier) {
                self.array[index] = newValue
            }
        }
        get {
            var element: T!

            accessQueue.sync {
                element = self.array[index]
            }

            return element
        }
    }
}
