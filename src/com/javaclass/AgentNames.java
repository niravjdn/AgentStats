package com.javaclass;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.connection.SetupConnection;

public class AgentNames {
    static final String DRIVER_URl = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL = "192.168.84.20:1521:sitep";

    static final String USER = "read";
    static final String PASS = "read";

    public static void main(String[] args) throws Exception {
        String agentQuery = "select distinct(CLASS_NAME) from SUM_INFO order by CLASS_NAME";
        SetupConnection setupConnection = new SetupConnection();
        Connection con = setupConnection.returnConnection(DRIVER_URl, DB_URL, USER, PASS);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(agentQuery);
        while (rs.next()) {
            System.out.println(rs.getString("CLASS_NAME"));
        }
    }

}
