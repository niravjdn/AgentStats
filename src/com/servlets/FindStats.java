package com.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javaclass.DataFetcher;

@WebServlet("/FindStats")
public class FindStats extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String agentName = request.getParameter("agentName");
        int numOfDays = Integer.parseInt(request.getParameter("numOfDays"));
        String whichPlatform = request.getParameter("whichPlatform");
        String pushedDate = request.getParameter("pushedDate");
        System.out.println("pushedDate" + pushedDate);
        System.out.println(whichPlatform);
        DataFetcher df = new DataFetcher();
        agentName = agentName.replaceAll(",", "','");
        ArrayList<ResultSet> rsArr = df.getRS(agentName, numOfDays, whichPlatform, pushedDate);
        if (!rsArr.isEmpty()) {
            request.setAttribute("rsArr", rsArr);
            if (whichPlatform.equals("PROD")) {
                request.getRequestDispatcher("/showdataPROD").forward(request, response);
            } else {
                request.getRequestDispatcher("/showdataYcom").forward(request, response);
            }
        } else {
            System.out.println("Error Occured! Please retry.");
        }
    }

}
