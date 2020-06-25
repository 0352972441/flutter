package com.example.management.Database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;


public class HelperDatabase extends SQLiteOpenHelper {
    private static final String NAME = "DATABASE";
    private static final int VERSION = 2;
    private static final String sql = "Create table ClassRooms( classcode TEXT PRIMARY KEY,className TEXT)";
    public HelperDatabase(Context context) {
        super(context, NAME, null, VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        try{
            db.execSQL(sql);
        }catch (Exception ex) {

        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS ClassRooms");
    }
}
