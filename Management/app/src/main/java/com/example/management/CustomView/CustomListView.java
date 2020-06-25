package com.example.management.CustomView;

import android.content.Context;
import android.media.Image;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import com.example.management.Model.DetailStudent;
import com.example.management.R;
import java.util.ArrayList;


public class CustomListView extends BaseAdapter {
    ArrayList<DetailStudent> listData;
    Context context;
    LayoutInflater inflater;
    public CustomListView(ArrayList<DetailStudent> listData, Context context) {
        this.listData = listData;
        this.context = context;
        inflater = (LayoutInflater)context.getSystemService(context.LAYOUT_INFLATER_SERVICE);
    }

    @Override
    public int getCount() {
        return listData.size();
    }

    @Override
    public Object getItem(int position) {
        return listData.get(position);
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        if(convertView == null){
            //convertView = LayoutInflater.from(parent.getContext()).inflate(R.layout.customsview, parent);
            convertView = inflater.inflate(R.layout.customsview, null);
            holder = new ViewHolder();
            holder.title = (TextView)convertView.findViewById(R.id.title);
            holder.subTitle = (TextView)convertView.findViewById(R.id.subTitle);
            holder.phone = (TextView)convertView.findViewById(R.id.phone);
            holder.className = (TextView)convertView.findViewById(R.id.major);
            convertView.setTag(holder);
        }else{
            holder = (ViewHolder) convertView.getTag();
        }
        holder.title.setText(listData.get(position).getName());
        //holder.subTitle.setText(listData.get(position).getId());
        holder.subTitle.setText(listData.get(position).getInfo());
        holder.phone.setText(listData.get(position).getPhone());
        holder.className.setText(listData.get(position).getClassName());
        return convertView;
    }

    static class ViewHolder{
        TextView phone;
        TextView title;
        TextView subTitle;
        TextView className;
    }
}
