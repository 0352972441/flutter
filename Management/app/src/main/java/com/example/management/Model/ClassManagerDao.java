package com.example.management.Model;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.example.management.Database.HelperDatabase;

import java.util.ArrayList;

public class ClassManagerDao {
    private SQLiteDatabase database;
    public ClassManagerDao(Context context){
        SQLiteOpenHelper helper = new HelperDatabase(context);
        database = helper.getWritableDatabase();
    }


    public  boolean add(ClassStudent student){
        for(ClassStudent i: getAll()){
            if(student.getId().equals(i.getId())){
                return false;
            }
        }
        if (insertData(database, student.getId(), student.getName())){
            return true;
        }
        return false;
    }

    public ArrayList<ClassStudent> getAll(){
        ArrayList<ClassStudent> listData = new ArrayList();
        Cursor cursor = database.query("ClassRooms",null,null,null,null,null,null);
        while (cursor.moveToNext()){
            String className = cursor.getString(1);
            String classCode = cursor.getString(0);
            ClassStudent student = new ClassStudent(className, classCode);
            listData.add(student);
        }
        return  listData;
    }

    public boolean remote(String id){
        int i = database.delete("ClassRooms", "classCode = ?", new String[]{id});
        if(i == 0){
            return false;
        }
        return true;
    }

    public boolean edit(ClassStudent student, String id){
        ContentValues contentValues = new ContentValues();
        contentValues.put("classCode", student.getId());
        contentValues.put("className", student.getName());
        try {
            int i = database.update("ClassRooms", contentValues, "classCode = ?", new String[]{id});
            if( i ==0){
                return false;
            }
        }catch (Exception ex){

        }
        return true;
    }


    private static boolean insertData(SQLiteDatabase database, String classCode, String className){
        /// Insert data for table
        ContentValues contentValues = new ContentValues();
        contentValues.put("classCode", classCode);
        contentValues.put("className", className);
        try {
            database.insert("ClassRooms",null, contentValues);
            return true;
        }catch (Exception ex){

        }
        return false;
    }




}
