//
//  CommonTypes.swift
//

import Foundation
import UIKit

public enum Resources {
    public enum Api {
        static let baseURL = URL(string: "https://xm-assignment.web.app")!
    }
    public enum UI {
        public enum Colors {
            static let color000000: UIColor = UIColor.init(hex: 0x000000)!
            static let colorFFFFFF: UIColor = UIColor.init(hex: 0xFFFFFF)!
            static let colorCBCBCB: UIColor = UIColor.init(hex: 0xCBCBCB)!
            static let color1BCB93: UIColor = UIColor.init(hex: 0x1BCB93)!
            static let colorFF6B53: UIColor = UIColor.init(hex: 0xFF6B53)!
        }
        public enum Fonts {
            static func systemRegular(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size) }
            static func systemBold(size: CGFloat) -> UIFont { return UIFont.boldSystemFont(ofSize: size) }
            static func systemItalic(size: CGFloat) -> UIFont { return UIFont.italicSystemFont(ofSize: size) }
        }
        public enum Appearance {
            static func navBar() {
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                navigationBarAppearance.backgroundColor = Resources.UI.Colors.colorFFFFFF
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactScrollEdgeAppearance = navigationBarAppearance
                UINavigationBar.appearance().tintColor = Resources.UI.Colors.color000000
            }
        }
    }
    public enum Misc {
        static let bannerDuration: TimeInterval = 3
    }
}
