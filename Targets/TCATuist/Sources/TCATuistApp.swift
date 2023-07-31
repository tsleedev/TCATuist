import SwiftUI
import TCATuistUI
import DataLayer

@main
struct TCATuistApp: App {
    init() {
        AppConfiguration.shared.environment = .prod
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
