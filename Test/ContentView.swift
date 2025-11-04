import SwiftUI

struct ContentView: View {
    @StateObject private var webViewModel = WebViewModel()
    @StateObject private var locationManager = LocationPermissionManager()
    @Environment(\.scenePhase) private var scenePhase
    @State private var hasLoadedInitialURL = false

    var body: some View {
        WebView(viewModel: webViewModel)
            .ignoresSafeArea()
            .task {
                guard !hasLoadedInitialURL else { return }

                hasLoadedInitialURL = true
                locationManager.requestPermissionIfNeeded()
                webViewModel.load(AppConfiguration.rootURL)
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    locationManager.requestPermissionIfNeeded()
                    if hasLoadedInitialURL {
                        webViewModel.reload()
                    }
                case .inactive, .background:
                    locationManager.stopUpdatingLocation()
                default:
                    break
                }
            }
    }
}

#Preview {
    ContentView()
}
