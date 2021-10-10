import SwiftUI
import VK_ios_sdk
import TGPassportKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        VKUIDelegate().initialize()

        //var navVC = UINavigationController()
        //self.window?.rootViewController = navVC
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)

        //let loginVC = LoginVC()
        //navVC.setViewControllers([loginVC], animated: true)

        return true
    }

    func application(_ application: UIApplication, open url: URL, launchOptions: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("XXXXX")
        VKSdk.processOpen(url, fromApplication: launchOptions[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        TGPAppDelegate.shared().application(application, open: url, options: launchOptions)
        return true
    }
}

class VKUIDelegate: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    let VK_APP_ID = "7971692"
    let VK_SCOPE = ["offline"]

    func initialize() {
        let sdkInstance = VKSdk.initialize(withAppId: self.VK_APP_ID)
        sdkInstance!.register(self)
        sdkInstance!.uiDelegate = self
        VKSdk.wakeUpSession(self.VK_SCOPE, complete: {(state, err) -> Void in
            if (state == VKAuthorizationState.authorized) {
                // authorized
            } else {
                //VKSdk.authorize(self.VK_SCOPE)
            }
        })
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
            if (result.token != nil) {
                //RegistrationView()
            } else if (result.error != nil) {
                //LoginScreen()
            }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}

@main
struct VTBApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
