<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head><title>JSPBoard</title>
<link href="notice_style.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<br><br>
<table width=80% cellspacing=0 cellpadding=3>

</table>
<br>
<table width=80% cellspacing=0 cellpadding=3 align=center>
<form name=post method=post action="notice_PostProc.jsp" >
 <tr>
  <td align=center>
   <table border=0 width=100% align=center>
   
    <tr>
     <td width=10%>�� ��</td>
     <td width=90%><input type=text name=title size=50 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>�� ��</td>
     <td width=90%><textarea name=boardContent rows=10 cols=50></textarea></td>
    </tr>
    <tr>
     <td colspan=2><hr size=1></td>
    </tr>
    <tr>
     <td><input type=submit value="���" >&nbsp;&nbsp;
         <input type=reset value="�ٽþ���">&nbsp;&nbsp;
     </td>
    </tr> 
   </table>
  </td>
 </tr>
</form> 
</table>
</center>
</body>
</html>