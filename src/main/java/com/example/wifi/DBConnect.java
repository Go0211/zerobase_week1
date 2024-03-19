package com.example.wifi;

import java.sql.*;

public class DBConnect {
    public static Connection getConnection() throws SQLException {
        try{
            String dbURL = "jdbc:mysql://localhost:3306/wifi_service";
            String dbID = "root";
            String dbPW = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(dbURL,dbID,dbPW);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
