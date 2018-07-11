//
//  Memo.swift
//  RealmSample
//
//  Created by Ryo Endo on 2018/07/11.
//  Copyright © 2018年 Ryo Endo. All rights reserved.
//

import UIKit
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var id: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
