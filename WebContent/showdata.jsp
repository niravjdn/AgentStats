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

    <title>AgentStat</title>

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
        ResultSet rsYcom = rsArr.get(2);
        out.println("isbeforefirst" + rsPFM.isBeforeFirst());
			/* rsPFM.last();
			out.println("isbeforefirst"+rsPFM.isBeforeFirst());
			rsPFM.beforeFirst();
			rsIAV.beforeFirst();
			rsYcom.beforeFirst();
			out.println("isbeforefirst"+rsPFM.isBeforeFirst()); */
    %>

    <input type="button" value="copy" class="btn btn-xs btn-primary"
           onclick="selectElementContents( document.getElementById('byAgentNamePFMIAVYcom') );">

    <table id="byAgentNamePFMIAVYcom" style="margin-bottom: 80px;"
           class="table table-hover table-responsive table-bordered table-striped">

        <tr>
            <th colspan="10" class="titleofPlatform">PFM</th>
        </tr>
        <tr align="center" class="headerofTable">
            <th>CLASS_NAME</th>
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
        %>


        <tr>
            <td><%=rsPFM.getString("CLASS_NAME")%>
            </td>
            <td><%=rsPFM.getString("TIME_STAMP")%>
            </td>
            <td><%=rsPFM.getString("TOTAL_REQ")%>
            </td>
            <td><%=rsPFM.getString("SCRIPT_LATENCY")%>
            </td>
            <td><%=rsPFM.getString("SUCCESS")%>
            </td>
            <td><%=rsPFM.getString("AGENT_ERR")%>
            </td>
            <td><%=rsPFM.getString("SITE_ERR")%>
            </td>
            <td><%=rsPFM.getString("UAR_ERR")%>
            </td>
            <td><%=rsPFM.getString("INFRA_ERR")%>
            </td>
            <td><%=rsPFM.getString("NUM_OF_NAVIGATIONS")%>
            </td>
        </tr>
        <%
            }
        %>


        <tr>
            <th colspan="10" class="titleofPlatform">IAV</th>
        </tr>


        <%
            while (rsIAV.next()) {
        %>


        <tr>
            <td><%=rsIAV.getString("CLASS_NAME")%>
            </td>
            <td><%=rsIAV.getString("TIME_STAMP")%>
            </td>
            <td><%=rsIAV.getString("TOTAL_REQ")%>
            </td>
            <td><%=rsIAV.getString("SCRIPT_LATENCY")%>
            </td>
            <td><%=rsIAV.getString("SUCCESS")%>
            </td>
            <td><%=rsIAV.getString("AGENT_ERR")%>
            </td>
            <td><%=rsIAV.getString("SITE_ERR")%>
            </td>
            <td><%=rsIAV.getString("UAR_ERR")%>
            </td>
            <td><%=rsIAV.getString("INFRA_ERR")%>
            </td>
            <td><%=rsIAV.getString("NUM_OF_NAVIGATIONS")%>
            </td>
        </tr>
        <%
            }
        %>

        <tr>
            <th colspan="10" class="titleofPlatform">Y.com</th>
        </tr>


        <%
            while (rsYcom.next()) {
        %>


        <tr>
            <td><%=rsYcom.getString("CLASS_NAME")%>
            </td>
            <td><%=rsYcom.getString("TIME_STAMP")%>
            </td>
            <td><%=rsYcom.getString("TOTAL_REQ")%>
            </td>
            <td><%=rsYcom.getString("SCRIPT_LATENCY")%>
            </td>
            <td><%=rsYcom.getString("SUCCESS")%>
            </td>
            <td><%=rsYcom.getString("AGENT_ERR")%>
            </td>
            <td><%=rsYcom.getString("SITE_ERR")%>
            </td>
            <td><%=rsYcom.getString("UAR_ERR")%>
            </td>
            <td><%=rsYcom.getString("INFRA_ERR")%>
            </td>
            <td><%=rsYcom.getString("NUM_OF_NAVIGATIONS")%>
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

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<script src="http://code.gijgo.com/1.6.0/js/gijgo.js" type="text/javascript"></script>
<link href="http://code.gijgo.com/1.6.0/css/gijgo.css" rel="stylesheet" type="text/css"/>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="${pageContext.request.contextPath}/js/workaround.js"></script>
<script src="${pageContext.request.contextPath}/js/copyTableTOClipboard.js"></script>
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
