package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.connection.SetupConnection;

/**
 * Servlet implementation class AgentNames
 */
@WebServlet("/AgentNames")
public class AgentNames extends HttpServlet {
    private static final long serialVersionUID = 1L;
    static final String DRIVER_URl = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL = "192.168.84.20:1521:sitep";

    static final String USER = "read";
    static final String PASS = "read";

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String agentQuery = "select distinct(CLASS_NAME) from SUM_INFO order by CLASS_NAME";
        PrintWriter out = response.getWriter();
        SetupConnection setupConnection = new SetupConnection();
        try {
            Connection con = setupConnection.returnConnection(DRIVER_URl, DB_URL, USER, PASS);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(agentQuery);
            while (rs.next()) {
                out.println(rs.getString("CLASS_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
