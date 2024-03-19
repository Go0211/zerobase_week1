package com.example.wifi;

import lombok.*;

import java.time.LocalDateTime;

//@Getter
//@Setter   ? 왜 안되냐...
public class Wifi {
    int num;
    Double km;
    String management_number;
    String autonomous_region;
    String wifi_name;
    String road_name_address;
    String detail_address;
    String install_floor;
    String install_type;
    String install_organization;
    String service_division;
    String net_kind;
    String install_date;
    String input_output;
    String wifi_environment;
    Double x_coordinates;
    Double y_coordinates;
    LocalDateTime work_date;

    public int getNum() {
        return num;
    }

    public Double getKm() {
        return km;
    }

    public String getManagement_number() {
        return management_number;
    }

    public String getAutonomous_region() {
        return autonomous_region;
    }

    public String getWifi_name() {
        return wifi_name;
    }

    public String getRoad_name_address() {
        return road_name_address;
    }

    public String getDetail_address() {
        return detail_address;
    }

    public String getInstall_floor() {
        return install_floor;
    }

    public String getInstall_type() {
        return install_type;
    }

    public String getInstall_organization() {
        return install_organization;
    }

    public String getService_division() {
        return service_division;
    }

    public String getNet_kind() {
        return net_kind;
    }

    public String getInstall_date() {
        return install_date;
    }

    public String getInput_output() {
        return input_output;
    }

    public String getWifi_environment() {
        return wifi_environment;
    }

    public Double getX_coordinates() {
        return x_coordinates;
    }

    public Double getY_coordinates() {
        return y_coordinates;
    }

    public LocalDateTime getWork_date() {
        return work_date;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public void setKm(Double km) {
        this.km = km;
    }

    public void setManagement_number(String management_number) {
        this.management_number = management_number;
    }

    public void setAutonomous_region(String autonomous_region) {
        this.autonomous_region = autonomous_region;
    }

    public void setWifi_name(String wifi_name) {
        this.wifi_name = wifi_name;
    }

    public void setRoad_name_address(String road_name_address) {
        this.road_name_address = road_name_address;
    }

    public void setDetail_address(String detail_address) {
        this.detail_address = detail_address;
    }

    public void setInstall_floor(String install_floor) {
        this.install_floor = install_floor;
    }

    public void setInstall_type(String install_type) {
        this.install_type = install_type;
    }

    public void setInstall_organization(String install_organization) {
        this.install_organization = install_organization;
    }

    public void setService_division(String service_division) {
        this.service_division = service_division;
    }

    public void setNet_kind(String net_kind) {
        this.net_kind = net_kind;
    }

    public void setInstall_date(String install_date) {
        this.install_date = install_date;
    }

    public void setInput_output(String input_output) {
        this.input_output = input_output;
    }

    public void setWifi_environment(String wifi_environment) {
        this.wifi_environment = wifi_environment;
    }

    public void setX_coordinates(Double x_coordinates) {
        this.x_coordinates = x_coordinates;
    }

    public void setY_coordinates(Double y_coordinates) {
        this.y_coordinates = y_coordinates;
    }

    public void setWork_date(LocalDateTime work_date) {
        this.work_date = work_date;
    }

}
