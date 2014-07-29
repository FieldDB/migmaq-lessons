<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet was originally created by Conor Quinn to transfer Can8 lesson content 
to a web browser -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
        <script src="jquery-2.1.1.min.js"/>
        <!-- script src="https://code.jquery.com/jquery-2.1.1.min.js"/ -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"/> 
        <link rel="stylesheet" type="text/css"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
        <!-- <xsl:for-each select="lessonset">
         <title>
          <xsl:value-of select="title"/>
         </title> 
        </xsl:for-each> -->
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      </head>
    <body>  
      <div class="well"> <!-- begin page header well--> 
        <h1>Mi'gmaq Lessons (demo)</h1>
         <xsl:for-each select="lessonset/generalintro">  
            <button type="button" class="btn btn-primary" href="#intromodal" data-toggle="modal" data-target="#intromodal">
              <xsl:value-of select="introtitle"/></button>
             <div class="modal" id="intromodal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                   <div class="modal-dialog">
                      <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title" id=""><xsl:value-of select="introtitle" /></h4>
                         </div>
                         <div class="modal-body">                            
                           <div class="container-fluid">
                            <p><xsl:value-of select="introtext" /></p>
                           </div> 
                         </div>
                         <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                         </div>
                      </div>
                   </div>
             </div> <!-- end of intro modal div-->
         </xsl:for-each>       
       </div> <!-- end of page header well --> 
          
     <font face="Gentium, Lucida Grande, Arial Unicode MS">
            <!-- <xsl:for-each select="lessonset">
                <h2><xsl:value-of select="title"/></h2>
            </xsl:for-each> -->  
      <div class="col-md-12" id="wrapper">
     
        <!-- Sidebar showing lesson titles -->
            <div class="col-md-3" id="sidebar-wrapper">
              <ul class="sidebar-nav">
                  <xsl:for-each select="lessonset/lesson"> 
                    <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                    <li><a href="#lesson{position()}"><xsl:value-of select="title" /></a></li> 
                  </xsl:for-each>
              </ul>
            </div> <!-- end of sidebar wrapper div --> 

        <!-- Begin Lesson page content wrapper. define a variable lessonNumber that takes the n-th position of the lesson tag in xml as its value. this allows to refer to e.g. Lesson n, dialog 1, 2, 3 etc. later in the pagination and modal -->
            <div class="col-md-9" id="page-content-wrapper">
                <xsl:for-each select="lessonset/lesson">
                <xsl:variable name="lessonNumber" select="position()"/>
                 <div class="well">
                  <!-- clickable lesson title that opens/hides (uncollapse/collapse) lesson intro explanation. use {position()} for id to make it unique   http://getbootstrap.com/javascript/#collapse -->
                  <div class="panel-group" id="accordion{position()}"> 
                     <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion{position()}" href="#explanation{position()}"
                               name='lesson{position()}'><xsl:value-of select="title"/>
                            </a>
                          </h4>
                        </div>
                     <!-- collapse content = lesson intro explanation -->
                        <div id="explanation{position()}" class="panel-collapse collapse in">
                          <div class="panel-body">
                           <xsl:value-of select="explnote"/>
                          </div>
                        </div>
                     </div> <!-- end of panel default div -->
                  </div> <!-- end of panel group accordion div -->
              
              <!--inserts an audio element for the entire lesson text, if one exists: these should be added just inside the "lesson" level as a "soundfile" element; contrast this with the "soundfile" element, which is the soundfile corresponding to "line"-level "migmaq" elements, i.e. to the individual Mi'gmaq sound clips-->
                  <div colspan="2">
                      <xsl:for-each select="soundfile">
                        <!-- .wav takes forever to load, use .mp3
                             <embed src="{.}.mp3" autostart="no" height="12">
                             </embed> -->
                      </xsl:for-each>
                  </div>

              <!-- paginate a lesson into dialog|vocab. show each dialog|vocab as n-th position in the lesson. click the number to open a modal containing the dialog|vocab with picture and audio. id refers to the modal content, see the next set of code lines. indicate the current dialog|vocab number/position.  http://getbootstrap.com/components/#pagination-pager -->  
                  <ul class="pagination">
                    <!-- <li><a href="#">«</a></li> previous button, we probably don't need this --> 
                      <xsl:for-each select="dialog|vocab">
                        <li><a href="#lesson{$lessonNumber}dialog{position()}" data-toggle="modal" data-target="#lesson{$lessonNumber}dialog{position()}"><xsl:value-of select="position()" /><span class="sr-only">(current)</span></a></li>
                      </xsl:for-each>
                    <!-- <li><a href="#">»</a></li>  next button, we probably don't need this -->
                  </ul> 

                  <!-- Begin modal content = dialog|vocab with pic and audio   http://getbootstrap.com/javascript/#modals  
                  TODO  -->
                        <xsl:for-each select="dialog|vocab">
                            <div class="modal" id="lesson{$lessonNumber}dialog{position()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                              <div class="modal-dialog">
                                <div class="modal-content">
                                  <!-- <div class="modal-header">
                                      <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">x</span></button> 
                                      <h4 class="modal-title" id="myModalLabel"></h4>
                                  </div> --> <!-- end of modal header --> 
                                  <div class="modal-body">                            
                                    <div class="container-fluid">
                                    <!--inserts line-level "migmaq", "english", and "soundfile" content: i.e. the Mi'gmaq, English, and corresponding audio clip for each "line" element -->
                                     <xsl:for-each select="line">
                                      <!-- begin picture div -->
                                      <div class="col-md-12"> <!-- -->                                       
                                        <!-- inserts picture. use for-each commented out below, when pics are ready --> 
                                          <!-- <img src="Strawberry.gif" class="img-rounded"></img> -->
                                          <xsl:for-each select="picture"> 
                                            <img src="{.}.gif" class="img-rounded"></img> 
                                          </xsl:for-each> 
                                      </div> <!-- end picture div inside modal -->                                  

                                      <div class="col-md-12"> 
                                            <p><b><xsl:value-of select="migmaq"/></b></p>
                                            <p><i><xsl:value-of select="english"/></i></p>
                                        <!-- insert sound file with sound player  http://williamrandol.github.io/bootstrap-player/demo/ 
                                        "You need to add the ="true" part to the controls in the video tag" 
                                        http://www.experts-exchange.com/Web_Development/Web_Languages-Standards/HTML/Q_27706079.html
                                        TODO make sound player to replay in Chrome -->                                 
                                          <!-- xsl:value-of select="soundfile|videofile" /-->
                                            <xsl:for-each select="soundfile|videofile">
                                              <audio controls="true" >
                                                <source src="{.}.mp3" type="audio/mp3" ></source>   
                                              <!-- <embed src="{.}.wav" autostart="no" height="12"></embed> -->
                                              </audio> 
                                              <!--- <video controls="true" >
                                                <source src="{.}.mp4" type="video/mp4" ></source>   
                                              </video> --> 
                                            </xsl:for-each>
                                      </div> 
                                     </xsl:for-each>

                                    </div> <!-- end of container fluid -->
                                  </div> <!-- end of modal body -->
                                  
                                  <div class="modal-footer">
                                    <!-- TODO make Next to open the next modal item (currently it just closes the current modal) -->
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <a href="#lesson{$lessonNumber}dialog{position()}" data-dismiss="modal" data-toggle="modal" data-target="#dialog{position()+1}" type="button" class="btn btn-primary">Next</a>
                                  </div>
                                </div> <!-- end of modal content -->
                              </div> <!-- end of modal dialog --> 
                            </div> <!-- end of modal div -->  

                          <!-- selects any and all note elements and gives each a line, i.e. via a NESTED for-each -->
                            <!-- <xsl:for-each select="dialog/line|vocab/note">
                              <div width="500">
                                 <i><xsl:value-of select="."/></i>
                              </div>
                            </xsl:for-each> -->

                        </xsl:for-each> <!-- end of modal content for-each (line 85) --> 
                        
                        <div class="outro"> 
                          <div class="btn-group">
                              <button type="button" class="btn btn-info" href="#lesson-outro-modal" data-toggle="modal" data-target="#lesson-outro-modal">
                                Finished all the items?</button>
                              <div class="modal" id="lesson-outro-modal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                                 <div class="modal-dialog">
                                    <div class="modal-content">
                                       <div class="modal-header">
                                         <h4 class="modal-title" id="outro-title"><xsl:value-of select="title" /></h4>
                                       </div>
                                       <div class="modal-body">                            
                                         <div class="container-fluid">
                                          <p><xsl:value-of select="outro" /></p>
                                         </div> 
                                       </div>
                                       <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                       </div>
                                    </div>
                                 </div>
                              </div> <!-- end of lesson-outro-modal div -->
                           </div>  <!-- end of btn-group div -->      
                        </div>  <!-- end of outro div -->
                  </div> <!-- end of the well inside page content wrapper -->                    
                </xsl:for-each> <!-- end of page content wrapper for each selecting lessonset/lesson (line 65)-->

            </div> <!-- this is the end of the page-content wrapper div -->

        </div> <!-- end of the wrapper div --> 
      </font>
    </body>
  </html> 
</xsl:template>
</xsl:stylesheet>