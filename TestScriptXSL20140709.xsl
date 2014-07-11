<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
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
					<ul class="pagination">
						<li><a href="#">«</a></li>
						<xsl:for-each select="lessonset/lesson">
							<li><a href="#lesson{position()}"><xsl:value-of select="position()" /></a></li>
						</xsl:for-each>
						<li><a href="#">»</a></li>
					</ul>
					<xsl:for-each select="lessonset/lesson">
						<div>
							<div class="page-header">
								<a name='lesson{position()}' ><xsl:value-of select="title"/></a>
							</div>

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
                            		<div>
                            			<xsl:for-each select="soundfile">
                                            <!-- <embed src="{.}.wav" autostart="no" height="12">
                                        </embed> -->
                                    </xsl:for-each>
                                </div>
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
            </font>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>