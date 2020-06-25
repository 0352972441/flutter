package com.example.management.Exception;

import androidx.annotation.Nullable;

public class EmptyException extends Exception{
    public EmptyException(String message){
        super(message);
    }

    @Nullable
    @Override
    public String getMessage() {
        return "Empty:"+super.getMessage();
    }
}
