<%@ Page Language="C#" %>

<script runat="server" language="C#">

private string GetClientIP()
{
    string ips = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

    if (!string.IsNullOrEmpty(ips))
    {
        return ips.Split(',')[0] + " (external)";
    }

    return Request.ServerVariables["REMOTE_ADDR"] + " (internal)";
}

private string GetServerName()
{
    // for security purposes, only return the last 2 chars
    string server = Environment.MachineName;
    return server;
}
</script>

<%
// what server data are we looking for?
string sData = Request["serverData"]+"";

switch (sData)
{
    case "clientIP":
        Response.Write(GetClientIP());
        break;

    case "serverName":
        Response.Write(GetServerName());
        break;

    case "clientIPandServerName":
        Response.Write("Client IP: " + GetClientIP() + "&nbsp;&nbsp;&nbsp;&nbsp; Server: " + GetServerName());
        break;

    default:
        break;
}
%>
