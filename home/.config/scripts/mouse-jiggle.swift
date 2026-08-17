#!/usr/bin/swift
import CoreGraphics
import Foundation

let pos = CGEvent(source: nil)?.location ?? CGPoint(x: 0, y: 0)
let e1 = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: CGPoint(x: pos.x + 1, y: pos.y), mouseButton: .left)
e1?.post(tap: .cghidEventTap)
Thread.sleep(forTimeInterval: 0.05)
let e2 = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: pos, mouseButton: .left)
e2?.post(tap: .cghidEventTap)
