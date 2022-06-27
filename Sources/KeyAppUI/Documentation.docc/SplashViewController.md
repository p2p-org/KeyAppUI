# ``KeyAppUI/SplashViewController``

A viewController with splash animation for app openning. Text is customizable

## Usage

Initialize controller with your text and present it the way you need. B

```swift
let splashVC = SplashViewController(text: "key app")
splashVC.modalPresentationStyle = .fullScreen
present(splashVC, animated: true)
```swift

Currently animation is not infinite. It plays one time and the screen will close itself. The behaviour will be changed as soon as onboarding will be released.
