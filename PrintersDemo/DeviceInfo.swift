//
//  DeviceInfo.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/16/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import Foundation
import RealmSwift

class DeviceInfo: Object {
    dynamic var name: String = ""
    dynamic var address: String = ""
    dynamic var brand: String = ""
    dynamic var role: String = ""
}
