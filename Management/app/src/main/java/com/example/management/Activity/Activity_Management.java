package com.example.management.Activity;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.management.R;
public class Activity_Management extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity__management);
    }

    public void classManager(View view){
        Button button = (Button)view;
        Intent intent = new Intent(this, Activity_Class.class);
        startActivity(intent);
    }

    public void studentManager(View view){
        Button button = (Button)findViewById(R.id.btstudent);
        Intent intent = new Intent(this, StudentActivity.class);
        startActivity(intent);
    }
}
