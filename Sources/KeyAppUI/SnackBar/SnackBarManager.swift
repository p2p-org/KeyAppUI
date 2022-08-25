import UIKit

protocol SnackBarManagerDelegate {
    func snackBarDidDismiss()
}

public class SnackBarManager: SnackBarManagerDelegate {
    
    /// Behavior on showing snackbar
    public enum Behavior: Equatable {
        case queued
        case dismissOldWhenAddingNew
    }
    
    static public let shared = SnackBarManager()
    
    public var behavior: Behavior = .dismissOldWhenAddingNew
    
    private var queue = SynchronizedArray<SnackBar>()
    
    private var isPresenting = false
    
    private init() {}
    
    // MARK: - SnackBarManagerDelegate
    
    func snackBarDidDismiss() {
        isPresenting = false
    }
    
    func present(_ vc: SnackBar) {
        queue.append(vc)
        present()
    }
    
    func present() {
        guard let snackBarView = self.queue.first() else { return }
        
        if isPresenting && behavior == .dismissOldWhenAddingNew {
            // dismiss old snackbar silently
            dismiss(vc: snackBarView)
            return
        }
        
        guard !isPresenting else { return }
        isPresenting = true
        snackBarView.presenter?.present(snackBarView, animated: true)
        if snackBarView.autodismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak snackBarView] in
                guard let snackBarViewController = snackBarViewController else { return }
                self.dismiss(vc: snackBarViewController)
            }
        }
    }
    
    func dismiss(vc: SnackBar) {
        queue.remove(element: vc)
        vc.dismiss(animated: true) { [weak self] in
            self?.isPresenting = false
            vc.dismissCompletion?()
            self?.present()
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
