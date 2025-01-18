//
//  vdimApp.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/5.
//

import SwiftUI

@main
struct vdimApp: App {
    @StateObject var userAuthState = UserAuthState()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(userAuthState)
        }
    }
}
