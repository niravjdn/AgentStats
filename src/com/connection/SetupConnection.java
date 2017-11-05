package com.connection;

import java.sql.*;

public class SetupConnection {
    public static Connection returnConnection(String DriverUrl, String DBUrl, String userName, String password)
            throws ClassNotFoundException, SQLException {
        Class.forName(DriverUrl);
        System.out.println("Connecting to a selected database...");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@" + DBUrl, userName, password);
        return conn;
    }
}
