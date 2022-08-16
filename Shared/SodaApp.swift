//
//  SodaApp.swift
//  Shared
//
//  Created by James on 8/12/22.
//

import SwiftUI

@main
struct SodaApp: App {
    @StateObject var spotifyController = SpotifyController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    spotifyController.setAccessToken(from: url)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                    spotifyController.connect()
                })
        }
    }
}
