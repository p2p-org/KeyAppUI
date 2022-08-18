import UIKit

public class SnackBarPresentation: UIPresentationController {
    
    private var calculatedFrameOfPresentedViewInContainerView = CGRect.zero
    private var shouldSetFrameWhenAccessingPresentedView = false
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard
            let containerView = containerView,
            let presentedView = presentedView else { return .zero }
        let inset: CGFloat = 4

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
    
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.frame = frameOfPresentedViewInContainerView
    }

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
