<?xml version="1.0" encoding="UTF-8"?>

<!-- This style sheet was originally created by Conor Quinn to transfer Can8 lesson content 
to a web browser -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <!-- jQuery library (served from Google) -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js" />
        <script src="/libs/jquery-2.1.1.min.js"/>
        <script src="/libs/bootstrap.min.js"/>
        <!-- bxSlider Javascript file -->
        <script src="/libs/jquery.bxslider.js" />
        <link rel="stylesheet" type="text/css" href="/libs/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="/libs/simple-sidebar.css"/>
        <!-- bxSlider CSS file -->
        <link href="/libs/jquery.bxslider.css" rel="stylesheet" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      </head>

      <body>  
        <font face="Gentium, Lucida Grande, Arial Unicode MS">

         <!-- page header well--> 
         <div class="well">
          <h2><b>Mi'gmaq Lessons (demo)</b></h2>
       <!--  <xsl:for-each select="lessonset/generalintro">  
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
             </div> 
           </xsl:for-each>  -->     
         </div> 
         <!-- end of page header well --> 


         <div class="" id="wrapper">     
          <!-- Sidebar showing nested Table of Contents -->
        <!-- collapsible sidebar for table of contents: 
        http://startbootstrap.com/template-overviews/simple-sidebar/
        http://jsfiddle.net/dmyTR/37/
        http://jsfiddle.net/Trufa/dmyTR/36/show/#
        http://stackoverflow.com/questions/13604285/collapsible-sidebar-with-fluid-twitter-bootstrap -->

        <!-- Side bar -->      
        <div class="" id="sidebar-wrapper">
          <xsl:for-each select="lessonset">
           <ul class="list-unstyled">
             <li><h3>Contents</h3></li>
           </ul>
           <ul class="list-unstyled"> <!-- section list -->
             <xsl:for-each select="chapter">
               <!-- get the list of lesson titles linked to the correct lesson. the link refers to n-th position of <lesson> tag, and takes the title of the n-th lesson. on .position() see http://api.jquery.com/position/  --> 
               <li class="" ><a href="#chapter{position()}"><xsl:value-of select="chaptertitle" /></a></li>
               <ul class=""> <!-- lesson list -->
                <xsl:for-each select="lesson"> 
                  <li class=""><a href="#lesson{position()}"><xsl:value-of select="lessontitle" /></a></li> 
                  <ul class=""> <!-- unit list -->
                    <xsl:for-each select="unit"> 
                      <li class=""><a href="#unit{position()}"><xsl:value-of select="unittitle" /></a></li>
                      <ul class=""> <!-- examples exercises list -->  
                        <xsl:for-each select="dialog">
                          <li class=""><a href="#dialog{position()}"><xsl:value-of select="dialogtitle" /></a></li>
                        </xsl:for-each>
                      </ul>
                    </xsl:for-each> <!-- select unit -->
                  </ul>
                </xsl:for-each> <!-- select subsection/lesson -->
              </ul> 
            </xsl:for-each> <!-- select section -->
          </ul>
          <!-- show hide nested list  http://stackoverflow.com/questions/9286967/hide-toggle-nested-list-using-jquery --> 
        </xsl:for-each> <!-- select lessonset -->
        <script> 
          $('li').click(function() {
          $(this).next('ul').toggle();
          });
        </script>​

      </div> <!-- end of sidebar wrapper div --> 


      <!-- page content wrapper --> 
      <div class="" id="page-content-wrapper">
        <div class="container-fluid">
          <div class="row">
            <a href="#menu-toggle" id="menu-toggle" class="btn btn-default pull-left">&#8678; &#8680;</a>                  
          </div>

          <xsl:for-each select="lessonset/chapter/lesson/unit">
           <xsl:variable name="unitNumber" select="position()"/> 
           <div id="carousel-slide{position()}" class="carousel slide" data-ride="carousel">
            <!-- indicatores --> 
            <ol class="carousel-indicators">
              <li data-target="#carousel-slide{position()}" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-slide{position()}" data-slide-to="1"></li>
              <li data-target="#carousel-slide{position()}" data-slide-to="2"></li>  
              <li data-target="#carousel-slide{position()}" data-slide-to="3"></li>  
              <li data-target="#carousel-slide{position()}" data-slide-to="4"></li>  
              <li data-target="#carousel-slide{position()}" data-slide-to="5"></li>  
            </ol>

            <!-- wrapper for slides -->
            <xsl:for-each select="dialog"> 
              <div class="carousel-inner">
                <div class="item active" id="unit{$unitNumber}dialog{position()}" tabindex="-1">
                  <div class="carousel-inner-body"> 
                    <div class="container-fluid">

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

                                        </div> <!-- container-fluid -->
                                      </div>
                                    </div>

                <div class="item" id="unit{$unitNumber}dialog{position()+1}" tabindex="-1">
                  <div class="carousel-inner-body"> 
                    <div class="container-fluid">

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

                                        </div> <!-- container-fluid -->
                                      </div>
                                    </div>

                                  </div> <!-- carousel-inner -->
                                </xsl:for-each>
                                <!-- end wrapper for slides --> 

                                <!-- Controls -->
                                <a class="left carousel-control" href="#carousel-slide{position()}" role="button" data-slide="prev">
                                  <span class="glyphicon glyphicon-chevron-left"></span>
                                </a>
                                <a class="right carousel-control" href="#carousel-slide{position()}" role="button" data-slide="next">
                                  <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>



                            </div> <!-- carousel slide --> 
                          </xsl:for-each> 
                        </div> <!-- container-fluid -->
                      </div>  <!-- page content wrapper -->

                      <!-- page content wrapper -->          
<!--  <div class="" id="page-content-wrapper">
    <div class="container-fluid">

      <div class="row">
        <a href="#menu-toggle" id="menu-toggle" class="btn btn-default pull-left">&#8678; &#8680;</a>                  
      </div>

      <div class="container-fluid">
        <ul class="bxslider">
          <li><img src="websitemockup1.png" /></li>
          <li><img src="websitemockup1exercise.png" /></li>
        </ul>
      </div>
    </div>
  </div>  -->
  <!-- end of the page-content wrapper div -->

  <script>          
    $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
    });
 <!--             $(document).ready(function(){
                $('.bxslider').bxSlider();
                });  -->
                $('.carousel').carousel()
              </script>  

            </div> <!-- end of the wrapper div --> 
          </font>
        </body>
      </html> 
    </xsl:template>
  </xsl:stylesheet>