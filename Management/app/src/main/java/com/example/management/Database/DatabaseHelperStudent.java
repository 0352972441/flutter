package com.example.management.Database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DatabaseHelperStudent extends SQLiteOpenHelper {
    private static final String DATANAME = "database";
    private static final int VERSION = 1;
    /*private static final String createTable =
            "Create table TABLESTUDENT(ID TEXT PRIMARY KEY, NAME TEXT, CLASSNAME TEXT, PHONE TEXT)";*/
    private static final String createTable =
            "Create table TABLESTUDENT(ID TEXT PRIMARY KEY, NAME TEXT, CLASSNAME TEXT, PHONE TEXT, INFO TEXT)";
    public DatabaseHelperStudent(Context context) {
        super(context, DATANAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        try{
            db.execSQL(createTable);
        }catch (Exception ex){

        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS TABLESTUDENT");
    }
}
