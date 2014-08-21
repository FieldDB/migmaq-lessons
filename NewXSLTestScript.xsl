<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet was originally created by Conor Quinn to transfer Can8 lesson content 
to a web browser -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <script src="jquery-2.1.1.min.js"/>
        <!-- script src="https://code.jquery.com/jquery-2.1.1.min.js"/ -->
        <script src="bootstrap.min.js"/> 
        <link rel="stylesheet" type="text/css"  href="bootstrap.min.css"/>
        <!-- <xsl:for-each select="lessonset">
         <title>
          <xsl:value-of select="title"/>
         </title> 
        </xsl:for-each> -->
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      </head>
    <body>  
      <div class="well"> <!-- begin page header well--> 
        <h2><b>Mi'gmaq Lessons (demo)</b></h2>
         <xsl:for-each select="lessonset/generalintro">  
            <button type="button" class="btn btn-primary" href="#intromodal" data-toggle="modal" data-target="#intromodal">
              <xsl:value-of select="genintrotitle"/></button>
             <div class="modal" id="intromodal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                   <div class="modal-dialog">
                      <div class="modal-content">
                         <div class="modal-header">
                           <h4 class="modal-title" id=""><xsl:value-of select="genintrotitle" /></h4>
                         </div>
                         <div class="modal-body">                            
                           <div class="container-fluid">
                            <p><xsl:value-of select="genintrotext" /></p>
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
        <!-- collapsible sidebar for table of contents: 
        http://startbootstrap.com/template-overviews/simple-sidebar/
        http://jsfiddle.net/dmyTR/37/
        http://jsfiddle.net/Trufa/dmyTR/36/show/#
        http://stackoverflow.com/questions/13604285/collapsible-sidebar-with-fluid-twitter-bootstrap -->
            <div class="col-md-4" id="sidebar-wrapper">
              <xsl:for-each select="lessonset">
              <ul class="list-unstyled"> <!-- section list -->
                   <xsl:for-each select="chapter">
                     <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                      <li class="" ><a href="#chapter{position()}"><xsl:value-of select="chaptertitle" /></a></li>
                      <ul class=""> <!-- lesson list -->
                        <xsl:for-each select="lesson"> 
                          <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                          <li class=""><a href="#lesson{position()}"><xsl:value-of select="lessontitle" /></a></li> 
                          <ul class=""> <!-- unit list -->
                            <xsl:for-each select="unit"> 
                              <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                              <li class=""><a href="#unit{position()}"><xsl:value-of select="unittitle" /></a></li> 
                            </xsl:for-each> <!-- select unit -->
                          </ul>
                        </xsl:for-each> <!-- select lesson -->
                      </ul>                    
                  </xsl:for-each> <!-- select section -->
              </ul>
                  <!-- show hide nested list  http://stackoverflow.com/questions/9286967/hide-toggle-nested-list-using-jquery --> 
                  <script> 
                      $('li').click(function() {
                        $(this).next('ul').toggle();
                      });
                  </script>​
             </xsl:for-each> <!-- select lessonset -->
            </div> <!-- end of sidebar wrapper div --> 

        <!-- Begin Lesson page content wrapper. define a variable lessonNumber that takes the n-th position of the lesson tag in xml as its value. this allows to refer to e.g. Lesson n, dialog 1, 2, 3 etc. later in the pagination and modal -->
            <div class="col-md-8" id="page-content-wrapper">
                <xsl:for-each select="lessonset/chapter/lesson/unit">
                <xsl:variable name="unitNumber" select="position()"/>
                 <div class="well">
                  <!-- clickable lesson title that opens/hides (uncollapse/collapse) lesson intro explanation. use {position()} for id to make it unique   http://getbootstrap.com/javascript/#collapse -->
                  <div class="panel-group" id="accordion{position()}"> 
                     <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion{position()}" href="#unitintro{position()}"
                               name='unit{position()}'><xsl:value-of select="unittitle"/>
                            </a>
                          </h4>
                        </div>
                     <!-- collapse content = lesson intro explanation -->
                        <div id="unitintro{position()}" class="panel-collapse collapse in">
                          <div class="panel-body">
                           <xsl:value-of select="unitintro"/>
                          </div>
                        </div>
                     </div> <!-- end of panel default div -->
                  </div> <!-- end of panel group accordion div -->
              
              <!-- paginate a unit into dialog|vocab. show each dialog|vocab as n-th position in the lesson. click the number to open a modal containing the dialog|vocab with picture and audio. id refers to the modal content, see the next set of code lines. indicate the current dialog|vocab number/position.  http://getbootstrap.com/components/#pagination-pager -->  
                  <ul class="pagination">
                    <!-- <li><a href="#">«</a></li> previous button, we probably don't need this --> 
                      <xsl:for-each select="dialog">
                        <li><a href="#unit{$unitNumber}dialog{position()}" data-toggle="modal" data-target="#unit{$unitNumber}dialog{position()}"><xsl:value-of select="position()" /><span class="sr-only">(current)</span></a></li>
                      </xsl:for-each>
                    <!-- <li><a href="#">»</a></li>  next button, we probably don't need this -->
                  </ul> 

                  <!-- Begin modal content = dialog|vocab with pic and audio   http://getbootstrap.com/javascript/#modals  
                  TODO  -->
                        <xsl:for-each select="dialog">
                            <div class="modal" id="unit{$unitNumber}dialog{position()}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                              <div class="modal-dialog">
                                <div class="modal-content">

                                   <div class="modal-header">
                                    <button type="button" class="btn-default btn-xs pull-right" data-dismiss="modal">Close</button>
                                      <h4 class="modal-title" id="myModalLabel"></h4>
                                    </div> <!-- end of modal header --> 

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

                                      <div class="col-md-6"> 
                                            <p><b><xsl:value-of select="migmaq"/></b></p>
                                      </div>
                                      <div class="colmd-6">
                                            <p><i><xsl:value-of select="english"/></i></p>
                                      </div>
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
                                     </xsl:for-each>

                                    </div> <!-- end of container fluid -->
                                  </div> <!-- end of modal body -->
                                  
                                  <div class="modal-footer">
                                    <!-- TODO make Next to open the next modal item (currently it just closes the current modal) -->
                                    <a data-dismiss="modal" data-toggle="modal" data-target="#unit{$unitNumber}dialog{position()-1}" type="button" class="btn btn-primary pull-left">Back</a>
                                    <a data-dismiss="modal" data-toggle="modal" data-target="#unit{$unitNumber}dialog{position()+1}" type="button" class="btn btn-primary">Next</a>
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
                          <button type="button" class="btn btn-info" href="#unit{$unitNumber}info" data-toggle="modal" data-target="#unit{$unitNumber}info">Finished all the items?</button>
                              <div class="modal" id="unit{$unitNumber}info" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
                                 <div class="modal-dialog">
                                    <div class="modal-content">
                                       <div class="modal-header">
                                         <h4 class="modal-title" id="outro-title"><xsl:value-of select="unittitle" /></h4>
                                       </div>
                                       <div class="modal-body">                            
                                         <div class="container-fluid">
                                          <p><xsl:value-of select="info" /></p>
                                         </div> 
                                       </div>
                                       <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                       </div>
                                    </div>
                                 </div>
                              </div> <!-- end of lesson-outro-modal div -->
                          <button type="button" class="btn btn-primary pull-right" href="#unit{$unitNumber}">Next Unit</button>
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