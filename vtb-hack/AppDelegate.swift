import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var router: AppRouter!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        router = AppRouter()
        router.start(in: window)
    }

}
