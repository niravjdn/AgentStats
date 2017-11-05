package com.servlets;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javaclass.DataFetcherForGraph;
import com.javaclass.GraphsArray;

@WebServlet("/FindStatsForGraph")
public class FindStatsForGraph extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String agentName = request.getParameter("agentName");
        int numOfDays = Integer.parseInt(request.getParameter("numOfDays"));
        String whichPlatform = request.getParameter("whichPlatform");
        String pushedDate = request.getParameter("pushedDate");
        System.out.println("pushedDate" + pushedDate);
        System.out.println(whichPlatform);
        DataFetcherForGraph df = new DataFetcherForGraph();

        GraphsArray ga = df.getRS(agentName, numOfDays, whichPlatform, pushedDate);

        String[] agentNames = agentName.split(",");

        request.setAttribute("agentNames", agentNames);

        String[] a = ga.PFMGraph;
        System.out.println("pfm");
        for (int i = 0; i < a.length; i++) {
            System.out.println(a[i]);
        }
        a = ga.IAVGraph;
        System.out.println("iav");
        for (int i = 0; i < a.length; i++) {
            System.out.println(a[i]);
        }

        if (ga != null) {
            request.setAttribute("ga", ga);
            if (whichPlatform.equals("PROD")) {
                request.getRequestDispatcher("/showdataPRODGraph").forward(request, response);
            } else {
                request.getRequestDispatcher("/showdataYcomGraph").forward(request, response);
            }
        } else {
            System.out.println("Error Occured! Please retry.");
        }
    }

}
