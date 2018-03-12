//
//  ExtensionHelper.swift
//  RepliconTest
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

extension Collection {
    func find(predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Self.Iterator.Element? {
        return try index(where: predicate).map({self[$0]})
    }
}
