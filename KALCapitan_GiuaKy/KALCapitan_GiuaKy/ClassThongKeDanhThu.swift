//
//  ClassBanAn.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/16/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

class ClassThongKeDanhthu{
    var IDDatBan:Int
    var ThoiGianDat:String
    var TongTien:Float
    init(IDDatBan:Int,ThoiGianDat:String,TongTien:Float){
    
        self.IDDatBan = IDDatBan
        self.ThoiGianDat = ThoiGianDat
        self.TongTien = TongTien
    }
    convenience init(){
        
        self.init(IDDatBan:0,ThoiGianDat:"1/1/2017",TongTien:0)
    }
}
func selectThongKeDanhThu(db: OpaquePointer?) -> [ClassThongKeDanhthu]
{
    let selectQuery = "SELECT * FROM ThongKeDanhThu "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassThongKeDanhthu]()
    
    if sqlite3_prepare_v2(db, selectQuery, -1 , &sqlStatement, nil) == SQLITE_OK
    {
        while sqlite3_step(sqlStatement) == SQLITE_ROW
        {
            let queryResultCol0 = sqlite3_column_text(sqlStatement, 0)
            let queryResultCol1 = sqlite3_column_text(sqlStatement, 1)
            let queryResultCol2 = sqlite3_column_text(sqlStatement, 2)
            
            if(queryResultCol0 == nil)
            {
                break;
            }
            
            let id = String(cString:queryResultCol0!)
            let thoigiandat = String(cString:queryResultCol1!)
            let temp = String(cString:queryResultCol2!)
            let tongtien = (temp as NSString).floatValue
            let thongkedanhthu = ClassThongKeDanhthu(IDDatBan: Int(id)!, ThoiGianDat: thoigiandat, TongTien: tongtien)
            List.append(thongkedanhthu)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}

func ThemThongkeDanhThu(db: OpaquePointer?,ThongKeDanhThu: ClassThongKeDanhthu)
{
    let insertQuery: String = "INSERT INTO ThongKeDanhThu (IDDatBan, ThoiGianDat, TongTien) VALUES ('\(ThongKeDanhThu.IDDatBan)', '\(ThongKeDanhThu.ThoiGianDat)','\(ThongKeDanhThu.TongTien)');"
    query(db: db, queryStr: insertQuery)
}

