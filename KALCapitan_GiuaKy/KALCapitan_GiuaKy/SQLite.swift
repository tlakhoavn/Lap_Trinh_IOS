//
//  SQLite.swift
//  QuanLyQuanAn
//
//  Created by liem on 4/16/17.
//  Copyright © 2017 liem. All rights reserved.
//

import Foundation

//
//  SQLite_Controller.swift
//  01412227_Homework1
//
//  Created by Liem on 4/2/17.
//  Copyright © 2017 Liem. All rights reserved.
//

import Foundation




//open db
func openDB() -> OpaquePointer?
{
    
    let dbURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let dbPath = dbURL.appendingPathComponent("QuanLyQuanAn.sqlite").path
    
    var db: OpaquePointer? = nil
    if sqlite3_open(dbPath,&db) == SQLITE_OK
    {
        print("Database successfully opened at \(dbPath) ")
        return db
    }
    else
    {
        print("Failed to open database")
        return nil
    }
}

//create tables
func createTable(db: OpaquePointer?, queryStr: String)
{
    var sqlStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, queryStr, -1 , &sqlStatement, nil) == SQLITE_OK
    {
        if sqlite3_step(sqlStatement) == SQLITE_DONE
        {
            print("Table created successfully")
        }
        else
        {
            print("Error Creating table")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    else
    {
        print("Error with create query")
    }
}

//send different kind of queries
func query(db: OpaquePointer?, queryStr: String)
{
    var sqlStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, queryStr, -1 , &sqlStatement, nil) == SQLITE_OK
    {
        if sqlite3_step(sqlStatement) == SQLITE_DONE
        {
            print("Success")
        }
        else
        {
            print("Error")
        }
        
        sqlite3_finalize(sqlStatement)
    }
    else
    {
        print("Error with query ")
    }
}

