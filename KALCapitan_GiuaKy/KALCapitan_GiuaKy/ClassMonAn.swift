//
//  ClassMon.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/17/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

class ClassMonAn{
    var TenMon:String
    var Gia:Float
    var MoTa:String
    var HinhAnh:String
    init(TenMon:String,Gia:Float, MoTa:String, HinhAnh:String) {
        self.TenMon = TenMon
        self.Gia = Gia
        self.HinhAnh = HinhAnh
        self.MoTa = MoTa
    }
    convenience init(){
        self.init(TenMon:"Rau Ma",Gia:50000, MoTa:"aaa", HinhAnh:"")
        
    }
    
}

func selectMonAn(db: OpaquePointer?) -> [ClassMonAn]
{
    let selectQuery = "SELECT * FROM MonAn "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassMonAn]()
    print( "SELECT * FROM MonAn ")
    
    if sqlite3_prepare_v2(db, selectQuery, -1 , &sqlStatement, nil) == SQLITE_OK
    {
        print("ok");
        while sqlite3_step(sqlStatement) == SQLITE_ROW
        {
            let queryResultCol0 = sqlite3_column_text(sqlStatement, 0)
            let queryResultCol1 = sqlite3_column_text(sqlStatement, 1)
            let queryResultCol2 = sqlite3_column_text(sqlStatement, 2)
            let queryResultCol3 = sqlite3_column_text(sqlStatement, 3)
            
            if(queryResultCol0 == nil)
            {
                break;
            }
            
            let tenmon = String(cString:queryResultCol0!)
            let temp = String(cString:queryResultCol1!)
            let gia:Float = (temp as NSString).floatValue
            let mota = String(cString:queryResultCol2!)
            let hinhanh = String(cString:queryResultCol3!)
            
            let monan = ClassMonAn(TenMon: tenmon, Gia: gia, MoTa: mota, HinhAnh: hinhanh)
            
            List.append(monan)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}
func ThemMonAn(db: OpaquePointer?,MonAn: ClassMonAn)
{
    let insertQuery: String = "INSERT INTO MonAn (TenMon, Gia, MoTa, HinhAnh) VALUES ('\(MonAn.TenMon)', '\(MonAn.Gia)','\(MonAn.MoTa)', '\(MonAn.HinhAnh)');"
    query(db: db, queryStr: insertQuery)
}


