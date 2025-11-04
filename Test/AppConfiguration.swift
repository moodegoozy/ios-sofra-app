import Foundation

enum AppConfiguration {
    static var rootURL: URL {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "AppRootURL") as? String,
           let url = URL(string: urlString) {
            return url
        }

        return URL(string: "https://albayt-sofra.web.app/")!
    }
}
