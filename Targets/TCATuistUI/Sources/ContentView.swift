import SwiftUI
import ComposableArchitecture

public struct ContentView: View {
    public init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    public var body: some View {
        TabView {
            CounterView(
                store: Store(
                    initialState: Counter.State(),
                    reducer: Counter()
                )
            ).tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            SearchView(
                store: Store(
                    initialState: SearchFeature.State(),
                    reducer: SearchFeature() // ._printChanges()
                )
            ).tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            MoreView(
                store: Store(
                    initialState: MoreFeature.State(),
                    reducer: MoreFeature()
                )
            ).tabItem {
                Image(systemName: "ellipsis")
                Text("More")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
