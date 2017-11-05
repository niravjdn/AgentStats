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

<body ng-app="myApp">

<nav
        class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
    <button class="navbar-toggler navbar-toggler-right" type="button"
            data-toggle="collapse" data-target="#navbarCollapse"
            aria-controls="navbarCollapse" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#">Agent Stats</a>
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

    <div class="jumbotron" style="margin-bottom: 70px;">

        <form method="post" action="FindStats" id="mainForm">
            <div class="form-group">
                <label for="agentName" style="float: left;">Agent Name</label> <input
                    type="text" required class="form-control" id="agentName"
                    name="agentName" aria-describedby="agentName"
                    placeholder="Enter Agent Name" value="">
            </div>

            <div class="form-group" method="post" action="/FindStats">
                <label for="numOfDays" style="float: left;">Number of days
                </label> <input type="number" required class="form-control"
                                id="numOfDays" value="" name="numOfDays"
                                aria-describedby="numberOfDays" placeholder="Enter Number of Days">
            </div>

            <div class="form-group" method="post" action="/FindStats">
                <label for="pushedData" style="float: left;">Pushed Date</label> <input
                    type="date" data-date="" data-date-format="MM DD YYYY" value="2015-08-09"
                    required class="form-control" id="pushedDate"
                    name="pushedDate" aria-describedby="pushedDate"
                    placeholder="Enter Date on Which Agent Was Pushed">
            </div>

            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-info btn-xs active">
                    <input type="radio" name="whichPlatform" id="prod" autocomplete="off" value="PROD" checked> PROD
                </label>
                <label class="btn btn-info">
                    <input type="radio" name="whichPlatform" id="ycom" value="Y.com" autocomplete="off"> Y.com
                </label>
            </div>
            <br>

            <button class="btn btn-primary btn-xs" type="submit">Submit</button> &nbsp;&nbsp;&nbsp;
            <button class="btn btn-primary btn-xs" type="submit" id="graphSubmitBtn">Show Graph</button>
        </form>

    </div>
</div>

<br>
<footer class="footer" style="text-align: center;">
    <p>Copyright &copy; Envestnet|Yodlee@2017</p>
</footer>


<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"
        integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n"
        crossorigin="anonymous"></script>

<link
        href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
        rel="stylesheet"
        integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
        crossorigin="anonymous">


<script
        src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="${pageContext.request.contextPath}/js/workaround.js"></script>
<script
        src="${pageContext.request.contextPath}/js/copyTableTOClipboard.js"></script>
</body>
<script type="text/javascript">
    var now = new Date();

    var day = ("0" + now.getDate()).slice(-2);
    var month = ("0" + (now.getMonth() + 1)).slice(-2);

    var today = now.getFullYear() + "-" + (month) + "-" + (day);

    $('#pushedDate').val(today);
    console.log(today);
    $("#graphSubmitBtn").on("click", function (e) {
        e.preventDefault();
        $('#mainForm').attr('action', "FindStatsForGraph").submit();
    });

</script>
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
