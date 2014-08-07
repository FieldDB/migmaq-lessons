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
                   <xsl:for-each select="section">
                     <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                      <li class="" onclick="show()"><a name="1" href="#section-well"><xsl:value-of select="sectiontitle" /></a></li>
                      <ul class=""> <!-- subsection list -->
                        <xsl:for-each select="subsection"> 
                        <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                        <li class=""><a href="#subsection{position()}"><xsl:value-of select="subsectitle" /></a></li> 
                            <ul class=""> <!-- lesson list -->
                              <xsl:for-each select="lesson"> 
                              <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                              <li class="" onclick="show()"><a name="1" href="#lesson-well"><xsl:value-of select="lessontitle" /></a></li> 
                                <ul class=""> <!-- unit list -->
                                  <xsl:for-each select="unit"> 
                                  <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
                                  <li class=""><xsl:value-of select="unittitle" /></li> 
                                  </xsl:for-each> <!-- select unit -->
                                </ul>
                              </xsl:for-each> <!-- select lesson -->
                            </ul>
                        </xsl:for-each> <!-- select subsection -->
                      </ul>
                  </xsl:for-each> <!-- select section -->
              </ul>
                  <script> 
                      $('li').click(function() {
                        $(this).next('ul').toggle();
                      });
                      $(function(){
                        // this is the show and hide function, all in 1!
                        $('a[name=1]').click(function(){ 
                            $('.content-well').toggle();
                        });
                      });
                      var show = function(title, description){
                        alert(title+"  :  "+description );
                      };
                  </script>​
                  <!-- show hide nested list  http://stackoverflow.com/questions/9286967/hide-toggle-nested-list-using-jquery --> 
                 <!-- <script> 
                      $('li').click(function() {
                        $(this).next('ul').toggle();
                      });
                  </script>​ -->
             </xsl:for-each> <!-- select lessonset -->
            </div> <!-- end of sidebar wrapper div --> 

        <!-- Begin Lesson page content wrapper. define a variable lessonNumber that takes the n-th position of the lesson tag in xml as its value. this allows to refer to e.g. Lesson n, dialog 1, 2, 3 etc. later in the pagination and modal -->
            <div class="col-md-8" id="page-content-wrapper">

              <div class="well content-well" id="section-well" style="display:none;" >
                <xsl:for-each select="lessonset/section"> 
                <xsl:variable name="sectionNumber" select="position()"/>
                  <!-- clickable lesson title that opens/hides (uncollapse/collapse) lesson intro explanation. use {position()} for id to make it unique   http://getbootstrap.com/javascript/#collapse -->
                  <div class="panel-group" id="accordion{position()}"> 
                     <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">
                            <!-- a data-toggle="collapse" data-parent="#accordion{position()}" href="#lessonintro{position()}"
                               name='lesson{position()}'> -->
                               <xsl:value-of select="sectiontitle"/>
  <!--                          </a> -->
                          </h4>
                        </div>
                     <!-- collapse content = section intro text -->
                        <div id="sectionintro{position()}" class="panel-collapse collapse in">
                          <div class="panel-body">
                           <xsl:value-of select="sectionintro"/>
                          </div>
                        </div>     
                     </div> <!-- end of panel default div -->
                  </div> <!-- end of panel group accordion div -->                        
   <!--                       <div class="outro"> 
                          <button type="button" class="btn btn-primary" href="#lesson{position()-1}">Back to previous lesson</button>
                          <button type="button" class="btn btn-primary pull-right" href="#lesson{position()+1}">Next lesson</button>
                        </div> end of outro div -->
                  </xsl:for-each> <!-- end of page content wrapper for each selecting lessonset/section -->
               </div> <!-- end of the well inside page content wrapper -->                    



              <div class="well content-well" id="lesson-well" style="display:none;" >
                <xsl:for-each select="lessonset/section/subsection/lesson"> 
                <xsl:variable name="lessonNumber" select="position()"/>
                  <!-- clickable lesson title that opens/hides (uncollapse/collapse) lesson intro explanation. use {position()} for id to make it unique   http://getbootstrap.com/javascript/#collapse -->
                  <div class="panel-group" id="accordion{position()}"> 
                     <div class="panel panel-default">
                        <div class="panel-heading">
                          <h4 class="panel-title">
                            <!-- a data-toggle="collapse" data-parent="#accordion{position()}" href="#lessonintro{position()}"
                               name='lesson{position()}'> -->
                               <xsl:value-of select="lessontitle"/>
  <!--                          </a> -->
                          </h4>
                        </div>
                     <!-- collapse content = section intro text -->
                        <div id="lessonintro{position()}" class="panel-collapse collapse in">
                          <div class="panel-body">
                           <xsl:value-of select="lessonintro"/>
                          </div>
                        </div>     
                     </div> <!-- end of panel default div -->
                  </div> <!-- end of panel group accordion div -->                        
   <!--                       <div class="outro"> 
                          <button type="button" class="btn btn-primary" href="#lesson{position()-1}">Back to previous lesson</button>
                          <button type="button" class="btn btn-primary pull-right" href="#lesson{position()+1}">Next lesson</button>
                        </div> end of outro div -->
                </xsl:for-each> <!-- end of page content wrapper for each selecting lessonset/section/subsection/lesson-->
             </div> <!-- end of the well inside page content wrapper -->                    






            </div> <!-- this is the end of the page-content wrapper div -->

        </div> <!-- end of the wrapper div --> 
      </font>
    </body>
  </html> 
</xsl:template>
</xsl:stylesheet>