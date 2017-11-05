<!DOCTYPE html>
<%@page import="com.javaclass.GraphsArray" %>
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


    <script type="text/javascript"
            src="https://www.gstatic.com/charts/loader.js"></script>
    <%
        GraphsArray ga = (GraphsArray) request.getAttribute("ga");
        String[] pfmGraph = ga.PFMGraph;
        System.out.println("pfmjsp]");
        for (int i = 0; i < pfmGraph.length; i++) {
            System.out.println(pfmGraph[i]);
        }
        String[] iavGraph = ga.IAVGraph;
        System.out.println("iavjsp");
        for (int i = 0; i < iavGraph.length; i++) {
            System.out.println(iavGraph[0]);
        }
    %>
    <script type="text/javascript">
        google.charts.load('current', {
            'packages': ['line']
        });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            <%
                String[] agentNames = (String[])request.getAttribute("agentNames");
                String pushedDate = request.getParameter("pushedDate");
            %>





            <%
                for(int i=0;i<pfmGraph.length;i++){

                    %>
            var options_pfm<%= i %> = {
                chart: {
                    title: '<%= agentNames[i] %> PFM',
                    subtitle: 'PROD DATE <%= pushedDate %>: '
                },
                width: 900,
                height: 500
            };

            var data_pfm<%= i %> = new google.visualization.DataTable();
            data_pfm<%= i %>.addColumn('string', 'TimeStamp');
            data_pfm<%= i %>.addColumn('number', 'SUCCESS_RATE');
            data_pfm<%= i %>.addColumn('number', 'SCRIPT_LATENCY');
            data_pfm<%= i %>.addColumn('number', 'AGENT_ERR');
            data_pfm<%= i %>.addColumn('number', 'UAR_ERR');
            data_pfm<%= i %>.addColumn('number', 'SITE_ERR');
            data_pfm<%=i%>.addColumn('number', 'INFRA_ERR');


            data_pfm<%= i %>.addRows([
                <%= pfmGraph[i] %>
            ]);

            <%
            out.println("var chart_pfm"+i+" = new google.charts.Line(document.getElementById('linechart_pfm"+i+"'));");
            out.println("chart_pfm"+i+".draw(data_pfm"+i+", google.charts.Line.convertOptions(options_pfm"+i+"));");
        }%>


            <%
            for(int i=0;i<iavGraph.length;i++){

                %>
            var options_iav<%= i %> = {
                chart: {
                    title: '<%= agentNames[i] %> IAV',
                    subtitle: 'PROD DATE <%= pushedDate %>: '
                },
                width: 900,
                height: 500
            };

            var data_iav<%= i %> = new google.visualization.DataTable();
            data_iav<%= i %>.addColumn('string', 'TimeStamp');
            data_iav<%= i %>.addColumn('number', 'SUCCESS_RATE');
            data_iav<%= i %>.addColumn('number', 'SCRIPT_LATENCY');
            data_iav<%= i %>.addColumn('number', 'AGENT_ERR');
            data_iav<%= i %>.addColumn('number', 'UAR_ERR');
            data_iav<%= i %>.addColumn('number', 'SITE_ERR');
            data_iav<%=i%>.addColumn('number', 'INFRA_ERR');


            data_iav<%= i %>.addRows([
                <%= iavGraph[i] %>
            ]);

            <%
            out.println("var chart_iav"+i+" = new google.charts.Line(document.getElementById('linechart_iav"+i+"'));");
            out.println("chart_iav"+i+".draw(data_iav"+i+", google.charts.Line.convertOptions(options_iav"+i+"));");
        }%>


        }
    </script>
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

    <h2 style="text-align : center;">PFM(PROD)</h2>
    <%
        for (int i = 0; i < pfmGraph.length; i++) {
    %>
    <div class="row">
        <div id="linechart_pfm<%= i %>" style="width: 50% px; height: 500px"></div>
    </div>
    <% } %>
    <br><br>
    <h2 style="text-align : center;">IAV(PROD)</h2>
    <br>
    <%
        for (int i = 0; i < iavGraph.length; i++) {
    %>
    <div class="row">
        <div id="linechart_iav<%= i %>" style="width: 50% px; height: 500px"></div>
    </div>
    <% } %>


</div>

<br>
<footer class="footer" style="text-align: center; position: relative;">
    <p>Copyright &copy; Envestnet|Yodlee@2017</p>
</footer>

</body>
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"
        integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n"
        crossorigin="anonymous"></script>
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

<link
        href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
        rel="stylesheet"
        integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
        crossorigin="anonymous">
</html>