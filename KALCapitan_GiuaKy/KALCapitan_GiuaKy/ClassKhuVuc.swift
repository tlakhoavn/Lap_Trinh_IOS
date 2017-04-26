//
//  ClassKhuVuc.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/17/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

class ClassKhuVuc{
    var MaKhuVuc:Int
    var Ten:String
    var HinhAnh:String
    var MoTa:String
    init(MaKhuVuc:Int, Ten:String, HinhAnh:String, MoTa:String){
        self.MaKhuVuc = MaKhuVuc
        self.Ten = Ten
        self.HinhAnh = HinhAnh
        self.MoTa = MoTa
        
    }
    convenience init(){
        
        self.init(MaKhuVuc:01, Ten:"A", HinhAnh:"", MoTa:"abc")
    }
}

func selectKhuVuc(db: OpaquePointer?) -> [ ClassKhuVuc]
{
    let selectQuery = "SELECT * FROM KhuVuc "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassKhuVuc]()
    
    if sqlite3_prepare_v2(db, selectQuery, -1 , &sqlStatement, nil) == SQLITE_OK
    {
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
            
            let makhuvuc = String(cString:queryResultCol0!)
            let ten = String(cString:queryResultCol1!)
            let hinhanh = String(cString:queryResultCol2!)
            let mota = String(cString:queryResultCol3!)
            
            let khuvuc = ClassKhuVuc(MaKhuVuc: Int(makhuvuc)!, Ten: ten, HinhAnh: hinhanh, MoTa: mota)
            
            List.append(khuvuc)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}


