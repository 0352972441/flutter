package com.example.management;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;

import com.example.management.Activity.Activity_Management;

public class MainActivity extends AppCompatActivity {
    CheckBox isCheck;
    TextView user;
    TextView password ;
    private static final String NAMEFILE = "account";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        user = (TextView)findViewById(R.id.user);
        password = (TextView)findViewById(R.id.password);
        isCheck = (CheckBox)findViewById(R.id.rememberlogin);
        if(loadRememberLogin()){
            Intent intent = new Intent(this, Activity_Management.class);
            startActivity(intent);
        }
    }

    private void savePreferences(String user, String password, boolean isCheck){
        SharedPreferences sharedPreferences = getSharedPreferences(NAMEFILE,MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        if(!isCheck){
            editor.clear();
        }else{
            editor.putString("userName",user);
            editor.putString("password",password);
            editor.putBoolean("isCheck",isCheck);
        }
        editor.commit();
    }

    private boolean loadRememberLogin(){
        SharedPreferences sharedPreferences = getSharedPreferences(NAMEFILE,MODE_PRIVATE);
        boolean ischeck = sharedPreferences.getBoolean("isCheck",false);
        if(ischeck){
            return  true;
        }
        return false;
    }

    public void reset(View view){
        user.setText("");
        password.setText("");
    }

    public void login(View view){
        if(checkLogin()){
            Toast.makeText(this, "Login", Toast.LENGTH_SHORT).show();
            savePreferences(user.getText().toString(),password.getText().toString(),isCheck.isChecked());
            Intent intent = new Intent(this, Activity_Management.class);
            startActivity(intent);
        }else{
            Toast.makeText(this, "Login fail", Toast.LENGTH_SHORT).show();
        }
    }

    private boolean checkLogin(){
        return (user.getText().toString().equals("admin") && password.getText().toString().equals("admin"));
    }
}
