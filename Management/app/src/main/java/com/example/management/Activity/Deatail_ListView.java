package com.example.management.Activity;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.media.Image;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.management.Exception.NumberPhoneException;
import com.example.management.Model.HandleError;
import com.example.management.Model.StudentManagerDao;
import com.example.management.R;

import java.util.zip.Inflater;

public class Deatail_ListView extends AppCompatActivity {
    public static final String KEYNAME = "keyName";
    public static final String KEYCLASS = "keyClass";
    public static final String KEYPHONE = "keyPhone";
    public static final String KEYID = "keyId";
    public static final String KEYEXTRA = "keyExtra";
    String phoneNumber;
    String index;
    EditText name, className;
    EditText phone;
    StudentManagerDao dao;
    ImageButton call, messages;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_deatail__list_view);
        dao = new StudentManagerDao(this);
        phone = (EditText)findViewById(R.id.phone);
        name = (EditText)findViewById(R.id.title);
        className = (EditText)findViewById(R.id.className);
        call = (ImageButton)findViewById(R.id.call);
        messages = (ImageButton)findViewById(R.id.messages);
        setUpContact();
    }

    private void setUpContact(){
        Bundle bundle = getIntent().getExtras().getBundle(KEYEXTRA);
        String name = bundle.getString(KEYNAME);
        phoneNumber = bundle.getString(KEYPHONE);
        String className = bundle.getString(KEYCLASS);
        index = bundle.getString(KEYID);
        this.name.setText(name);
        this.phone.setText(phoneNumber);
        this.className.setText(className);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if(item.getItemId() == R.id.remote){
            dao.remote(index);
            finish();
        }else if(item.getItemId() == R.id.save){
            String name = this.name.getText().toString();
            String className = this.className.getText().toString();
            String phone = this.phone.getText().toString();
            try {
                if (HandleError.isNumberPhone(phone)) {
                    dao.update(index, name, phone, className);
                    finish();
                }
            }catch (NumberPhoneException ex){
                Toast.makeText(this, "invalid phone number", Toast.LENGTH_SHORT).show();
            }
        }
        return super.onOptionsItemSelected(item);
    }

    public void editContact(View view){
        ImageView imageView = (ImageView) view;
        switch (imageView.getId()){
            case R.id.editCall:
                phone.setEnabled(true);
                name.setEnabled(false);
                className.setEnabled(false);
                break;
            case R.id.edit:
                name.setEnabled(true);
                className.setEnabled(false);
                phone.setEnabled(false);
                break;
            case R.id.editClass:
                className.setEnabled(true);
                phone.setEnabled(false);
                name.setEnabled(false);
                break;
            default:
                break;
        }

    }

    public void callPhone(View view){
        String dial = "tel:"+phoneNumber;
        Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse(dial));
        startActivity(intent);
    }

    public void messages(View view){
        Toast.makeText(this, "Thank everyone !", Toast.LENGTH_SHORT).show();
    }

}
