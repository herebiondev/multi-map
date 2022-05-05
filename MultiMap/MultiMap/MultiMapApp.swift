//
//  MultiMapApp.swift
//  MultiMap
//
//  Created by Herebiondev on 5/5/22.
//

import SwiftUI

@main
struct MultiMapApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Hide the macOS tab system for our app
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .pasteboard) {}
        }
        
    }
}
