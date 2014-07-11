<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet was originally created by Connor Quinn to transfer Can8 lesson content 
to a web browser -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
                <script src="https://code.jquery.com/jquery-2.1.1.min.js"/>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"/> 
				<link rel="stylesheet" type="text/css"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
                <xsl:for-each select="lessonset">
                   <title>
                      <xsl:value-of select="title"/>
                  </title>
              </xsl:for-each>
              <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
          </head>
          <body>
            <div class="well">
               <button class="btn btn-primary">Hello bootstrap!</button>
           </div>
           <font face="Gentium, Lucida Grande, Arial Unicode MS">
               <xsl:for-each select="lessonset">
                  <h2>
                     <xsl:value-of select="title"/>
                 </h2>
             </xsl:for-each>
             <div class="col-md-12" id="wrapper">
                <!-- Sidebar -->
                <div class="col-md-3" id="sidebar-wrapper">
                    <ul class="sidebar-nav">
                            <!--    <li class="sidebar-brand"><a href="#">Start Bootstrap</a>
                        </li> -->
                        <xsl:for-each select="lessonset/lesson">
                            <!-- <li><a href="#lesson{position()}"><xsl:value-of select="position()" /></a></li> -->
                            <li><a href="#lesson{position()}"><xsl:value-of select="title" /></a></li>
                        </xsl:for-each>
                    </ul>
                </div>

					<!-- <ul class="pagination">
						<li><a href="#">«</a></li>
						<xsl:for-each select="lessonset/lesson">
							<li><a href="#lesson{position()}"><xsl:value-of select="position()" /></a></li>
						</xsl:for-each>
						<li><a href="#">»</a></li>
					</ul> -->
					<!-- Page content -->
                    <div class="col-md-9" id="page-content-wrapper">
                        <xsl:for-each select="lessonset/lesson">
                          <div>
                            <div class="panel-group" id="accordion"> 
                              <div class="panel panel-default">
                                <div class="panel-heading">
                                  <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#explanation"
                                       name='lesson{position()}'><xsl:value-of select="title"/>
                                  </a>
                              </h4>
                          </div>
                          <div id="explanation" class="panel-collapse collapse in">
                              <div class="panel-body">
                                <xsl:value-of select="explnote"/>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="page-header">
                    <a name='lesson{position()}' ><xsl:value-of select="title"/></a> <br></br>
                    <button class="btn btn-info">Explanation</button> 
                    <p class="hidden">
                        <xsl:value-of select="explnote"/>
                    </p>
                </div> -->
                <!--inserts an audio element for the entire lesson text, if one exists: these should be added just inside the "lesson" level as a "soundfile" element; contrast this with the "soundfile" element, which is the soundfile corresponding to "line"-level "migmaq" elements, i.e. to the individual Mi'gmaq sound clips-->
                <div>
                    <div colspan="2">
                     <xsl:for-each select="soundfile">
                                        <!-- <embed src="{.}.wav" autostart="no" height="12">
                                        </embed>

                                        <embed src="{.}.mp3" autostart="no" height="12">
                                        </embed> -->
                                    </xsl:for-each>
                                </div>
                            </div>
                            <xsl:for-each select="dialog/line|vocab/line">
                            	<!--inserts "line"-level "migmaq", "english", and "soundfile" content: i.e. the Mi'gmaq, English, and corresponding audio clip for each "line" element-->                                
                            	<div class="container-fluid">
                            		<div class="col-md-12">                                        
                            			<img src="Strawberry.gif" class="img-rounded"></img>
                                        <!-- <xsl:for-each select="picture"> 
                                            <img src="{.}.jpg" class="img-rounded"></img> 
                                        </xsl:for-each> -->
                                    </div>

                                    <div class="col-md-12">
                                     <p>
                                        <xsl:value-of select="migmaq"/> 
                                    </p>
                                    <p>
                                        <i>
                                           <xsl:value-of select="english"/>
                                       </i>
                                   </p>
                               </div>                           		
                               <xsl:for-each select="soundfile">
                                 <audio controls="true" >
                                     <source src="{.}.mp3" type="audio/mp3" > 
                                       </source>  <!-- <embed src="{.}.wav" autostart="no" height="12">
                                   </embed> -->
                               </audio> 
                           </xsl:for-each>                                    
                       </div>
                       <!--selects any and all note elements and gives each a line, i.e. via a NESTED for-each-->
                       <xsl:for-each select="dialog/line|vocab/note">
                         <div>
                          <div width="500">
                           <i>
                            <xsl:value-of select="."/>
                        </i>
                    </div>
                </div>
            </xsl:for-each>
        </xsl:for-each>
    </div>
</xsl:for-each>
</div>
</div>
</font>
</body>
</html>
</xsl:template>
</xsl:stylesheet>