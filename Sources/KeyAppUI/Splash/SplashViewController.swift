import UIKit
import BEPureLayout

public final class SplashViewController: BEViewController {

    private let customView = SplashView()

    public override func setUp() {
        self.view.addSubview(customView)
        customView.autoPinEdgesToSuperviewEdges()
        customView.completionHandler = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.run()
    }

    private func run() {
        customView.animate()
    }
}
