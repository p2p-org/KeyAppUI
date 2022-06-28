import UIKit
import BEPureLayout

public final class SplashViewController: BEViewController {
    
    public var completionHandler: (() -> Void)? {
        get { customView.completionHandler }
        set { customView.completionHandler = newValue }
    }

    private let customView = SplashView()

    public override func setUp() {
        self.view.addSubview(customView)
        customView.autoPinEdgesToSuperviewEdges()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.run()
    }

    private func run() {
        customView.animate()
    }
}
