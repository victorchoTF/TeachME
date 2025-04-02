//
//  WherebyWebView.swift
//  TeachME
//
//  Created by TumbaDev on 1.04.25.
//

import SwiftUI
import WebKit

struct WherebyWebView: UIViewRepresentable {
    let constants: WherebyConstants

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        if let url = URL(string: constants.urlString) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}
}
