import UIKit

protocol SnackBarManagerDelegate {
    func snackBarDidDismiss()
}

public class SnackBarManager: SnackBarManagerDelegate {
    
    static public let shared = SnackBarManager()
    
    public var behavior: SnackBarBehavior = .dismissOldWhenAddingNew
    
    private var queue = SynchronizedArray<SnackBarViewController>()
    
    private var isPresenting = false
    
    private init() {}
    
    // MARK: - SnackBarManagerDelegate
    
    func snackBarDidDismiss() {
        isPresenting = false
    }
    
    func present(_ vc: SnackBarViewController) {
        queue.append(vc)
        present()
    }
    
    func present() {
        guard let snackBarViewController = self.queue.first() else { return }
        
        if isPresenting && behavior == .dismissOldWhenAddingNew {
            // dismiss old snackbar silently
            dismiss(vc: snackBarViewController, delayNext: 300)
            return
        }
        
        guard !isPresenting else { return }
        isPresenting = true
        snackBarViewController.presenter?.present(snackBarViewController, animated: true)
        if snackBarViewController.autodismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak snackBarViewController] in
                guard let snackBarViewController = snackBarViewController else { return }
                self.dismiss(vc: snackBarViewController)
            }
        }
    }
    
    func dismiss(vc: SnackBarViewController, delayNext: Int? = nil) {
        queue.remove(element: vc)
        vc.dismiss(animated: true) { [weak self] in
            self?.isPresenting = false
            vc.dismissCompletion?()
            if let delayNext = delayNext {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delayNext)) { [weak self] in
                    self?.present()
                }
            } else {
                self?.present()
            }
        }
    }
    
    func dismissCurrent() {
        guard isPresenting, let first = self.queue.first() else { return }
        dismiss(vc: first)
    }
    
    public func dismissAll() {
        while let vc = queue.removeFirst() {
            vc.dismiss(animated: false)
            vc.dismissCompletion?()
        }
        self.isPresenting = false
    }
}
