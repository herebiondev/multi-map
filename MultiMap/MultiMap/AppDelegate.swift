//
//  AppDelegate.swift
//  MultiMap
//
//  Created by Herebiondev on 5/5/22.
//
//  "Delegates" are AppKit's preferred way of responding to events.
//  AppKit developers frequently work with a protocol called
//  NSApplicationDelegate, wich provides support for handling app-wide
//  events such as receiving files, creating the dock menu, and -importantly-
//  deciding what to do when the last windows is closed.
//
//  We need to use AppKit instead of SwiftUI because this is another thing that's
//  easy to do in AppKit, but currently impossible in pure SwiftUI, so we need to
//  write some code to handle it.

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    
    // Now we need to add exactly one method to this class, and it has a very precise
    // name because macOS will automatically look for this method and call it as needed.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
