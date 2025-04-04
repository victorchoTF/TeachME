//
//  URLOpener.swift
//  TeachME
//
//  Created by TumbaDev on 4.04.25.
//

import SwiftUI

protocol MessagesOpener {
    func openMessage(for phoneNumber: String)
}

protocol MailOpener {
    func openMail(for mail: String)
}

struct URLOpenerURLs {
    static let messagesURL = "sms://"
    static let mailURL = "mailto:"
}

final class URLOpener: MessagesOpener, MailOpener {
    private let messagesURL: String
    private let mailURL: String
    
    init(messagesURL: String, mailURL: String) {
        self.messagesURL = messagesURL
        self.mailURL = mailURL
    }
    
    func openMessage(for phoneNumber: String) {
        openUrl("\(messagesURL)\(phoneNumber)")
    }
    
    func openMail(for mail: String) {
        openUrl("\(mailURL)\(mail)")
    }
}

private extension URLOpener {
    func openUrl(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
