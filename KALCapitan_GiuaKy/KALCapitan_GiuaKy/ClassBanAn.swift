//
//  ClassBanAn.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/16/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

class ClassBanAn{
    var SoBan:Int
    var ThongTin:String
    var HinhAnh:String
    var MaKhuVuc:Int
    init(SoBan:Int, ThongTin:String, HinhAnh:String, MaKhuVuc:Int){
        self.SoBan = SoBan
        self.ThongTin = ThongTin
        self.HinhAnh = HinhAnh
        self.MaKhuVuc = MaKhuVuc
        
    }
    convenience init(){
        
        self.init(SoBan:01, ThongTin:"A", HinhAnh:"", MaKhuVuc:01)
    }
    func getSoBan() -> Int {
        return self.SoBan
    }
    func setSoBan(SoBan:Int) -> Void {
        self.SoBan = SoBan
    }
    
}
func selectBanAn(db: OpaquePointer?) -> [ClassBanAn]
{
    let selectQuery = "SELECT * FROM BanAn "
    var sqlStatement: OpaquePointer? = nil
    var List = [ClassBanAn]()
    
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
            
            let soban = String(cString:queryResultCol0!)
            let thongtin = String(cString:queryResultCol1!)
            let hinhanh = String(cString:queryResultCol2!)
            let makhuvuc = String(cString:queryResultCol3!)
            
            let banan = ClassBanAn(SoBan: Int(soban)!, ThongTin: thongtin, HinhAnh: hinhanh, MaKhuVuc: Int(makhuvuc)!)
            
            List.append(banan)
            
        }
    }
    sqlite3_finalize(sqlStatement)
    
    return List
}

func ThemBanAn(db: OpaquePointer?,BanAn: ClassBanAn)
{
    let insertQuery: String = "INSERT INTO BanAn (SoBan, ThongTin, HinhAnh, ThuocKhuVuc) VALUES ('\(BanAn.SoBan)', '\(BanAn.ThongTin)','\(BanAn.HinhAnh)', '\(BanAn.MaKhuVuc)');"
    query(db: db, queryStr: insertQuery)
}










