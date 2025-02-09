//
//  vdimApp.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/5.
//

import SDWebImage
import SwiftUI
import UIKit

class CustomSessionDelegate: NSObject, URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        // Log response info
        if let httpResponse = response as? HTTPURLResponse {
            print("Response URL: \(httpResponse.url?.absoluteString ?? "N/A")")
            print("Status Code: \(httpResponse.statusCode)")
            print("Headers: \(httpResponse.allHeaderFields)")

            if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String {
                print("Content-Type: \(contentType)")
            } else {
                print("Content-Type: N/A")
            }
        }

        // Allow the download to continue
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // Attempt to decode the data as text (e.g., JSON, HTML, plain text)
        if let responseString = String(data: data, encoding: .utf8) {
            print("Response Body (Decoded as Text):")
            print(responseString)
        } else {
            print("Failed to decode response data as text")
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // for injecting response to debug
//         let customDelegate = CustomSessionDelegate()
//         let customSession = URLSession(configuration: .default, delegate: customDelegate, delegateQueue: nil)
//         SDWebImageDownloader.shared.setValue(customSession, forKey: "session")

        let requestModifier = SDWebImageDownloaderRequestModifier { (request) -> URLRequest? in
            // Check if the URL path starts with "/uc_server"
            if let url = request.url, url.path.starts(with: "/uc_server") {
                var mutableRequest = request
                let systemVersion = UIDevice.current.systemVersion
                let buildVersion = UIApplication.buildVersion ?? "N/A"
                let appVersion = UIApplication.appVersion ?? "N/A"
                let modelName = UIDevice.modelName
                let userAgent = "LtyfansApp/\(appVersion)(iOS;\(systemVersion);\(modelName)) Build/\(buildVersion);CreatedAt/20250110"

                mutableRequest.setValue(
                    userAgent,
                    forHTTPHeaderField: "user-agent"
                )
                mutableRequest.setValue(
                    "https://api.lty.fan/",
                    forHTTPHeaderField: "referer"
                )

                return mutableRequest
            }
            

            // Return the original request if the path doesn't match
            return request
        }

        // Set the request modifier
        SDWebImageDownloader.shared.requestModifier = requestModifier

        return true
    }
}

extension UIApplication {
    static var buildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

@main
struct vdimApp: App {
    @StateObject var userAuthState = UserAuthState()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            // LoginView()
            //     .environmentObject(userAuthState)
            ContentView()
        }
    }
}
