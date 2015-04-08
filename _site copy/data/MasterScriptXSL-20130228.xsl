<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
<html>
<head>
<xsl:for-each select="lessonset">
<title><xsl:value-of select="title"/></title>
</xsl:for-each>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>

<body>
<font face="Gentium, Lucida Grande, Arial Unicode MS">
<xsl:for-each select="lessonset">
<h2><xsl:value-of select="title"/></h2>
</xsl:for-each>
<xsl:for-each select="lessonset/lesson">
<table bgcolor="white" border="0">
<tr bgcolor="salmon">
<th align="left" colspan="2"><xsl:value-of select="title"/></th>
</tr>

<!--spacing line-->
<tr>
<td colspan="2"><p></p></td>
</tr>


<!--inserts an audio element for the entire lesson text, if one exists: these should be added just inside the "lesson" level as a "soundfile" element; contrast this with the "soundfile" element, which is the soundfile corresponding to "line"-level "migmaq" elements, i.e. to the individual Mi'gmaq sound clips-->

<tr>
<td colspan="2">

<xsl:for-each select="soundfile">
<embed src="{.}.wav" autostart="no" height="12"></embed>
<!--  <embed src="{.}.mp3" autostart="no" height="12"></embed>  -->	</xsl:for-each>


</td>
</tr>


<xsl:for-each select="dialog/line|vocab/line">

<!--spacing line-->
<tr>
<td colspan="2"><p></p></td>
</tr>

<!--inserts "line"-level "migmaq", "english", and "soundfile" content: i.e. the Mi'gmaq, English, and corresponding audio clip for each "line" element-->

<tr>
<td width="500"><xsl:value-of select="migmaq"/></td>
<td width="500"><i><xsl:value-of select="english"/></i></td>
<td>
<xsl:for-each select="soundfile">
<embed src="{.}.wav" autostart="no" height="12"></embed>
</xsl:for-each>
</td>

</tr>

<!--selects any and all note elements and gives each a line, i.e. via a NESTED for-each-->

<xsl:for-each select="dialog/line|vocab/note">
<tr>
<td colspan="2"><p></p></td>
</tr>

<tr>
<td width="500"><i><xsl:value-of select="."/></i></td>
</tr>
</xsl:for-each>


</xsl:for-each>
</table>
<br></br>
<br></br>
<br></br>
</xsl:for-each>
</font>
</body>
</html>
</xsl:template>
</xsl:stylesheet>