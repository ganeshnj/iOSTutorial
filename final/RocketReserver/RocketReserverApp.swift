import SwiftUI
import Apollo
import DatadogCore
import DatadogRUM

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        
        Datadog.initialize(
            with: Datadog.Configuration(
                clientToken: clientToken,
                env: environment,
                site: .us1
            ),
            trackingConsent: .granted
        )

        RUM.enable(
            with: RUM.Configuration(
                applicationID: appID,
                uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
                uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate(),
                urlSessionTracking: .init(firstPartyHostsTracing: .trace(hosts: ["apollo-fullstack-tutorial.herokuapp.com"], sampleRate: 100, traceControlInjection: .all))
            )
        )
        
        URLSessionInstrumentation.enable(with: .init(delegateClass: URLSessionClient.self))

        return true
    }
}

@main
struct RocketReserverApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            LaunchListView()
        }
    }
}

let appID = "<app-id>"
let clientToken = "<client-token>"
let environment = "tests"

