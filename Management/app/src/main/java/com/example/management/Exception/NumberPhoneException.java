package com.example.management.Exception;

import androidx.annotation.Nullable;

public class NumberPhoneException extends Exception{
    public NumberPhoneException(String message){
        super(message);
    }

    @Nullable
    @Override
    public String getMessage() {
        return "Number phone"+ super.getMessage();
    }
}
