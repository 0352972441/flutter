package com.example.management.Activity;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import com.example.management.CustomView.CustomListView;
import com.example.management.Model.DetailStudent;
import com.example.management.Model.StudentManagerDao;
import com.example.management.R;

import java.util.ArrayList;

public class ListInfo extends AppCompatActivity {
    ArrayList<DetailStudent> listData = null;
    ListView listView = null;
    StudentManagerDao dao = null;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_info);
        listData = new ArrayList<>();
        dao = new StudentManagerDao(this);
        listView = (ListView) findViewById(R.id.listInfo);
    }

    @Override
    protected void onResume() {
        super.onResume();
        listData = new ArrayList<>();
        dao = new StudentManagerDao(this);
        listView = (ListView) findViewById(R.id.listInfo);
        Toast.makeText(this, "Running", Toast.LENGTH_SHORT).show();
        listData = dao.getAll();
        CustomListView customListView = new CustomListView(listData, this);
        listView.setAdapter(customListView);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Bundle bundle = new Bundle();
                String name = listData.get(position).getName();
                String phone = listData.get(position).getPhone();
                String className = listData.get(position).getClassName();
                String index = listData.get(position).getId();
                bundle.putString(Deatail_ListView.KEYNAME, name);
                bundle.putString(Deatail_ListView.KEYID, index);
                bundle.putString(Deatail_ListView.KEYPHONE, phone);
                bundle.putString(Deatail_ListView.KEYCLASS, className);
                Intent intent = new Intent(ListInfo.this, Deatail_ListView.class);
                intent.putExtra(Deatail_ListView.KEYEXTRA, bundle);
                startActivity(intent);
            }
        });
    }


}
