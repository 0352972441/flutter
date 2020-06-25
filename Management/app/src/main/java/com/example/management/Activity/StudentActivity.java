package com.example.management.Activity;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import com.example.management.Exception.EmptyException;
import com.example.management.Exception.NumberPhoneException;
import com.example.management.Model.ClassManagerDao;
import com.example.management.Model.DetailStudent;
import com.example.management.Model.HandleError;
import com.example.management.Model.ClassStudent;
import com.example.management.Model.StudentManagerDao;
import com.example.management.R;

import java.util.ArrayList;


public class StudentActivity extends AppCompatActivity {
    StudentManagerDao dao = null;
    ClassManagerDao clsDao = null;
    ArrayList<ClassStudent> listDataSpiner;
    Spinner spinnerStudent;
    EditText txtName, txtid, txtClassName, txtphone;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_student);
        dao = new StudentManagerDao(this);
        clsDao = new ClassManagerDao(this);
        txtName = (EditText)findViewById(R.id.txtName);
        txtid = (EditText)findViewById(R.id.txtid);
        txtClassName = (EditText)findViewById(R.id.txtClass);
        txtphone = (EditText)findViewById(R.id.txtPhone);
        createSpinner();
    }

    private void createSpinner(){
        spinnerStudent = (Spinner)findViewById(R.id.spinner);
        listDataSpiner = clsDao.getAll();
        ArrayAdapter arrayAdapter = new ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, clsDao.getAll());
        spinnerStudent.setAdapter(arrayAdapter);
    }

    public void add(View view){
        String name = txtName.getText().toString();
        String id = txtid.getText().toString();
        String phone = txtphone.getText().toString();
        String className = txtClassName.getText().toString();
        String info = "";
        if(spinnerStudent.getSelectedItem() != null){
            info = spinnerStudent.getSelectedItem().toString();
        }
        try {
            if (HandleError.isEmpty(name, id, className, phone, info) && HandleError.isNumberPhone(phone)) {
                if(dao.insertRow(name, id, phone, className, info)) {
                    cancel(view);
                    Toast.makeText(this, "Insert successed", Toast.LENGTH_SHORT).show();
                }else{
                    Toast.makeText(this, "Duplicate ID", Toast.LENGTH_SHORT).show();
                }
            }
        }catch (EmptyException | NumberPhoneException ex){
            Toast.makeText(this, "Fail", Toast.LENGTH_SHORT).show();
        }
    }

    public void cancel(View view){
        txtName.setText("");
        txtid.setText("");
        txtClassName.setText("");
        txtphone.setText("");
    }


    public void showList(View view){
        Intent intent = new Intent(this, ListInfo.class);
        startActivity(intent);
    }

}
