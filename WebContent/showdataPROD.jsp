<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.sql.ResultSetMetaData" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon"
          href="${pageContext.request.contextPath}/icons/favicon.ico">

    <title>AgentStats</title>

    <link href="${pageContext.request.contextPath}/css/bootstrap.css"
          rel="stylesheet">

    <link href="${pageContext.request.contextPath}/css/top-navbar.css"
          rel="stylesheet">
</head>

<body>

<nav
        class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
    <button class="navbar-toggler navbar-toggler-right" type="button"
            data-toggle="collapse" data-target="#navbarCollapse"
            aria-controls="navbarCollapse" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#">Agent Stat</a>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <!-- <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li> -->
        </ul>

    </div>
</nav>

<div class="container">
    <%
        ArrayList<ResultSet> rsArr = (ArrayList) request.getAttribute("rsArr");
        ResultSet rsPFM = rsArr.get(0);
        ResultSet rsIAV = rsArr.get(1);
        String pushedDate = request.getParameter("pushedDate");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat source = new SimpleDateFormat("MM-dd-yyyy");
        Date date1 = sdf.parse(pushedDate);
        Date date2 = sdf.parse("2010-01-31");
        String db_date = "";
    %>

    <input type="button" value="copy" class="btn btn-xs btn-primary"
           onclick="selectElementContents( document.getElementById('byAgentNamePFM') );">

    <table id="byAgentNamePFM" style="margin-bottom: 80px;"
           class="table table-hover table-responsive table-bordered table-striped">

        <tr>
            <th colspan="11" class="titleofPlatform">PFM</th>
        </tr>
        <tr align="center" class="headerofTable">
            <th>CLASS_NAME</th>
            <th>Comments</th>
            <th>TIME_STAMP</th>
            <th>TOTAL_REQ</th>
            <th>SCRIPT_LATENCY</th>
            <th>SUCCESS(%)</th>
            <th>AGENT_ERR(%)</th>
            <th>SITE_ERR(%)</th>
            <th>UAR_ERR(%)</th>
            <th>INFRA_ERR(%)</th>
            <th>NUM_OF_NAVIGATIONS</th>
        </tr>


        <%
            while (rsPFM.next()) {
                db_date = rsPFM.getString("TIME_STAMP");
                db_date = sdf.format(source.parse(db_date));
                date2 = sdf.parse(db_date);
                boolean isAfter = false;

                if (date1.compareTo(date2) > 0) {
                    // out.println("Before changes"); //Date1 is after Date2
                    isAfter = false;
                } else if (date1.compareTo(date2) < 0) {
                    // out.println("After changes"); //Date1 is before Date2
                    isAfter = true;
                } else if (date1.compareTo(date2) == 0) {
                    // out.println("After changes");//Date1 is equal to Date2
                    isAfter = true;
                } else {
                    //out.println("How to get here?");
                }
        %>


        <tr
                <%
                    if (isAfter) {
                        out.println(" style='background-color: rgb(166, 206, 173);'");
                    }
                %>
        >
            <td><%=rsPFM.getString("CLASS_NAME")%>
            </td>
            <td>
                <%
                    if (isAfter)
                        out.println("After Changes");
                    else
                        out.println("Before Changes");
                %>
            </td>
            <td><%=rsPFM.getString("TIME_STAMP")%>
            </td>
            <td><%=rsPFM.getString("TOTAL_REQ")%>
            </td>
            <td><%=rsPFM.getDouble("SCRIPT_LATENCY")%>
            </td>
            <td><%=rsPFM.getDouble("SUCCESS")%>
            </td>
            <td><%=rsPFM.getDouble("AGENT_ERR")%>
            </td>
            <td><%=rsPFM.getDouble("SITE_ERR")%>
            </td>
            <td><%=rsPFM.getDouble("UAR_ERR")%>
            </td>
            <td><%=rsPFM.getDouble("INFRA_ERR")%>
            </td>
            <td><%=rsPFM.getDouble("NUM_OF_NAVIGATIONS")%>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <input type="button" value="copy" class="btn btn-xs btn-primary"
           onclick="selectElementContents( document.getElementById('byAgentNameIAV') );">
    <table id="byAgentNameIAV" style="margin-bottom: 80px;"
           class="table table-hover table-responsive table-bordered table-striped">
        <tr>
            <th colspan="11" class="titleofPlatform">IAV</th>
        </tr>
        <tr align="center" class="headerofTable">
            <th>CLASS_NAME</th>
            <th>Comments</th>
            <th>TIME_STAMP</th>
            <th>TOTAL_REQ</th>
            <th>SCRIPT_LATENCY</th>
            <th>SUCCESS(%)</th>
            <th>AGENT_ERR(%)</th>
            <th>SITE_ERR(%)</th>
            <th>UAR_ERR(%)</th>
            <th>INFRA_ERR(%)</th>
            <th>NUM_OF_NAVIGATIONS</th>
        </tr>

        <%
            while (rsIAV.next()) {
                db_date = rsIAV.getString("TIME_STAMP");
                db_date = sdf.format(source.parse(db_date));
                date2 = sdf.parse(db_date);
                boolean isAfter = false;

                if (date1.compareTo(date2) > 0) {
                    // out.println("Before changes"); //Date1 is after Date2
                    isAfter = false;
                } else if (date1.compareTo(date2) < 0) {
                    // out.println("After changes"); //Date1 is before Date2
                    isAfter = true;
                } else if (date1.compareTo(date2) == 0) {
                    // out.println("After changes");//Date1 is equal to Date2
                    isAfter = true;
                } else {
                    //out.println("How to get here?");
                }
        %>


        <tr
                <%
                    if (isAfter) {
                        out.println(" style='background-color: rgb(166, 206, 173);'");
                    }
                %>
        >
            <td><%=rsIAV.getString("CLASS_NAME")%>
            </td>
            <td>
                <%
                    if (isAfter)
                        out.println("After Changes");
                    else
                        out.println("Before Changes");
                %>
            </td>
            <td><%=rsIAV.getString("TIME_STAMP")%>
            </td>
            <td><%=rsIAV.getString("TOTAL_REQ")%>
            </td>
            <td><%=rsIAV.getDouble("SCRIPT_LATENCY")%>
            </td>
            <td><%=rsIAV.getDouble("SUCCESS")%>
            </td>
            <td><%=rsIAV.getDouble("AGENT_ERR")%>
            </td>
            <td><%=rsIAV.getDouble("SITE_ERR")%>
            </td>
            <td><%=rsIAV.getDouble("UAR_ERR")%>
            </td>
            <td><%=rsIAV.getDouble("INFRA_ERR")%>
            </td>
            <td><%=rsIAV.getDouble("NUM_OF_NAVIGATIONS")%>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>

<br>
<footer class="footer" style="text-align: center;">
    <p>Copyright &copy; Envestnet|Yodlee@2017</p>
</footer>

<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"
        integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n"
        crossorigin="anonymous"></script>

<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="${pageContext.request.contextPath}/js/workaround.js"></script>
<script
        src="${pageContext.request.contextPath}/js/copyTableTOClipboard.js"></script>

</body>
<style>
    th, td {
        text-align: center;
    }

    .titleofPlatform {
        background-color: #75ad7f;
    }

    .headerofTable {
        background-color: #67ba67;
    }
</style>
</html>
