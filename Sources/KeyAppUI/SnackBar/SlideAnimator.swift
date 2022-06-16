import UIKit

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
        guard let controller = transitionContext.viewController(forKey: key) else { return }
          
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
        controller.view.alpha = showing ? 0.0 : 1.0
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: [.curveLinear, .allowUserInteraction],
            animations: {
            controller.view.frame = finalFrame
            controller.view.alpha = self.showing ? 1.0 : 0.0
        }, completion: { finished in
            if !self.showing {
                controller.view.removeFromSuperview()
            }
            transitionContext.completeTransition(finished)
        })
    }
}
