//
//  Printers.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/16/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import Foundation
import RealmSwift

class Printers: Object {
    dynamic var printer: DeviceInfo?
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
