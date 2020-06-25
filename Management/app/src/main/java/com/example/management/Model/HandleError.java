package com.example.management.Model;

import com.example.management.Exception.EmptyException;
import com.example.management.Exception.NumberPhoneException;

public class HandleError {

    public static boolean isEmpty(String name, String id, String className, String phone, String info) throws EmptyException {
        if(name.equals("") || id.equals("") || className.equals("") || phone.equals("") || info.equals("")){
            throw new EmptyException("invalid");
        }
        return true;
    }

    public static boolean isNumberPhone(String phone) throws NumberPhoneException {
        try {
            Integer.parseInt(phone);
            return true;
        }catch (NumberFormatException ex){
            throw new NumberPhoneException("invalid");
        }
    }
}
