package com.example.wifi;

import java.time.LocalDateTime;

public class LocationHistory {
    int num;
    Double lat;
    Double lnt;
    String workDate;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLnt() {
        return lnt;
    }

    public void setLnt(Double lnt) {
        this.lnt = lnt;
    }

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }

}
