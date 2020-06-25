package com.example.management.Model;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.view.View;
import android.widget.EditText;

import com.example.management.Database.DatabaseHelperStudent;

import java.util.ArrayList;

public class StudentManagerDao {
    private static final String table = "TABLESTUDENT";
    private static final String phoneTable = "PHONE";
    private static final String idTable = "ID";
    private static final String classNameTable = "CLASSNAME";
    private static final String nameTable = "NAME";
    ArrayList<DetailStudent> listData = new ArrayList<>();
    SQLiteDatabase database;
    public StudentManagerDao(Context context){
        SQLiteOpenHelper sqLiteOpenHelper = new DatabaseHelperStudent(context);
        database = sqLiteOpenHelper.getWritableDatabase();
    }

    public  boolean insertRow(String name, String id, String phone, String className, String info){
        long isCheck = 0;
        try{
            ContentValues contentValues = new ContentValues();
            contentValues.put(nameTable, name);
            contentValues.put(idTable, id);
            contentValues.put(phoneTable, phone);
            contentValues.put("INFO", info);
            contentValues.put(classNameTable, className);
            isCheck = database.insert(table, null, contentValues);
        }catch (Exception ex){
            return false;
        }
        if(isCheck != -1){
            return true;
        }
        return false;
    }

    public ArrayList<DetailStudent> getAll(){
        Cursor cursor = database.query("TABLESTUDENT", null, null, null, null, null, null);
        try{
            while(cursor.moveToNext()){
                String id = cursor.getString(0);
                String name = cursor.getString(1);
                String className = cursor.getString(2);
                String phone = cursor.getString(3);
                String info = cursor.getString(4);
                DetailStudent detailStudent = new DetailStudent(name,  id,  className,  phone, info);
                listData.add(detailStudent);
            }
        }catch (Exception e){

        }
        return listData;
    }

    public boolean update(String id, String name, String phone, String className){
        ContentValues contentValues = new ContentValues();
        contentValues.put(idTable, id);
        contentValues.put(classNameTable, className);
        contentValues.put(phoneTable, phone);
        contentValues.put(nameTable, name);
        try {
            int i = database.update(table, contentValues, idTable +"=?", new String[]{id});
            if( i == 0){
                return false;
            }
        }catch (Exception ex){

        }
        return true;
    }

    public boolean remote(String id){
        int i = database.delete(table, idTable +" = ?", new String[]{id});
        if(i == 0){
            return false;
        }
        return true;
    }



}
