package com.example.management.Activity;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import com.example.management.Model.ClassManagerDao;
import com.example.management.Model.ClassStudent;
import com.example.management.R;

import java.util.ArrayList;

public class Activity_Class extends AppCompatActivity {
    ClassManagerDao dao;
    Button btAdd, btCancel,btRemote, btEdit;
    EditText idText, nameText;
    ListView list;
    ArrayAdapter adapter;
    String index ="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity__class);
        dao = new ClassManagerDao(this);
        btAdd = (Button)findViewById(R.id.btadd);
        btCancel = (Button)findViewById(R.id.btcancel);
        btEdit = (Button)findViewById(R.id.btedit);
        btRemote = (Button)findViewById(R.id.btremote);
        idText = (EditText)findViewById(R.id.id);
        nameText = (EditText)findViewById(R.id.name);
        createListView();
    }

    private void createListView(){
        list = (ListView)findViewById(R.id.list);
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1,dao.getAll());
        list.setAdapter(adapter);
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                ArrayList<ClassStudent> data = dao.getAll();
                idText.setText(data.get(position).getId());
                nameText.setText(data.get(position).getName());
                index = data.get(position).getId();
            }
        });
    }

    public void add(View view){
        String name = nameText.getText().toString();
        String id = idText.getText().toString();
        ClassStudent student = new ClassStudent(name, id);
        if(dao.add(student)){
            adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1,dao.getAll());
            list.setAdapter(adapter);
            nameText.setText("");
            idText.setText("");
            Toast.makeText(this, "Insert successed", Toast.LENGTH_SHORT).show();
        }else{
            Toast.makeText(this, "Insert fail", Toast.LENGTH_SHORT).show();
        }
    }

    public void cancel(View view){
        nameText.setText("");
        idText.setText("");
    }

    public void remote(View view){
        if(dao.remote(index)){
            adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1,dao.getAll());
            list.setAdapter(adapter);
            cancel(view);
        }else {
            Toast.makeText(this, "Fail", Toast.LENGTH_SHORT).show();
        }

    }

    public void edit(View view){
        String name = nameText.getText().toString();
        String id = idText.getText().toString();
        ClassStudent student = new ClassStudent(name, id);
        if(dao.edit(student, index)){
            adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1,dao.getAll());
            list.setAdapter(adapter);
            Toast.makeText(this, "Edit successed", Toast.LENGTH_SHORT).show();
        }else{
            Toast.makeText(this, "Fail", Toast.LENGTH_SHORT).show();
        }
    }

    public String getIndex() {
        return index;
    }
}
