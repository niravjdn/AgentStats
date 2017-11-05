package com.javaclass;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;

import com.connection.SetupConnection;


public class DataFetcherForGraph {

    static final String DRIVER_URl = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL = "192.168.84.20:1521:sitep";

    static final String USER = "read";
    static final String PASS = "read";

    public static void main(String[] args) {
        DataFetcherForGraph df = new DataFetcherForGraph();
        GraphsArray ga = df.getRS("FirstTechBank,Vectra", 20, "PROD", "");
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
    }

    public GraphsArray getRS(String agentName, int numOfDays, String platform, String pushedDate) {
        ArrayList<Arrays> rsArr = new ArrayList<Arrays>();
        StatProperties[] statProp = new StatProperties[3];
        Connection conn = null;
        PreparedStatement stmt1 = null;
        PreparedStatement stmt2 = null;
        PreparedStatement stmt3 = null;
        GraphsArray ga = null;

        String[] agentNames = agentName.split(",");


        for (int i = 0; i < agentNames.length; i++)
            System.out.println(agentNames[i]);

        String queryPFM = "SELECT class_name ,  TO_CHAR (TIMESTAMP, 'MM-dd-yyyy') AS time_Stamp,\r\n" +
                "    SUM(num_errors) AS TOTAL_REQ,\r\n" +
                "    ROUND (SUM(ss.num_errors*AVG_SCRIPT_LATENCY)/SUM(ss.num_errors))/1000 AS SCRIPT_LATENCY,\r\n" +
                "    ROUND(SUM(DECODE(TYPE_OF_ERROR, 0,num_errors,433,num_errors,473,num_errors,474,num_errors,801,num_errors,0)*100)/ SUM(num_errors) , 2) AS SUCCESS,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 403,num_errors,408,num_errors,413,num_errors,419,num_errors,439,num_errors,444,num_errors,449,num_errors,450,num_errors,453,num_errors, 475,num_errors,476,num_errors,477,num_errors,478,num_errors,479,num_errors,491,num_errors,492,num_errors,493,num_errors,494,num_errors, 495,num_errors,496,num_errors,497,num_errors,498,num_errors,507,num_errors,513,num_errors,514,num_errors,707,num_errors,708,num_errors, 709,num_errors,517,num_errors,0)*100)/ SUM(num_errors) , 2) AS AGENT_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 401,num_errors,409,num_errors,410,num_errors,412,num_errors,415,num_errors,416,num_errors,418,num_errors,424,num_errors,425,num_errors, 426,num_errors,431,num_errors,432,num_errors,447,num_errors,448,num_errors,1012,num_errors,0)*100) / SUM(num_errors) , 2) AS SITE_ERR,\r\n" +
                "    ROUND (SUM(DECODE(TYPE_OF_ERROR, 402,num_errors,406,num_errors,407,num_errors,411,num_errors,414,num_errors,417,num_errors,420,num_errors,421,num_errors,422,num_errors, 423,num_errors,427,num_errors,428,num_errors,429,num_errors,430,num_errors,434,num_errors,435,num_errors,436,num_errors,437,num_errors, 438,num_errors,440,num_errors,441,num_errors,442,num_errors,443,num_errors,445,num_errors,446,num_errors,451,num_errors,452,num_errors, 454,num_errors,455,num_errors,456,num_errors,457,num_errors,458,num_errors,459,num_errors,460,num_errors,461,num_errors,462,num_errors, 463,num_errors,464,num_errors,465,num_errors,466,num_errors,467,num_errors,468,num_errors,469,num_errors,470,num_errors,471,num_errors, 472,num_errors,480,num_errors,481,num_errors,482,num_errors,483,num_errors,484,num_errors,485,num_errors,486,num_errors,510,num_errors, 511,num_errors,512,num_errors,515,num_errors,516,num_errors,604,num_errors,605,num_errors,701,num_errors,702,num_errors,703,num_errors, 704,\r\n" +
                "    num_errors,705,num_errors,706,num_errors,1000,num_errors,1001,num_errors,1002,num_errors,1003,num_errors,1004,num_errors,1005,num_errors, 1006,num_errors,1007,num_errors,1008,num_errors,1009,num_errors,1010,num_errors,1011,num_errors,1013,num_errors,505,num_errors,506,num_errors, 509,num_errors,518,num_errors,519,num_errors,520,num_errors,521,num_errors,522,num_errors,523,num_errors,524,num_errors,526,num_errors,0))*100 / SUM(num_errors) , 2) AS UAR_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 200,num_errors,201,num_errors,202,num_errors,300,num_errors,303,num_errors,400,num_errors,404,num_errors,508,num_errors,600,num_errors,602,num_errors, 603,num_errors,601,num_errors,525,num_errors,0))*100 / SUM(num_errors) , 2) AS INFRA_ERR,\r\n" +
                "    round (sum(ss.num_errors*AVG_NUM_OF_NAVIGATIONS)/sum(ss.num_errors),1) as num_of_navigations\r\n" +
                "  From Site_Stats_Suminfo Ss, Sum_Info S\r\n" +
                "  WHERE TIMESTAMP   > sysdate - ? \r\n" +
                "  And S.Sum_Info_Id = Ss.Sum_Info_Id\r\n" +
                "  And S.Class_Name In (?)\r\n" +
                "AND ss.server_type in ('I','C')\r\n" +
                "  GROUP BY s.class_name,\r\n" +
                "    TO_CHAR (TIMESTAMP, 'MM-dd-yyyy')\r\n" +
                "  Order By 1,2 \r\n";

        String queryIAV = "SELECT class_name ,  TO_CHAR (TIMESTAMP, 'MM-dd-yyyy') AS time_Stamp,\r\n" +
                "    SUM(num_errors) AS TOTAL_REQ,\r\n" +
                "    ROUND (SUM(ss.num_errors*AVG_SCRIPT_LATENCY)/SUM(ss.num_errors))/1000 AS SCRIPT_LATENCY,\r\n" +
                "    ROUND(SUM(DECODE(TYPE_OF_ERROR, 0,num_errors,433,num_errors,473,num_errors,474,num_errors,801,num_errors,0)*100)/ SUM(num_errors) , 2) AS SUCCESS,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 403,num_errors,408,num_errors,413,num_errors,419,num_errors,439,num_errors,444,num_errors,449,num_errors,450,num_errors,453,num_errors, 475,num_errors,476,num_errors,477,num_errors,478,num_errors,479,num_errors,491,num_errors,492,num_errors,493,num_errors,494,num_errors, 495,num_errors,496,num_errors,497,num_errors,498,num_errors,507,num_errors,513,num_errors,514,num_errors,707,num_errors,708,num_errors, 709,num_errors,517,num_errors,0)*100)/ SUM(num_errors) , 2) AS AGENT_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 401,num_errors,409,num_errors,410,num_errors,412,num_errors,415,num_errors,416,num_errors,418,num_errors,424,num_errors,425,num_errors, 426,num_errors,431,num_errors,432,num_errors,447,num_errors,448,num_errors,1012,num_errors,0)*100) / SUM(num_errors) , 2) AS SITE_ERR,\r\n" +
                "    ROUND (SUM(DECODE(TYPE_OF_ERROR, 402,num_errors,406,num_errors,407,num_errors,411,num_errors,414,num_errors,417,num_errors,420,num_errors,421,num_errors,422,num_errors, 423,num_errors,427,num_errors,428,num_errors,429,num_errors,430,num_errors,434,num_errors,435,num_errors,436,num_errors,437,num_errors, 438,num_errors,440,num_errors,441,num_errors,442,num_errors,443,num_errors,445,num_errors,446,num_errors,451,num_errors,452,num_errors, 454,num_errors,455,num_errors,456,num_errors,457,num_errors,458,num_errors,459,num_errors,460,num_errors,461,num_errors,462,num_errors, 463,num_errors,464,num_errors,465,num_errors,466,num_errors,467,num_errors,468,num_errors,469,num_errors,470,num_errors,471,num_errors, 472,num_errors,480,num_errors,481,num_errors,482,num_errors,483,num_errors,484,num_errors,485,num_errors,486,num_errors,510,num_errors, 511,num_errors,512,num_errors,515,num_errors,516,num_errors,604,num_errors,605,num_errors,701,num_errors,702,num_errors,703,num_errors, 704,\r\n" +
                "    num_errors,705,num_errors,706,num_errors,1000,num_errors,1001,num_errors,1002,num_errors,1003,num_errors,1004,num_errors,1005,num_errors, 1006,num_errors,1007,num_errors,1008,num_errors,1009,num_errors,1010,num_errors,1011,num_errors,1013,num_errors,505,num_errors,506,num_errors, 509,num_errors,518,num_errors,519,num_errors,520,num_errors,521,num_errors,522,num_errors,523,num_errors,524,num_errors,526,num_errors,0))*100 / SUM(num_errors) , 2) AS UAR_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 200,num_errors,201,num_errors,202,num_errors,300,num_errors,303,num_errors,400,num_errors,404,num_errors,508,num_errors,600,num_errors,602,num_errors, 603,num_errors,601,num_errors,525,num_errors,0))*100 / SUM(num_errors) , 2) AS INFRA_ERR,\r\n" +
                "    round (sum(ss.num_errors*AVG_NUM_OF_NAVIGATIONS)/sum(ss.num_errors),1) as num_of_navigations\r\n" +
                "  From Site_Stats_Suminfo Ss, Sum_Info S\r\n" +
                "  WHERE TIMESTAMP   > sysdate - ? \r\n" +
                "  And S.Sum_Info_Id = Ss.Sum_Info_Id\r\n" +
                "  And S.Class_Name In (?)\r\n" +
                "AND ss.server_type in ('V')\r\n" +
                "  GROUP BY s.class_name,\r\n" +
                "    TO_CHAR (TIMESTAMP, 'MM-dd-yyyy')\r\n" +
                "  Order By 1,2 \r\n";

        String queryYcom = "SELECT class_name ,  TO_CHAR (TIMESTAMP, 'MM-dd-yyyy') AS time_Stamp,\r\n" +
                "    SUM(num_errors) AS TOTAL_REQ,\r\n" +
                "    ROUND (SUM(ss.num_errors*AVG_SCRIPT_LATENCY)/SUM(ss.num_errors))/1000 AS SCRIPT_LATENCY,\r\n" +
                "    ROUND(SUM(DECODE(TYPE_OF_ERROR, 0,num_errors,433,num_errors,473,num_errors,474,num_errors,801,num_errors,0)*100)/ SUM(num_errors) , 2) AS SUCCESS,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 403,num_errors,408,num_errors,413,num_errors,419,num_errors,439,num_errors,444,num_errors,449,num_errors,450,num_errors,453,num_errors, 475,num_errors,476,num_errors,477,num_errors,478,num_errors,479,num_errors,491,num_errors,492,num_errors,493,num_errors,494,num_errors, 495,num_errors,496,num_errors,497,num_errors,498,num_errors,507,num_errors,513,num_errors,514,num_errors,707,num_errors,708,num_errors, 709,num_errors,517,num_errors,0)*100)/ SUM(num_errors) , 2) AS AGENT_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 401,num_errors,409,num_errors,410,num_errors,412,num_errors,415,num_errors,416,num_errors,418,num_errors,424,num_errors,425,num_errors, 426,num_errors,431,num_errors,432,num_errors,447,num_errors,448,num_errors,1012,num_errors,0)*100) / SUM(num_errors) , 2) AS SITE_ERR,\r\n" +
                "    ROUND (SUM(DECODE(TYPE_OF_ERROR, 402,num_errors,406,num_errors,407,num_errors,411,num_errors,414,num_errors,417,num_errors,420,num_errors,421,num_errors,422,num_errors, 423,num_errors,427,num_errors,428,num_errors,429,num_errors,430,num_errors,434,num_errors,435,num_errors,436,num_errors,437,num_errors, 438,num_errors,440,num_errors,441,num_errors,442,num_errors,443,num_errors,445,num_errors,446,num_errors,451,num_errors,452,num_errors, 454,num_errors,455,num_errors,456,num_errors,457,num_errors,458,num_errors,459,num_errors,460,num_errors,461,num_errors,462,num_errors, 463,num_errors,464,num_errors,465,num_errors,466,num_errors,467,num_errors,468,num_errors,469,num_errors,470,num_errors,471,num_errors, 472,num_errors,480,num_errors,481,num_errors,482,num_errors,483,num_errors,484,num_errors,485,num_errors,486,num_errors,510,num_errors, 511,num_errors,512,num_errors,515,num_errors,516,num_errors,604,num_errors,605,num_errors,701,num_errors,702,num_errors,703,num_errors, 704,\r\n" +
                "    num_errors,705,num_errors,706,num_errors,1000,num_errors,1001,num_errors,1002,num_errors,1003,num_errors,1004,num_errors,1005,num_errors, 1006,num_errors,1007,num_errors,1008,num_errors,1009,num_errors,1010,num_errors,1011,num_errors,1013,num_errors,505,num_errors,506,num_errors, 509,num_errors,518,num_errors,519,num_errors,520,num_errors,521,num_errors,522,num_errors,523,num_errors,524,num_errors,526,num_errors,0))*100 / SUM(num_errors) , 2) AS UAR_ERR,\r\n" +
                "    ROUND( SUM(DECODE(TYPE_OF_ERROR, 200,num_errors,201,num_errors,202,num_errors,300,num_errors,303,num_errors,400,num_errors,404,num_errors,508,num_errors,600,num_errors,602,num_errors, 603,num_errors,601,num_errors,525,num_errors,0))*100 / SUM(num_errors) , 2) AS INFRA_ERR,\r\n" +
                "    round (sum(ss.num_errors*AVG_NUM_OF_NAVIGATIONS)/sum(ss.num_errors),1) as num_of_navigations\r\n" +
                "  From Site_Stats_Suminfo Ss, Sum_Info S\r\n" +
                "  WHERE TIMESTAMP   > sysdate - ? \r\n" +
                "  And S.Sum_Info_Id = Ss.Sum_Info_Id\r\n" +
                "  And S.Class_Name In (?)\r\n" +
                "AND ss.server_type in ('I','C')\r\n"
                + "AND ss.cobrand_id in ('10000004')\r\n" +
                "  GROUP BY s.class_name,\r\n" +
                "    TO_CHAR (TIMESTAMP, 'MM-dd-yyyy')\r\n" +
                "  Order By 1,2 \r\n";

        try {
            SetupConnection setupConnection = new SetupConnection();
            conn = setupConnection.returnConnection(DRIVER_URl, DB_URL, USER, PASS);
            System.out.println("Connected database successfully...");

            System.out.println("Creating statement...");
            System.out.println("Creating statement..." + platform);
            if (platform.equals("PROD")) {

                String PFMGraph[] = new String[agentNames.length];
                String IAVGraph[] = new String[agentNames.length];

                for (int i = 0; i < agentNames.length; i++) {

		    		  /*stmt1 =  conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				      stmt2 =  conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				      */
                    stmt1 = conn.prepareStatement(queryPFM);
                    stmt2 = conn.prepareStatement(queryIAV);
                    stmt1.setInt(1, numOfDays);
                    stmt1.setString(2, agentNames[i]);

                    ResultSet rsPFM = stmt1.executeQuery();
                    PFMGraph[i] = "";

                    System.out.println("-------------------PFM-----------------");
                    while (rsPFM.next()) {
                        String className = rsPFM.getString("CLASS_NAME");
                        String timeStamp = rsPFM.getString("TIME_STAMP");
                        double totalRequest = rsPFM.getInt("TOTAL_REQ");
                        double scriptLatency = rsPFM.getDouble("SCRIPT_LATENCY");
                        double successRate = rsPFM.getDouble("SUCCESS");
                        double agentError = rsPFM.getDouble("AGENT_ERR");
                        double siteError = rsPFM.getDouble("SITE_ERR");
                        double uarError = rsPFM.getDouble("UAR_ERR");
                        double infraError = rsPFM.getDouble("INFRA_ERR");
                        double num_of_navigations = rsPFM.getInt("NUM_OF_NAVIGATIONS");
                        PFMGraph[i] += "[\"" + timeStamp + "\"," + successRate + "," + scriptLatency + "," + agentError + "," + uarError + "," + siteError + "," + infraError + "],";

                        //System.out.println(PFMGraph[i]);
				    	 /* System.out.println(className+" "+timeStamp+" "+scriptLatency+" "+totalRequest+" "+successRate+" "+agentError+" "+
				    	  siteError+" "+uarError+" "+infraError+" "+num_of_navigations);*/
                    }

                    stmt2.setInt(1, numOfDays);
                    stmt2.setString(2, agentNames[i]);

                    ResultSet rsIAV = stmt2.executeQuery();
                    IAVGraph[i] = "";
                    System.out.println("-----------------IAV-------------------");
                    while (rsIAV.next()) {
                        String className = rsIAV.getString("CLASS_NAME");
                        String timeStamp = rsIAV.getString("TIME_STAMP");
                        int totalRequest = rsIAV.getInt("TOTAL_REQ");
                        double scriptLatency = rsIAV.getDouble("SCRIPT_LATENCY");
                        int successRate = rsIAV.getInt("SUCCESS");
                        int agentError = rsIAV.getInt("AGENT_ERR");
                        int siteError = rsIAV.getInt("SITE_ERR");
                        int uarError = rsIAV.getInt("UAR_ERR");
                        int infraError = rsIAV.getInt("INFRA_ERR");
                        int num_of_navigations = rsIAV.getInt("NUM_OF_NAVIGATIONS");
                        IAVGraph[i] += "[\"" + timeStamp + "\"," + successRate + "," + scriptLatency + "," + agentError + "," + uarError + "," + siteError + "," + infraError + "],";
				    	/*  System.out.println(className+" "+timeStamp+" "+scriptLatency+" "+totalRequest+" "+successRate+" "+agentError+" "+
				    	  siteError+" "+uarError+" "+infraError+" "+num_of_navigations);*/
                    }
                    ga = new GraphsArray(PFMGraph, IAVGraph);
                }
            } else {
                String PFMGraph[] = new String[agentNames.length];
                String IAVGraph[] = new String[agentNames.length];

                for (int i = 0; i < agentNames.length; i++) {
                    //stmt3 =  conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                    stmt3 = conn.prepareStatement(queryYcom);
                    stmt3.setInt(1, numOfDays);
                    stmt3.setString(2, agentNames[i]);
                    ResultSet rsYcom = stmt3.executeQuery();
                    PFMGraph[i] = "";
                    System.out.println("----------------Y.COM---------------------");
                    while (rsYcom.next()) {
                        String className = rsYcom.getString("CLASS_NAME");
                        String timeStamp = rsYcom.getString("TIME_STAMP");
                        int totalRequest = rsYcom.getInt("TOTAL_REQ");
                        double scriptLatency = rsYcom.getDouble("SCRIPT_LATENCY");
                        int successRate = rsYcom.getInt("SUCCESS");
                        int agentError = rsYcom.getInt("AGENT_ERR");
                        int siteError = rsYcom.getInt("SITE_ERR");
                        int uarError = rsYcom.getInt("UAR_ERR");
                        int infraError = rsYcom.getInt("INFRA_ERR");
                        int num_of_navigations = rsYcom.getInt("NUM_OF_NAVIGATIONS");
                        PFMGraph[i] += "[\"" + timeStamp + "\"," + successRate + "," + scriptLatency + "," + agentError + "," + uarError + "," + siteError + "," + infraError + "],";
				    	  /*System.out.println(className+" "+timeStamp+" "+scriptLatency+" "+totalRequest+" "+successRate+" "+agentError+" "+
				    	  siteError+" "+uarError+" "+infraError+" "+num_of_navigations);*/
                    }
                }
                ga = new GraphsArray(PFMGraph, IAVGraph);
            }
        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error Occured");
        } finally {

        }
        return ga;
    }
}
