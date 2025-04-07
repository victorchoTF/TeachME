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

final class URLOpener: MessagesOpener, MailOpener {
    enum Constants {
      static let messagePrefix = "sms://"
      static let mailPrefix = "mailto://"
   }
    
    func openMessage(for phoneNumber: String) {
        openUrl("\(Constants.messagePrefix)\(phoneNumber)")
    }
    
    func openMail(for mail: String) {
        openUrl("\(Constants.mailPrefix)\(mail)")
    }
}

private extension URLOpener {
    func openUrl(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
