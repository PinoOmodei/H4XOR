//
//  DetailView.swift
//  H4XOR
//
//  Created by Pino Omodei on 22/03/23.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct WebView: UIViewRepresentable {
    var urlString: String?
    func makeUIView(context: Context) -> WebView.UIViewType {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.apple.com")
    }
}
