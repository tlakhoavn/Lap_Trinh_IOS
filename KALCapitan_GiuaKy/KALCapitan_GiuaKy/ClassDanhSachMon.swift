//
//  DanhSachMon.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/17/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation
class ClassDanhSachMon{
    var ID:Int
    var TenMon:String
    var MaDanhSachMon:Int
    var SoLuong:Int
    var TongTien:Float
    var ThoiGianGoiMon:String
    init(ID:Int, TenMon:String, MaDanhSachMon:Int, SoLuong:Int,TongTien:Float,ThoiGianGoiMon:String){
        self.ID = ID
        self.TenMon = TenMon
        self.MaDanhSachMon = MaDanhSachMon
        self.TongTien = TongTien
        self.SoLuong = SoLuong
        self.ThoiGianGoiMon = ThoiGianGoiMon
        
        
    }
    convenience init(){
        
        self.init(ID:0, TenMon:"A", MaDanhSachMon:0, SoLuong:0,TongTien:0,ThoiGianGoiMon:"1/1/2017")
    }
}
func ThemDanhSachMon(db: OpaquePointer?,DanhSachMon: ClassDanhSachMon)
{
    let insertQuery: String = "INSERT INTO DanhSachMon (TenMon, MaDanhSachMon, SoLuong, TongTien, ThoiGianGoiMon) VALUES ('\(DanhSachMon.ID)', '\(DanhSachMon.TenMon)','\(DanhSachMon.MaDanhSachMon)', '\(DanhSachMon.SoLuong)', '\(DanhSachMon.TongTien)', '\(DanhSachMon.ThoiGianGoiMon)');"
    query(db: db, queryStr: insertQuery)
}

func selectDanhSachMon(db: OpaquePointer?) -> [ClassDanhSachMon]
{
    let selectQuery = "SELECT * FROM DanhSachMon "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassDanhSachMon]()
    
    if sqlite3_prepare_v2(db, selectQuery, -1 , &sqlStatement, nil) == SQLITE_OK
    {
        while sqlite3_step(sqlStatement) == SQLITE_ROW
        {
            let queryResultCol0 = sqlite3_column_text(sqlStatement, 0)
            let queryResultCol1 = sqlite3_column_text(sqlStatement, 1)
            let queryResultCol2 = sqlite3_column_text(sqlStatement, 2)
            let queryResultCol3 = sqlite3_column_text(sqlStatement, 3)
            let queryResultCol4 = sqlite3_column_text(sqlStatement, 4)
            let queryResultCol5 = sqlite3_column_text(sqlStatement, 5)
            
            if(queryResultCol0 == nil)
            {
                break;
            }
            
            let id = String(cString:queryResultCol0!)
            let tenmon = String(cString:queryResultCol1!)
            let madanhsachmon = String(cString:queryResultCol2!)
            let soluong = String(cString:queryResultCol3!)
            let tongtien = String(cString:queryResultCol4!)
            let tien = (tongtien as NSString).floatValue
            let thoigiangoimon = String(cString:queryResultCol5!)
            
            let danhsachmon = ClassDanhSachMon(ID: Int(id)!, TenMon: tenmon, MaDanhSachMon: Int(madanhsachmon)!, SoLuong: Int(soluong)!, TongTien: tien, ThoiGianGoiMon: thoigiangoimon)
            
            List.append(danhsachmon)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}


