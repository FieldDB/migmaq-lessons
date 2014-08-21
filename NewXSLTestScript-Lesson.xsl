<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet was originally created by Conor Quinn to transfer Can8 lesson content 
to a web browser -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <script src="/libs/jquery-2.1.1.min.js"/>
        <script src="/libs/bootstrap.min.js"/> 
        <link rel="stylesheet" type="text/css"  href="/libs/bootstrap.min.css"/>
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

        <div class="col-md-12" id="wrapper">     
          <!-- Sidebar showing nested Table of Contents -->
        <!-- collapsible sidebar for table of contents: 
        http://startbootstrap.com/template-overviews/simple-sidebar/
        http://jsfiddle.net/dmyTR/37/
        http://jsfiddle.net/Trufa/dmyTR/36/show/#
        http://stackoverflow.com/questions/13604285/collapsible-sidebar-with-fluid-twitter-bootstrap -->
        <div class="col-md-4" id="sidebar-wrapper">
          <!--  <xsl:for-each select="lessonset/section/subsection/lesson"> -->
          <!-- <ul class="list-unstyled">  section list -->
                  <!-- <xsl:for-each select="section"> 
                <xsl:variable name="sectionTitle" select="sectiontitle"/>
                <xsl:variable name="sectionIntro" select="sectionintro"/>
                <li class="" onclick="show('{$sectionTitle}','{$sectionIntro}')"><a href="#"><xsl:value-of select="sectiontitle" /></a></li>  -->
                <!--  <ul class="">  subsection list -->
                    <!--   <xsl:for-each select="subsection"> 

                <xsl:variable name="subSectionTitle" select="subsectitle"/>
                <xsl:variable name="subSectionIntro" select="subsecintro"/> --> 
                <!--  <li class="" onclick="show('{$subSectionTitle}','{$subSectionIntro}')"><a href="#"><xsl:value-of select="subsectitle" /></a></li>  --> 

                <xsl:for-each select="lessonset/chapter/lesson"> 
                  <ul class="">  <!-- lesson list  -->
                    <xsl:variable name="lessonTitle" select="lessontitle"/>
                    <xsl:variable name="lessonIntro" select="lessonintro"/>
                    <li class="" onclick="show('{$lessonTitle}','{$lessonIntro}')"><a href="#"><xsl:value-of select="lessontitle" /></a></li> 
                    <ul class=""> <!-- unit list -->
                      <xsl:for-each select="unit"> 

                        <xsl:variable name="unitTitle" select="unittitle"/>
                        <xsl:variable name="unitIntro" select="unitintro"/>
                        <li class="" onclick="show('{$unitTitle}','{$unitIntro}'), showUnit()" ><a href="#"><xsl:value-of select="unittitle" /></a></li> 
                      </xsl:for-each> <!-- select unit -->
                    </ul>
                    <!--  </xsl:for-each>  select lesson -->
                    <!--  </ul> -->
                    <!--  </xsl:for-each>  select subsection -->
                    <!--  </ul>  -->
                    <!-- </xsl:for-each>  select section -->
                    <!-- </ul> -->
                  </ul>
                </xsl:for-each> <!-- select lessonset/chapter/lesson -->
                <script>
                  <!-- show hide nested list  http://stackoverflow.com/questions/9286967/hide-toggle-nested-list-using-jquery --> 
                  $('li').click(function() {
                  $(this).next('ul').toggle();
                  });
                  var show = function(title, intro){
                  $("#displayTitleHere").html(title);
                  $("#displayIntroHere").html(intro);
                  };
                  var showUnit = function(unitcontent){
                  $("#displayUnitHere").html(unitcontent);
                  }; 
                </script>​

              </div> <!-- end of sidebar wrapper div --> 



              <xsl:for-each select="lessonset/chapter/lesson">
                <xsl:variable name="lessonNumber" select="position()" />
                <xsl:for-each select="unit">
              <xsl:variable name="unitNumber" select="position()" /> 
              <!-- Main content wraper -->
              <div class="col-md-8" id="page-content-wrapper">

                <div class="well" id="">
                  <!-- clickable lesson title that opens/hides (uncollapse/collapse) lesson intro explanation. use {position()} for id to make it unique   http://getbootstrap.com/javascript/#collapse -->
                  <div class="panel-group" id="accordion-collapse"> 
                   <div class="panel panel-default">
                    <div class="panel-heading">
                      <div class="panel-title" href="#collapseunitintro" >
                        <a data-toggle="collapse" data-parent="#accordion-collapse"><h4 id="displayTitleHere"></h4>
                        </a>
                      </div>
                    </div>
                    <!-- collapse content = section intro text -->
                    <div id="collapseunitintro" class="panel-collapse collapse in">
                      <div class="panel-body"><p id="displayIntroHere"></p>
                      </div>
                    </div>     
                  </div> <!-- end of panel default div -->
                </div> <!-- end of panel group div -->   

                <div class="well inside-page-content-wrapper">
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

                  

                </div> <!-- well inside-page-content-wrapper -->
              </div> <!-- page-content-wrapper --> 





   <!--                       <div class="outro"> 
                          <button type="button" class="btn btn-primary" href="#lesson{position()-1}">Back to previous lesson</button>
                          <button type="button" class="btn btn-primary pull-right" href="#lesson{position()+1}">Next lesson</button>
                        </div> end of outro div 
                      -->

                  </div> <!-- this is the end of the page-content wrapper div -->
                </xsl:for-each>
            </xsl:for-each>
                </div> <!-- end of the wrapper div --> 
              </font>
            </body>
          </html> 
        </xsl:template>
      </xsl:stylesheet>