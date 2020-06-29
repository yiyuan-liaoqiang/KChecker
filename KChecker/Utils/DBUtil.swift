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
    var queue:FMDatabaseQueue!
    @objc static func sharedUtil() -> DBUtil {
        util.createDb()
        return util
    }
    
    func createDb() {
        let dbPath = NSHomeDirectory() + "/Documents/k_checker.db"
        if FileManager.default.fileExists(atPath: dbPath) == false {
            let dbOriPath = Bundle.main.path(forResource: "k_checker", ofType: "db")
            do {
                try FileManager.default.copyItem(atPath: dbOriPath!, toPath: dbPath)
            } catch  {
                print("")
            }
        }
        queue = FMDatabaseQueue(path: (NSHomeDirectory() + "/Documents/k_checker.db"))!
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
    
    @objc func query(_ sql:String!) -> [[String:Any]] {
        var array = [[String:Any]]()
        queue?.inDatabase({ (db) in
            do {
                let res = try db?.executeQuery(sql, values: [])
                while res?.next() ?? false {
                    if let dic = res?.resultDictionary() as? [String:Any] {
                        array.append(dic)
                    }
                }
            }
            catch{
                
            }
        })
        return array
    }
}
