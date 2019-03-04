<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<!-- Content Stylesheet for "tomcat-site" Documentation -->

<!-- $Id: tomcat-site.xsl 1850132 2019-01-01 21:57:48Z rjung $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">

  <!-- Output method -->
  <xsl:output method="html"
              html-version="5.0"
              encoding="UTF-8"
              indent="yes"/>

  <!-- Defined parameters (overrideable) -->
  <xsl:param    name="relative-path" select="'.'"/>
  <xsl:param    name="tomcat-logo"   select="'res/img/tomcat-logo-tm.svg'"/>
  <xsl:param    name="asf-logo"      select="'res/img/asf_logo.svg'"/>
  <xsl:param    name="buglink"       select="'https://bz.apache.org/bugzilla/show_bug.cgi?id='"/>
  <xsl:param    name="revlink"       select="'https://svn.apache.org/viewvc?view=rev&amp;rev='"/>
  <xsl:param    name="cvelink"       select="'https://cve.mitre.org/cgi-bin/cvename.cgi?name='"/>

  <!-- Defined variables (non-overrideable) -->

  <!-- Process an entire document into an HTML page -->
  <xsl:template match="document">
    <xsl:variable name="project"       select="document('project.xml')/project"/>
    <xsl:variable name="src-tomcat-logo">
      <xsl:value-of select="$tomcat-logo"/>
    </xsl:variable>
    <xsl:variable name="src-asf-logo">
      <xsl:value-of select="$asf-logo"/>
    </xsl:variable>
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;
    </xsl:text>

<html lang="en">
<head>
  <!-- Note: XSLT seems to always output a
       <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
       when method="html",
       therefore we can't use
       <meta charset="UTF-8"/>.

       In XHTML, this is not needed as the encoding will be
       specified in the XML declaration.
  -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    
  <xsl:apply-templates select="meta"/>
  
  <title><xsl:value-of select="$project/title"/>&#174; - <xsl:value-of select="properties/title"/></title>
  <xsl:for-each select="properties/author">
    <xsl:variable name="name">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:variable name="email">
      <xsl:value-of select="@email"/>
    </xsl:variable>
    <meta name="author" content="{$name}"/>
    <!-- Don't publish e-mail addresses
    <meta name="email" content="{$email}"/>
     -->
  </xsl:for-each>
  <xsl:for-each select="properties/google-site-verification">
    <meta name="google-site-verification" content="{.}"/>
  </xsl:for-each>
  <xsl:if test="properties/base">
    <base href="{properties/base/@href}"/>
  </xsl:if>

  <link rel="stylesheet" href="res/css/bootstrap.css"/>
  <link rel="stylesheet" href="res/css/tomcat.css"/>
  <script>
    var windowFontSize = 16;
    function setFontsize(val){
      windowFontSize = val;
      if (window.localStorage){
        window.localStorage.setItem("font-size", val);
      }
      document.getElementsByTagName("html")[0].style = "font-size: " + val + "px;";
    }
    if (window.localStorage){
      var val = window.localStorage.getItem("font-size");
      if (val){
        setFontsize(val);
      }
    }
  </script>
</head>
<body>
<!-- Header -->

<!-- header-begin !-->
<div class="container topbar">
  <div class="row">
    <div class="col">
      <a href="https://tomcat.apache.org/">
        <img src="res/img/tomcat-logo-tm.svg" id="tomcat-logo" alt="Apache Tomcat logo"/>
      </a>
    </div>
    <div class="col">
      <a href="https://www.apache.org/" target="_blank">
        <img src="res/img/feather.svg" class="asf-logo mx-auto d-sm-none" alt="The Apache Software Foundation"/>
        <img src="res/img/asf_logo.svg" class="asf-logo mx-auto d-none d-sm-block" alt="The Apache Software Foundation"/>
      </a>
    </div>
    <div class="col">
      <a href="https://www.apache.org/foundation/contributing.html" target="_blank">
        <img src="res/img/SupportApache-small.png" class="asf-logo ml-4 float-right" alt="Support Apache"/>
      </a>
    </div>
  </div>
</div>
<header class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
  <div class="container">
    <a class="navbar-brand pad0" href="https://tomcat.apache.org/">
      <div class="navbar-brand-name">Apache Tomcat</div>
      <div class="navbar-logo"><img src="res/img/tomcat-logo-tm.svg" alt="Apache Tomcat logo"/></div>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-supported-content" aria-controls="navbar-supported-content" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbar-supported-content">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Download
          </a>
          <div class="dropdown-menu" aria-labelledby="navbar-dropdown">
            <a class="dropdown-item" href="whichversion.html">Which Version?</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="download-90.cgi">Tomcat 9</a>
            <a class="dropdown-item" href="download-80.cgi">Tomcat 8</a>
            <a class="dropdown-item" href="download-70.cgi">Tomcat 7</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="download-connectors.cgi">Connectors</a>
            <a class="dropdown-item" href="download-native.cgi">Tomcat Native</a>
            <a class="dropdown-item" href="download-taglibs.cgi">Taglibs</a>
            <a class="dropdown-item" href="https://archive.apache.org/dist/tomcat/">Archives</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Docs
          </a>
          <div class="dropdown-menu" aria-labelledby="navbar-dropdown">
            <a class="dropdown-item" href="tomcat-9.0-doc/index.html">Tomcat 9.0</a>
            <a class="dropdown-item" href="tomcat-8.5-doc/index.html">Tomcat 8.5</a>
            <a class="dropdown-item" href="tomcat-7.0-doc/index.html">Tomcat 7.0</a>
            <a class="dropdown-item" href="connectors-doc/index.html">Connectors</a>
            <a class="dropdown-item" href="native-doc/index.html">Tomcat Native</a>
            <a class="dropdown-item" href="taglibs.html">Taglibs</a>
            <a class="dropdown-item" href="maven-plugin.html">Maven Plugin</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="https://wiki.apache.org/tomcat/FrontPage">Wiki</a>
            <a class="dropdown-item" href="migration.html">Migration Guide</a>
            <a class="dropdown-item" href="presentations.html">Presentations</a>
            <a class="dropdown-item" href="https://blogs.apache.org/tomcat/">Blog</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Problems?
          </a>
          <div class="dropdown-menu" aria-labelledby="navbar-dropdown">
            <a class="dropdown-item" href="security.html">Security Reports</a>
            <a class="dropdown-item" href="findhelp.html">Find Help</a>
            <a class="dropdown-item" href="https://wiki.apache.org/tomcat/FAQ">FAQ</a>
            <a class="dropdown-item" href="lists.html">Mailing Lists</a>
            <a class="dropdown-item" href="bugreport.html">Bug Database</a>
            <a class="dropdown-item" href="irc.html">IRC</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Get Involved
          </a>
          <div class="dropdown-menu" aria-labelledby="navbar-dropdown">
            <a class="dropdown-item" href="getinvolved.html">Overview</a>
            <a class="dropdown-item" href="source.html">Source Code</a>
            <a class="dropdown-item" href="ci.html">Buildbot</a>
            <a class="dropdown-item" href="tools.html">Tools</a>
          </div>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbar-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            About
          </a>
          <div class="dropdown-menu" aria-labelledby="navbar-dropdown">
            <a class="dropdown-item" href="whoweare.html">Who We Are</a>
            <a class="dropdown-item" href="https://www.redbubble.com/people/comdev/works/30885254-apache-tomcat">Swag</a>
            <a class="dropdown-item" href="heritage.html">Heritage</a>
            <a class="dropdown-item" href="resources.html">Resources</a>
            <a class="dropdown-item" href="contact.html">Contact</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="https://tomcat.apache.org/">Apache Software Foundation</a>
            <a class="dropdown-item" href="legal.html">Legal</a>
            <a class="dropdown-item" href="https://www.apache.org/foundation/contributing.html">Support Apache</a>
            <a class="dropdown-item" href="https://www.apache.org/foundation/sponsorship.html">Sponsorship</a>
            <a class="dropdown-item" href="https://www.apache.org/foundation/thanks.html">Thanks</a>
            <a class="dropdown-item" href="https://www.apache.org/licenses/">License</a>
          </div>
        </li>
      </ul>
      <form class="form-inline my-2 my-lg-0" action="https://www.google.com/search" method="get">
        <input value="tomcat.apache.org" name="sitesearch" type="hidden"/>
        <input id="search" name="q" class="form-control" type="search" placeholder="Search" aria-label="Search"/>
        <button class="btn btn-light my-2 my-sm-0 no-pointer-events" type="submit"><img src="res/img/search.svg" class="fa"/></button>
      </form>
    </div>
  </div><!-- .container !-->
</header>
<!-- header-end !-->

<div id="content" class="container">



<xsl:apply-templates select="body/section"/>


<!-- Footer -->
</div><!-- .content !-->

<!-- footer-begin !-->
<div class="container">
  <footer class="pt-4 pb-4">
    <div class="container-fluid text-center text-md-left">
      <div class="row">
        <div class="col-md-6 mt-md-0 mt-3">
          <h5 class="text-uppercase">© 1999-2019 The Apache Software Foundation</h5>
          <div>
            Follow us on Social Media:
            <br/>
            <a href="https://twitter.com/TheApacheTomcat"><img src="res/img/twitter-square.svg" class="twitter"/></a>
            <a href="https://www.youtube.com/c/ApacheTomcatOfficial"><img src="res/img/youtube-square.svg" class="youtube ml-4"/></a>
          </div>
        </div>
        <hr class="clearfix w-100 d-md-none pb-3"/>
        <div class="col-md-3 mb-md-0 mb-3">
            <label for="fontSize">Change font size: </label>
            <div class="nowrap">
              <span class="font-sizer-label">A</span>
              <input type="range" id="font-size" min="12" max="20" step="1" value="16"/>
              <span class="font-sizer-label large">A</span>
            </div>
          </div>
          <div class="col-md-3 mb-md-0 mb-3"></div>
      </div>
    </div>

    <div class="row footer-links mt-4">
      <div class="col-md-2"></div>
      <xsl:apply-templates select="$project/body/nav" mode="footer"/>
    </div>

    <hr/>

    <p>Apache Tomcat, Tomcat, Apache, the Apache feather, and the Apache Tomcat project's logo are registered trademarks or trademarks of the Apache Software Foundation.</p>
  </footer>
</div><!-- .container !-->

    <script src="res/js/jquery-3.3.1.slim.min.js"></script>
    <script src="res/js/popper.min.js"></script>
    <script src="res/js/bootstrap.min.js"></script>
    <script src="res/js/tomcat.js"></script>
  </body>
</html>
<!-- footer-end !-->

</xsl:template>

<!-- process footer nav titles -->
<xsl:template match="nav" mode="footer">
  <xsl:variable name="title" select="@name" mode="footer"/>
  <xsl:variable name="id" select="translate($title, ' ', '-')" mode="footer"/>
  <div class="col-md-2">
    <div class="bold" id="{$id}"><xsl:value-of select="$title"/></div>
    <xsl:apply-templates select="navitem" mode="footer"/>
  </div>
</xsl:template>

<!-- process footer nav items -->
<xsl:template match="navitem" mode="footer">
  <xsl:variable name="href">
    <xsl:choose>
      <xsl:when test="starts-with(@href, 'http://')">
          <xsl:value-of select="@href"/>
      </xsl:when>
      <xsl:when test="starts-with(@href, 'https://')">
          <xsl:value-of select="@href"/>
      </xsl:when>
      <xsl:when test="contains(@href, '.cgi')">
          <xsl:text>https://tomcat.apache.org</xsl:text><xsl:value-of select="@href"/>
      </xsl:when>
<!--
      <xsl:when test="starts-with(@href, '/site')">
          <xsl:text>http://tomcat.apache.org</xsl:text><xsl:value-of select="@href"/>
      </xsl:when>
-->
      <xsl:otherwise>
          <xsl:value-of select="$relative-path"/><xsl:value-of select="@href"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <div>
    <a href="{$href}"><xsl:value-of select="@name"/></a>
  </div>
</xsl:template>


<!-- Process <a> links -->
<xsl:template match="a[@href]">
  <xsl:variable name="href">
    <xsl:choose>
      <xsl:when test="starts-with(@href, 'http://')">
          <xsl:value-of select="@href"/>
      </xsl:when>
      <xsl:when test="starts-with(@href, 'https://')">
          <xsl:value-of select="@href"/>
      </xsl:when>
      <xsl:when test="contains(@href, '.cgi')">
          <xsl:text>https://tomcat.apache.org/</xsl:text><xsl:value-of select="@href"/>
      </xsl:when>
      <xsl:otherwise>
          <xsl:value-of select="@href"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:copy>
    <xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
    <xsl:apply-templates select="@*[name()!='href']|*|text()"/>
  </xsl:copy>
</xsl:template>

<!-- Process a documentation section -->
<xsl:template match="section">
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="@anchor">
        <xsl:value-of select="@anchor" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="name">
    <xsl:value-of select="translate($name2, ' #', '__')"/>
  </xsl:variable>

  <!-- Section heading -->
  <h3 id="{$name}">
    <xsl:if test="@rtext">
      <!-- Additional right-aligned text cell in section heading. -->
      <span class="pull-right">
        <xsl:value-of select="@rtext"/>
      </span><xsl:text>&#x20;</xsl:text> <!-- Ensure a space follows after </span> -->
    </xsl:if>
    <xsl:value-of select="@name"/>
  </h3>
  <!-- Section body -->
  <div class="text">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- Process a documentation subsection -->
<xsl:template match="subsection">
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="@anchor">
        <xsl:value-of select="@anchor" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="
            count(//*[self::section or self::subsection][@name=current()/@name]) &gt; 1
            ">
          <xsl:value-of select="concat(parent::*[self::section or self::subsection]/@name, '/')"/>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="name">
    <xsl:value-of select="translate($name2, ' #', '__')"/>
  </xsl:variable>

  <div class="subsection">
    <!-- Subsection heading -->
    <!-- TODO: When a <subsection> is nested in another <subsection>,
         the output should be <h5>, not <h4>. Same with <h6>. -->
    <h4 id="{$name}">
      <xsl:value-of select="@name"/>
    </h4>
    <!-- Subsection body -->
    <div class="text">
      <xsl:apply-templates/>
    </div>
  </div>

</xsl:template>


<!-- Generate table of contents -->
<xsl:template match="toc">
  <ul><xsl:apply-templates mode="toc" select="following::section"/></ul>
</xsl:template>

<xsl:template mode="toc" match="section|subsection">
  <xsl:variable name="name2">
    <xsl:choose>
      <xsl:when test="@anchor">
        <xsl:value-of select="@anchor" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="local-name()='subsection' and
            count(//*[self::section or self::subsection][@name=current()/@name]) &gt; 1
            ">
          <xsl:value-of select="concat(parent::*[self::section or self::subsection]/@name, '/')"/>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="name">
    <xsl:value-of select="translate($name2, ' #', '__')"/>
  </xsl:variable>
  <li><a href="#{$name}"><xsl:value-of select="@name"/></a>
  <xsl:if test="subsection">
    <ol><xsl:apply-templates mode="toc" select="subsection"/></ol>
  </xsl:if>
  </li>
</xsl:template>

<!-- Process a source code example -->
<xsl:template match="source">
<div class="codeBox">
  <pre>
    <xsl:if test="@wrapped='true'">
      <xsl:attribute name="class">wrap</xsl:attribute>
    </xsl:if>
    <code><xsl:apply-templates/></code>
  </pre>
</div>
</xsl:template>

<!-- Link to a bug report -->
<xsl:template match="bug">
    <xsl:variable name="link"><xsl:value-of select="$buglink"/><xsl:value-of select="text()"/></xsl:variable>
    <a href="{$link}"><img src="res/img/bug.svg" class="fa mr-1"/><xsl:apply-templates/></a>
</xsl:template>

<!-- Link to a SVN revision report -->
<xsl:template match="rev">
    <xsl:variable name="link"><xsl:value-of select="$revlink"/><xsl:value-of select="text()"/></xsl:variable>
    <a href="{$link}">r<xsl:apply-templates/></a>
</xsl:template>

<!-- Link to a SVN revision report -->
<!-- It is similat to <rev> tag, but allows arbitrary text inside -->
<xsl:template match="revlink">
    <xsl:variable name="link"><xsl:value-of select="$revlink"/><xsl:value-of select="@rev"/></xsl:variable>
    <a href="{$link}"><xsl:apply-templates/></a>
</xsl:template>

<!-- Link to a CVE report -->
<xsl:template match="cve">
    <xsl:variable name="link"><xsl:value-of select="$cvelink"/><xsl:value-of select="text()"/></xsl:variable>
    <a href="{$link}" rel="nofollow"><xsl:apply-templates/></a>
</xsl:template>

<!-- Process everything else by just passing it through -->
<xsl:template match="*|@*">
  <xsl:copy>
    <xsl:apply-templates select="@*|*|text()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
