//
//  DBUtil.swift
//  KChecker
//
//  Created by Mac on 2020/6/29.
//

import UIKit
import FMDB

class DBUtil: NSObject {
    static let util = DBUtil()
    let queue = FMDatabaseQueue(path: (NSHomeDirectory() + "/Documents/kchecker.db"))
    @objc static func sharedUtil() -> DBUtil {
        util.createDb()
//        util.open()
        return util
    }
    
    func createDb() {
        let dbPath = NSHomeDirectory() + "/Documents/kchecker.db"
        if FileManager.default.fileExists(atPath: dbPath) == false {
            let dbOriPath = Bundle.main.path(forResource: "kchecker", ofType: "db")
            do {
                try FileManager.default.copyItem(atPath: dbOriPath!, toPath: dbPath)
            } catch  {
                print("")
            }
        }
        
    }
    
    @objc func update(_ sql:String!) -> Void {
        queue?.inDatabase({ (db) in
            do {
                try db?.executeUpdate(sql, values: [])
            }
            catch{
                
            }
        })
    }
}
