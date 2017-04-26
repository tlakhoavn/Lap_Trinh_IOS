//
//  ClassBanAn.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/16/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

class ClassDatBan{
    var IDDatBan:Int
    var SoBan:Int
    var ThoiGianDatBan:String
    var MaDanhSachMon:Int
    var TongTien:Float
    var TrangThai:String
    init(IDDatBan:Int, SoBan:Int, ThoiGianDatBan:String, MaDanhSachMon:Int, TongTien:Float, TrangThai:String ){
        self.IDDatBan = IDDatBan
        self.SoBan = SoBan
        self.ThoiGianDatBan = ThoiGianDatBan
        self.MaDanhSachMon = MaDanhSachMon
        self.TongTien = TongTien
        self.TrangThai = TrangThai
        
    }
    convenience init(){
        
        self.init(IDDatBan:0, SoBan:0, ThoiGianDatBan:"1/1/2017", MaDanhSachMon:0, TongTien:0, TrangThai: "00")
    }
}
func ThemDatBan(db: OpaquePointer?,DatBan: ClassDatBan)
{
    let insertQuery: String = "INSERT INTO DatBan (IDDatBan, SoBan, ThoiGianDatBan, MaDanhSachMon, TongTien, TrangThai) VALUES ('\(DatBan.IDDatBan)', '\(DatBan.SoBan)','\(DatBan.ThoiGianDatBan)', '\(DatBan.MaDanhSachMon)', '\(DatBan.TongTien)', '\(DatBan.TrangThai)');"
    query(db: db, queryStr: insertQuery)
}


func selectDatBan(db: OpaquePointer?) -> [ClassDatBan]
{
    let selectQuery = "SELECT * FROM DanhSachMon "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassDatBan]()
    
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
            
            let idDatBan = String(cString:queryResultCol0!)
            let soban = String(cString:queryResultCol1!)
            let thoigiandatban = String(cString:queryResultCol2!)
            let madanhsachmon = String(cString:queryResultCol3!)
            let tongtien = String(cString:queryResultCol4!)
            let tien = (tongtien as NSString).floatValue
            let trangthai = String(cString:queryResultCol5!)

            let datban = ClassDatBan(IDDatBan: Int(idDatBan)!, SoBan: Int(soban)!, ThoiGianDatBan: thoigiandatban, MaDanhSachMon: Int(madanhsachmon)!, TongTien: tien, TrangThai: trangthai)
            List.append(datban)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}




