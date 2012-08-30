<?xml version="1.0" encoding="UTF-8"?>
<!--

Copyright Antenna House, Inc. (http://www.antennahouse.com) 2001, 2002.

Since this stylesheet is originally developed by Antenna House to be used with XSL Formatter, it may not be compatible with another XSL-FO processors.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, provided that the above copyright notice(s) and this permission notice appear in all copies of the Software and that both the above copyright notice(s) and this permission notice appear in supporting documentation.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

-->

<!--

The current stylesheet is a modification done by Magenta Aps. It is used in an open
source project called 'Document Broker'. The modifications done to the original
stylesheet are done to meet PDF/A specific needs and to integrate the stylesheet
in the application and make it possible to change the appearance of the resulting
PDF/A 1a document from within the template XHTML document.

The style will furthermore be used together with the Apache FOP renderer.

-->


<!--
    Here we specify the stylesheet and the xsl namespaces we use in it.
    We have added the fox and java namespaces.
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"			
                xmlns:java="http://xml.apache.org/xslt/java" exclude-result-prefixes="java">	<!-- fox namespace imported to be used together with image embedding -->
												<!-- java namespace imported to be used together with date and time embedding -->

  <!--
      We avoid problems of additional line breaks by stripping out whitespaces
      in div, body, html and head tags.
  -->
  
  <xsl:strip-space elements="html:div html:body html:html html:head"/>

  <xsl:output method="xml"
              version="1.0"
              encoding="UTF-8"
              indent="yes"/>

  <!--======================================================================
      Parameters
  =======================================================================-->
  
  <!--
      In this section we instantiate the parameters that can be setup in our
      XHTML documents.
      The original parts are commented out.
  -->

  <!-- page size -->
  <xsl:param name="page-width"><xsl:value-of  select="//*[@id = 'page_width'][1]|text()" /></xsl:param>
  <xsl:param name="page-height"><xsl:value-of  select="//*[@id = 'page_height'][1]|text()" /></xsl:param>
  <xsl:param name="header-height"><xsl:value-of  select="//*[@id = 'header_height'][1]|text()" /></xsl:param>
  <xsl:param name="footer-height"><xsl:value-of  select="//*[@id = 'footer_height'][1]|text()" /></xsl:param>
  <!--
  <xsl:param name="page-margin-left">0in</xsl:param>
  <xsl:param name="page-margin-right">0in</xsl:param>
  -->

  <!-- page header and footer -->
  <!--
  <xsl:param name="page-header-margin">0</xsl:param>
  <xsl:param name="page-footer-margin">0</xsl:param>
  <xsl:param name="title-print-in-header">false</xsl:param>
  <xsl:param name="page-number-print-in-footer">false</xsl:param>
  -->

  <!-- multi column -->
  <!--
  <xsl:param name="column-count">1</xsl:param>
  <xsl:param name="column-gap">12pt</xsl:param>
  -->

  <!-- writing-mode: lr-tb | rl-tb | tb-rl -->
  <xsl:param name="writing-mode"><xsl:value-of  select="//*[@id = 'text_direction'][1]|text()" /></xsl:param>

  <!-- text-align: justify | start -->
  <xsl:param name="text-align"><xsl:value-of  select="//*[@id = 'text_mode'][1]|text()" /></xsl:param>

  <!-- hyphenate: true | false -->
  <xsl:param name="hyphenate"><xsl:value-of  select="//*[@id = 'hyphenize'][1]|text()" /></xsl:param>

  <xsl:param name="sidebar_width"><xsl:value-of  select="//*[@id = 'sidebar_width'][1]|text()" /></xsl:param>

  <xsl:param name="def_p"><xsl:value-of  select="//*[@id = 'def_p'][1]/@style" /></xsl:param>
  <xsl:param name="def_h1"><xsl:value-of  select="//*[@id = 'def_h1'][1]/@style" /></xsl:param>
  <xsl:param name="def_h2"><xsl:value-of  select="//*[@id = 'def_h2'][1]/@style" /></xsl:param>
  <xsl:param name="def_h3"><xsl:value-of  select="//*[@id = 'def_h3'][1]/@style" /></xsl:param>
  <xsl:param name="def_h4"><xsl:value-of  select="//*[@id = 'def_h4'][1]/@style" /></xsl:param>
  <xsl:param name="def_h5"><xsl:value-of  select="//*[@id = 'def_h5'][1]/@style" /></xsl:param>
  <xsl:param name="def_h6"><xsl:value-of  select="//*[@id = 'def_h6'][1]/@style" /></xsl:param>




  <!--======================================================================
      Attribute Sets
  =======================================================================-->

  <!--
      The attribute sets are based on the set originally created by Antennahouse.
      Some are modified a bit though to meet our needs. The original parts are
      commented out.
  -->

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Classes
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template name="class-template">
    <xsl:param name="class"/>
    <xsl:choose>
      <xsl:when test="$class = 'odd'">
        <xsl:attribute name="background-color">#EEE</xsl:attribute>
      </xsl:when>
      <xsl:when test="$class = 'numeric'">
        <xsl:attribute name="text-align">right</xsl:attribute>
      </xsl:when>
      <xsl:when test="$class = 'line'">
        <xsl:attribute name="border-top">1px dotted #AAA</xsl:attribute>
      </xsl:when>
    </xsl:choose>  
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Root
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->
  
  <xsl:attribute-set name="root">
    <xsl:attribute name="writing-mode"><xsl:value-of select="$writing-mode"/></xsl:attribute>
    <xsl:attribute name="hyphenate"><xsl:value-of select="$hyphenate"/></xsl:attribute>
    <xsl:attribute name="text-align"><xsl:value-of select="$text-align"/></xsl:attribute>
    <!--<xsl:attribute name="font-family">Free Serif</xsl:attribute>-->
    <!-- specified on fo:root to change the properties' initial values -->
  </xsl:attribute-set>

  <xsl:attribute-set name="page">
    <xsl:attribute name="page-width"><xsl:value-of select="$page-width"/></xsl:attribute>
    <xsl:attribute name="page-height"><xsl:value-of select="$page-height"/></xsl:attribute>
    <!-- specified on fo:simple-page-master -->
  </xsl:attribute-set>

  <xsl:attribute-set name="body">
    <!-- specified on fo:flow's only child fo:block -->
  </xsl:attribute-set>

  <xsl:attribute-set name="page-header">
    <!-- specified on (page-header)fo:static-content's only child fo:block -->
    <xsl:attribute name="font-size">6pt</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="page-footer">
    <!-- specified on (page-footer)fo:static-content's only child fo:block -->
    <xsl:attribute name="font-size">6pt</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Block-level
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <!--
      We added roles to fo:block inorder to make the final PDF-document tagged
      in the right way.
      This part is extremely important for accessibility to work.
      
      All font-family definitions are removed. This is done because PDF/A 1a
      require all fonts used to be embedded in the document. Unfortunately the
      fonts used in the original stylesheet were proprietary and as we are
      building an open source application we want to use only open font types.
      Thus the stylesheet is stripped from font definitions. These will be set
      int the XHTML document. It will be documented which font types are available
      to the user. On the time writing these fonts are the Liberation fonts
      available on most GNU/Linux distributions.
  -->

  <xsl:attribute-set name="h1">
    <xsl:attribute name="role">H1</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h2">
    <xsl:attribute name="role">H2</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h3">
    <xsl:attribute name="role">H3</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h4">
    <xsl:attribute name="role">H4</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h5">
    <xsl:attribute name="role">H5</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="h6">
    <xsl:attribute name="role">H6</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="p">
    <xsl:attribute name="role">P</xsl:attribute>
    <!-- e.g.,
    <xsl:attribute name="text-indent">1em</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="p-initial" use-attribute-sets="p">
    <!-- initial paragraph, preceded by h1..6 or div -->
    <!-- e.g.,
    <xsl:attribute name="text-indent">0em</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="p-initial-first" use-attribute-sets="p">
    <!-- initial paragraph, first child of div, body or td -->
  </xsl:attribute-set>

  <xsl:attribute-set name="blockquote">
    <xsl:attribute name="start-indent">inherited-property-value(start-indent) + 24pt</xsl:attribute>
    <xsl:attribute name="end-indent">inherited-property-value(end-indent) + 24pt</xsl:attribute>
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="pre">
    <xsl:attribute name="font-size">0.83em</xsl:attribute>
    <xsl:attribute name="white-space">pre</xsl:attribute>
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="address">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="hr">
    <xsl:attribute name="border">1px inset</xsl:attribute>
    <xsl:attribute name="space-before">0.67em</xsl:attribute>
    <xsl:attribute name="space-after">0.67em</xsl:attribute>
  </xsl:attribute-set>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       List
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="ul">
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ul-nested">
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol">
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol-nested">
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ul-li">
    <!-- for (unordered)fo:list-item -->
    <xsl:attribute name="relative-align">baseline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="ol-li">
    <!-- for (ordered)fo:list-item -->
    <xsl:attribute name="relative-align">baseline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dl">
    <xsl:attribute name="space-before">1em</xsl:attribute>
    <xsl:attribute name="space-after">1em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dt">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="dd">
    <xsl:attribute name="start-indent">inherited-property-value(start-indent) + 24pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- list-item-label format for each nesting level -->

  <xsl:param name="ul-label-1">&#x2022;</xsl:param>
  <xsl:attribute-set name="ul-label-1">
    <xsl:attribute name="font">1em Free Serif</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="ul-label-2">o</xsl:param>
  <xsl:attribute-set name="ul-label-2">
    <xsl:attribute name="font">0.67em Free Serif</xsl:attribute>
    <xsl:attribute name="baseline-shift">0.25em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="ul-label-3">-</xsl:param>
  <xsl:attribute-set name="ul-label-3">
    <xsl:attribute name="font-weight">700</xsl:attribute>
    <xsl:attribute name="font-size">0.9em</xsl:attribute>
    <xsl:attribute name="baseline-shift">0.05em</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="ol-label-1">1.</xsl:param>
  <xsl:attribute-set name="ol-label-1"/>

  <xsl:param name="ol-label-2">a.</xsl:param>
  <xsl:attribute-set name="ol-label-2"/>

  <xsl:param name="ol-label-3">i.</xsl:param>
  <xsl:attribute-set name="ol-label-3"/>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Table
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="inside-table">
    <!-- prevent unwanted inheritance -->
    <xsl:attribute name="start-indent">0pt</xsl:attribute>
    <xsl:attribute name="end-indent">0pt</xsl:attribute>
    <xsl:attribute name="text-indent">0pt</xsl:attribute>
    <xsl:attribute name="last-line-end-indent">0pt</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
    <xsl:attribute name="text-align-last">relative</xsl:attribute>
  </xsl:attribute-set>
  
  <!--
      Beware FOP (at least the current version - 1.0) does not support table
      captions yet!
  -->

  <xsl:attribute-set name="table-and-caption" >
    <!-- horizontal alignment of table itself
    <xsl:attribute name="text-align">center</xsl:attribute>
    -->
    <!-- vertical alignment in table-cell 
    <xsl:attribute name="display-align">center</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="table">
    <xsl:attribute name="table-layout">fixed</xsl:attribute>
  <!--
    <xsl:attribute name="width">100%</xsl:attribute>
    <xsl:attribute name="border">1px solid white</xsl:attribute>
  -->
    <!-- 
    <xsl:attribute name="border-collapse">separate</xsl:attribute>
    <xsl:attribute name="border-spacing">2px</xsl:attribute>
    <xsl:attribute name="border-style">outset</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="table-caption" use-attribute-sets="inside-table">
    <xsl:attribute name="role">Caption</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="table-column">
  </xsl:attribute-set>

  <xsl:attribute-set name="thead" use-attribute-sets="inside-table">
  </xsl:attribute-set>

  <xsl:attribute-set name="tfoot" use-attribute-sets="inside-table">
  </xsl:attribute-set>

  <xsl:attribute-set name="tbody" use-attribute-sets="inside-table">
    <xsl:attribute name="role">TBody</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tr">
   <xsl:attribute name="border">none</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="th">
    <xsl:attribute name="font-weight">700</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
    <xsl:attribute name="border">none</xsl:attribute>
    <!-- 
    <xsl:attribute name="border">1px</xsl:attribute>
    <xsl:attribute name="border-style">inset</xsl:attribute>
    -->
    <xsl:attribute name="padding">1px</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="td">
    <xsl:attribute name="border-top">0</xsl:attribute>
    <xsl:attribute name="margin-left">10px</xsl:attribute>
    <!--
    <xsl:attribute name="border-style">inset</xsl:attribute>
    -->
    <xsl:attribute name="padding">1px</xsl:attribute>
  </xsl:attribute-set>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Inline-level
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="b">
    <xsl:attribute name="font-weight">700</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="strong">
    <xsl:attribute name="font-weight">700</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="strong-em">
    <xsl:attribute name="font-weight">700</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="i">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="cite">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="em">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="var">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="dfn">
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="tt">
  </xsl:attribute-set>
  <xsl:attribute-set name="code">
  </xsl:attribute-set>
  <xsl:attribute-set name="kbd">
  </xsl:attribute-set>
  <xsl:attribute-set name="samp">
  </xsl:attribute-set>

  <xsl:attribute-set name="big">
    <xsl:attribute name="font-size">larger</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="small">
    <xsl:attribute name="font-size">smaller</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="sub">
    <xsl:attribute name="baseline-shift">sub</xsl:attribute>
    <xsl:attribute name="font-size">smaller</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="sup">
    <xsl:attribute name="baseline-shift">super</xsl:attribute>
    <xsl:attribute name="font-size">smaller</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="s">
    <xsl:attribute name="text-decoration">line-through</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="strike">
    <xsl:attribute name="text-decoration">line-through</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="del">
    <xsl:attribute name="text-decoration">line-through</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="u">
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="ins">
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="abbr">
    <!-- e.g.,
    <xsl:attribute name="font-variant">small-caps</xsl:attribute>
    <xsl:attribute name="letter-spacing">0.1em</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="acronym">
    <!-- e.g.,
    <xsl:attribute name="font-variant">small-caps</xsl:attribute>
    <xsl:attribute name="letter-spacing">0.1em</xsl:attribute>
    -->
  </xsl:attribute-set>

  <xsl:attribute-set name="q"/>
  <xsl:attribute-set name="q-nested"/>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Image
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="img">
  </xsl:attribute-set>

  <xsl:attribute-set name="img-link">
    <xsl:attribute name="border">2px solid</xsl:attribute>
  </xsl:attribute-set>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Link
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="a-link">
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
    <xsl:attribute name="color">blue</xsl:attribute>
  </xsl:attribute-set>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       DIV
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:attribute-set name="div">
    <!--<xsl:attribute name="border">0</xsl:attribute>-->
  </xsl:attribute-set>


  <!--======================================================================
      Templates
  =======================================================================-->

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Root
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <!--
      We do not want to react on head (Except from the title tag which we fetch
      directly) and script tags.
  -->
  <xsl:template match="html:head | html:script"/>

  <!--
      The div tags are versatile for our setup process so we initiate the document
      setup when we are met with a div tag.
  -->
  <xsl:template match="html:div">
    <xsl:choose>
      <!--
          We define the root element based on the details supplied in the
          child elements of the div tag with the id 'init'.
      -->
      <xsl:when test="@id = 'init'">
        <fo:root>
          <xsl:call-template name="process-style">
            <xsl:with-param name="style" select="substring-before(@style, ';')"/>
      	  </xsl:call-template>
          <xsl:call-template name="process-master-set">
            <xsl:with-param name="style" select="@style"/>
          </xsl:call-template>

	  <!--
	      METADATA
	  -->
    
	  <fo:declarations>
	    <x:xmpmeta xmlns:x="adobe:ns:meta/">
	      <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
          <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
            <dc:title><rdf:Alt><rdf:li xml:lang="en-US"><xsl:value-of select="/html:html/html:head/html:title"/></rdf:li></rdf:Alt></dc:title>
            <dc:creator><rdf:Seq><rdf:li>Document Broker by Magenta Aps</rdf:li></rdf:Seq></dc:creator>
            <dc:description><rdf:Alt><rdf:li xml:lang="en-us">No description available  - to be implemented</rdf:li></rdf:Alt></dc:description>
            <dc:subject><rdf:Bag>No description available  - to be implemented</rdf:Bag></dc:subject>
            <!--
              We use java (Xalan) to fetch the current date and time (set on the server)
            -->
            <dc:date><rdf:Seq><rdf:li><xsl:value-of select="java:format(java:java.text.SimpleDateFormat.new('yyyy-MM-dd'), java:java.util.Date.new())"/></rdf:li></rdf:Seq></dc:date>
            <dc:language><xsl:value-of select="/html:html/@lang"/></dc:language>
          </rdf:Description>
          <rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
            <xmp:CreatorTool>Document Broker by Magenta Aps</xmp:CreatorTool>
          </rdf:Description>
	      </rdf:RDF>
	    </x:xmpmeta>
	  </fo:declarations>

	  <!--
	      BOOKMARKS
	  -->

	  <fo:bookmark-tree>
      <!--
          First we list the text bookmarks by traversing through the h1-6 and p tags of the document,
          but only if they contain a title and id attribute.
      -->
	    <xsl:for-each select="//html:div[@id = 'page_contents']/html:h1[@title and @id] | //html:div[@id = 'page_contents']/html:h2[@title and @id] | //html:div[@id = 'page_contents']/html:h3[@title and @id] | //html:div[@id = 'page_contents']/html:h4[@title and @id] | //html:div[@id = 'page_contents']/html:h5[@title and @id] | //html:div[@id = 'page_contents']/html:h6[@title and @id] | //html:div[@id = 'page_contents']/html:p[@title and @id]">
	      <xsl:call-template name="process-bookmarks" />
	    </xsl:for-each>
      <!-- Next we list the figures/tables by traversing those respectively. -->
	    <xsl:for-each select="//*/html:div[@class = 'alignment_block'][@title and @id] | //*/html:div[starts-with(@class, 'figure')][@title and @id]">
	      <xsl:call-template name="process-bookmarks-figures" />
	    </xsl:for-each>
	  </fo:bookmark-tree>
    
    <!--
        PAGE SETUP
    -->

	  <fo:page-sequence master-reference="all-pages" role="Part">
      <!-- We define the static parts of the document based on the info provided by the XHTML -->
	    <fo:title xml:lang="en-US"><xsl:value-of select="/html:html/html:head/html:title"/></fo:title>
	    <xsl:for-each select="child::html:div">
	      <xsl:choose>
          <xsl:when test="@id = 'page_header'">
            <fo:static-content flow-name="page-header" role="Sect">
              <xsl:call-template name="process-style">
                <xsl:with-param name="style" select="@style"/>
              </xsl:call-template>
              <fo:block space-before.conditionality="retain" width="100%">
                  <xsl:call-template name="process-common-attributes-and-children"/>
              </fo:block>
            </fo:static-content>
          </xsl:when>
          <xsl:when test="@id = 'page_footer_with_page_number'">
            <fo:static-content flow-name="page-footer" role="Sect">
              <fo:block space-after.conditionality="retain" text-align-last="justify" role="P">
                <!-- We specify that the footer text should be written to the left and the page number should be written to the right -->
                  <xsl:call-template name="process-common-attributes-and-children"/>
                  <fo:leader leader-pattern="space" />Side <fo:page-number />
              </fo:block>
            </fo:static-content>
          </xsl:when>
          <xsl:when test="@id = 'page_footer'">
            <fo:static-content flow-name="page-footer" role="Sect">
              <fo:block space-after.conditionality="retain" role="Span">
                <xsl:call-template name="process-common-attributes-and-children"/>
              </fo:block>
            </fo:static-content>
          </xsl:when>
          <xsl:when test="@id = 'sidebar_right'">
            <fo:static-content flow-name="sidebar-right" role="Sect">
              <fo:block space-after.conditionality="retain" role="Div">
                <xsl:call-template name="process-common-attributes-and-children"/>
              </fo:block>
            </fo:static-content>
          </xsl:when>
          <xsl:when test="@id = 'sidebar_left'">
            <fo:static-content flow-name="sidebar-left" role="Sect">
              <fo:block space-after.conditionality="retain" role="Div">
                <xsl:call-template name="process-common-attributes-and-children"/>
              </fo:block>
            </fo:static-content>
          </xsl:when>
              </xsl:choose>
            </xsl:for-each>
            <fo:flow flow-name="xsl-region-body" role="Sect">
              <fo:block xsl:use-attribute-sets="body">
                <xsl:apply-templates />
              </fo:block>
            </fo:flow>
          </fo:page-sequence>
          </fo:root>
        </xsl:when>
        <!--
            All the table definitions in the below part are used to get around
            the annoying fact that FOP cannot align objects. These table
            structures are instantiated through div tags in the XHTML document.
        -->
        <xsl:when test="@class = 'alignment_block'">
          <fo:table writing-mode="lr-tb" role="Table" table-layout="fixed" width="100%">
            <xsl:if test="@title">
              <xsl:attribute name="fox:alt-text">
                <xsl:value-of select="@title"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="process-style">
              <xsl:with-param name="style" select="@style"/>
            </xsl:call-template>
            <fo:table-body role="TBody">
              <fo:table-row role="TR">
                <xsl:call-template name="process-common-attributes-and-children"/>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:when>
        <xsl:when test="@class = 'block_left'">
          <fo:table-cell display-align="after" role="TD">
            <fo:block end-indent="0in" text-align="left" role="Div">
              <xsl:call-template name="process-common-attributes-and-children"/>
            </fo:block>
          </fo:table-cell>
        </xsl:when>
        <xsl:when test="@class = 'block_right'">
          <fo:table-cell display-align="after" role="TD">
            <fo:block end-indent="0in" text-align="right" role="Div">
              <xsl:call-template name="process-common-attributes-and-children"/>
            </fo:block>
          </fo:table-cell>
        </xsl:when>
        <xsl:when test="@class = 'page_break'">
          <fo:block page-break-before="always" role="Div" />
        </xsl:when>
        <xsl:when test="@class = 'center_figure_in_parent'">
          <fo:table table-layout="fixed" width="100%" writing-mode="lr-tb" role="Table">
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-column>
              <xsl:if test="./html:table[1]/@width">
                <xsl:attribute name="column-width">
                  <xsl:value-of select="./html:table[1]/@width" />
                </xsl:attribute>
                <xsl:attribute name="width">
                  <xsl:value-of select="./html:table[1]/@width" />
                </xsl:attribute>
              </xsl:if>
            </fo:table-column>
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-body role="TBody">
              <fo:table-row role="TR">
                <fo:table-cell column-number="2" display-align="after" role="TD">
                  <fo:block text-align="center" role="Span"><xsl:call-template name="process-common-attributes-and-children"/></fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:when>
        <xsl:when test="@class = 'figure_left_in_parent'">
          <fo:table table-layout="fixed" width="100%" writing-mode="lr-tb" role="Table">
            <fo:table-column>
              <xsl:attribute name="column-width">
                <xsl:value-of select="./html:table[1]/@width" />
              </xsl:attribute>
              <xsl:attribute name="width">
                <xsl:value-of select="./html:table[1]/@width" />
              </xsl:attribute>
            </fo:table-column>
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-body role="TBody">
              <fo:table-row role="TR">
                <fo:table-cell column-number="1" display-align="after" role="TD">
                  <fo:block text-align="left" role="Span"><xsl:call-template name="process-common-attributes-and-children"/></fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:when>
        <xsl:when test="@class = 'figure_right_in_parent'">
          <fo:table table-layout="fixed" width="100%" writing-mode="lr-tb" role="Table">
            <fo:table-column column-width="proportional-column-width(1)"/>
            <fo:table-column>
              <xsl:attribute name="column-width">
                <xsl:value-of select="./html:table[1]/@width" />
              </xsl:attribute>
              <xsl:attribute name="width">
                <xsl:value-of select="./html:table[1]/@width" />
              </xsl:attribute>
            </fo:table-column>
            <fo:table-body role="TBody">
              <fo:table-row role="TR">
                <fo:table-cell column-number="2" display-align="after" role="TD">
                  <xsl:call-template name="process-common-attributes-and-children"/>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:when>
        <xsl:when test="@id = 'page_header' or @id = 'page_footer' or @id = 'page_footer_with_page_number' or @id = 'sidebar_left' or @id = 'sidebar_right' or @id = 'def_p' or @id = 'def_h1' or @id = 'def_h2' or @id = 'def_h3' or @id = 'def_h4' or @id = 'def_h5' or @id = 'def_h6' or @id = 'page_width' or @id = 'page_height' or @id = 'header_height' or @id = 'footer_height' or @id = 'sidebar_width' or @id = 'text_mode' or @id = 'text_direction' or @id = 'hyphenize'"></xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="process-common-attributes-and-children"/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  <!-- 
      This is where the actual bookmarking process is done.
      We receive the heading elements containing a title and id attribute and
      create bokkmarks out of that information
  -->

  <xsl:template name="process-bookmarks">
    <xsl:if test="@title">
      <fo:bookmark>
        <!-- Here we set the anchor for the bookmark -->
        <xsl:attribute name="internal-destination"><xsl:value-of select="@id" /></xsl:attribute>
        <!-- and here we set the title -->
        <fo:bookmark-title>
          <xsl:value-of select="@title" />
        </fo:bookmark-title>
      </fo:bookmark>
    </xsl:if>
  </xsl:template>
  
  <!--
      Here we create the figure bookmarks. These will have the preceeding text
      'Figur:' attached to the title, so the reader can see that this is a
      reference to graphics element.
  -->

  <xsl:template name="process-bookmarks-figures">
    <xsl:if test="@title">
      <fo:bookmark>
        <xsl:attribute name="internal-destination"><xsl:value-of select="@id" /></xsl:attribute>
        <fo:bookmark-title>
          <xsl:text>Figur: </xsl:text><xsl:value-of select="@title" />
        </fo:bookmark-title>
      </fo:bookmark>
    </xsl:if>
  </xsl:template>
  
  <!--
      Here we setup the way the pages will appear.
      We construct the layout based on the information we collect from the
      XHTML document.
  -->

  <xsl:template name="process-master-set">
	  <fo:layout-master-set>
      <!-- This layout will count for all pages in the resulting PDF document. -->
	    <fo:simple-page-master master-name="all-pages" xsl:use-attribute-sets="page">
        <!-- Here we define the layout for the body region of the document. -->
	      <fo:region-body>
          <xsl:call-template name="process-style">
            <xsl:with-param name="style" select="substring-after(@style, ';')"/>
          </xsl:call-template>
	      </fo:region-body>
        <xsl:choose>
          <xsl:when test="$writing-mode = 'tb-rl'">
            <xsl:choose>
              <xsl:when test="not($sidebar_width = '')">
                <!--
                    If sidebars are used in the document we set the extent
                    based on the info we collect.
                -->
                <fo:region-before region-name="sidebar-left"
                      extent="{$sidebar_width}"/>
                <fo:region-after region-name="sidebar-right"
                      extent="{$sidebar_width}"/>
              </xsl:when>
              <xsl:otherwise>
                <!--
                    If sidebars are not used we just set them to be empty.
                -->
                <fo:region-before region-name="sidebar-left"/>
                <fo:region-after region-name="sidebar-right"/>
              </xsl:otherwise>
            </xsl:choose>
            <!--
                If a page header is set we set it up according to the
                info collected.
            -->
            <xsl:if test="./html:div[@id = 'page_header']">
              <fo:region-start  region-name="page-header"
                    extent="{$header-height}"
                    writing-mode="lr-tb"
                    display-align="before"
                    precedence="true"/>
            </xsl:if>
            <!--
                The foot likewise.
            -->
            <xsl:if test="./html:div[@id = 'page_footer'] or ./html:div[@id = 'page_footer_with_page_number']">
              <fo:region-end    region-name="page-footer"
                    extent="{$footer-height}"
                    writing-mode="lr-tb"
                    display-align="after"
                    precedence="true"/>
            </xsl:if>
          </xsl:when>
          <xsl:when test="$writing-mode = 'rl-tb'">
            <xsl:if test="./html:div[@id = 'page_header']">
              <fo:region-before region-name="page-header"
                    extent="{$header-height}"
                    display-align="before"
                    precedence="true"/>
            </xsl:if>
            <xsl:if test="./html:div[@id = 'page_footer'] or ./html:div[@id = 'page_footer_with_page_number']">
              <fo:region-after  region-name="page-footer"
                    extent="{$footer-height}"
                    display-align="after"
                    precedence="true"/>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="not($sidebar_width = '')">
                <fo:region-start region-name="sidebar-left"
                      extent="{$sidebar_width}"/>
                <fo:region-end  region-name="sidebar-right"
                      extent="{$sidebar_width}"/>
              </xsl:when>
              <xsl:otherwise>
                <fo:region-start region-name="sidebar-left"/>
                <fo:region-end  region-name="sidebar-right"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise><!-- $writing-mode = 'lr-tb' -->
            <xsl:if test="./html:div[@id = 'page_header']">
              <fo:region-before region-name="page-header"
                  extent="{$header-height}"
                  display-align="before"
                  precedence="true"/>
            </xsl:if>
            <xsl:if test="./html:div[@id = 'page_footer'] or ./html:div[@id = 'page_footer_with_page_number']">
              <fo:region-after  region-name="page-footer"
                  extent="{$footer-height}"
                  display-align="after"
                  precedence="true"/>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="not($sidebar_width = '')">
                <fo:region-start region-name="sidebar-left"
                      extent="{$sidebar_width}"/>
                <fo:region-end  region-name="sidebar-right"
                      extent="{$sidebar_width}"/>
              </xsl:when>
              <xsl:otherwise>
                <fo:region-start region-name="sidebar-left"/>
                <fo:region-end  region-name="sidebar-right"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
	      </xsl:choose>
	    </fo:simple-page-master>
	  </fo:layout-master-set>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   process common attributes and children
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->
  
  <!--
      In the following part we have only modified the 'process-common-attributes'
      template.
      The reason for editing this part is to meet the demands of the PDF/a format
      There are strict rules of how documents are structured and if they are
      not the resulting document will not be conformant.
      Beware about PDF tags that they are case sensitive and to make it all a
      lot more dificult some of them are actually camel case. Luckily the ones
      we are using at the moment are not.
  -->

  <xsl:template name="process-common-attributes-and-children">
    <xsl:call-template name="process-common-attributes"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="process-common-attributes">
    <xsl:choose>
      <!--
          We capture the 'alignment_block' definition and set the role to TR.
      -->
      <xsl:when test="@class = 'alignment_block'">
        <xsl:attribute name="role">TR</xsl:attribute>
      </xsl:when>
      <!--
          Here we ommit adding any role to the given elements because they are
          defined in the blocks above.
      -->
      <xsl:when test="local-name() = 'div' and (@class = 'block_left' or @class = 'block_right' or @class = 'figure_right_in_parent' or @class = 'center_figure_in_parent' or @class = 'figure_left_in_parent' or @id = 'page_footer_with_page_number' or @id = 'page_footer')"></xsl:when>
      <!--
          PDF/A does not have an element img, but use the element Figure instead.
      -->
      <xsl:when test="local-name() = 'img'">
        <xsl:attribute name="role">Figure</xsl:attribute>
      </xsl:when>
      <!--
          We catch that consist of 2 character or less (td, tr etc.) and make
          them upper case as that is needed in PDF/A
      -->
      <xsl:when test="string-length(local-name()) &lt;= 2">
        <xsl:attribute name="role"><xsl:value-of select="translate(local-name(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /></xsl:attribute>
      </xsl:when>
      <!--
          Here we catch thead, tfoot and tbody as these have two preceeding
          capital charachters and the rest lower case in PDF/A.
      -->
      <xsl:when test="substring(local-name(),1,3) = 'th' or substring(local-name(),1,3) = 'tf' or substring(local-name(),1,3) = 'tb'">
        <xsl:attribute name="role"><xsl:value-of select="concat(translate(substring(local-name(),1,2),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'), translate(substring(local-name(),3),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'))"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="role">
          <!--
              The rest of the tags we give an upper case preceeding charachter
              and make the rest lower case - again to meet the PDF/A specifications.
          -->
          <xsl:value-of select="concat(translate(substring(local-name(),1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'), translate(substring(local-name(),2),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'))"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="@xml:lang">
        <xsl:attribute name="xml:lang">
          <xsl:value-of select="@xml:lang"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="@lang">
        <xsl:attribute name="xml:lang">
          <xsl:value-of select="@lang"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="@id">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="self::html:a/@name">
        <xsl:attribute name="id">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>

    <xsl:if test="@align">
      <xsl:choose>
        <xsl:when test="self::html:caption">
        </xsl:when>
        <xsl:when test="self::html:img or self::html:object">
          <xsl:if test="@align = 'bottom' or @align = 'middle' or @align = 'top'">
            <xsl:attribute name="vertical-align">
              <xsl:value-of select="@align"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="process-cell-align">
            <xsl:with-param name="align" select="@align"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:call-template name="process-cell-valign">
        <xsl:with-param name="valign" select="@valign"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="@style">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="@style"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="@class">
      <xsl:call-template name="process-class">
        <xsl:with-param name="class" select="@class"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="process-style">
    <xsl:param name="style"/>
    <!-- e.g., style="text-align: center; color: red"
         converted to text-align="center" color="red" -->
    <xsl:variable name="name"
                  select="normalize-space(substring-before($style, ':'))"/>
    <xsl:if test="$name">
      <xsl:variable name="value-and-rest"
                    select="normalize-space(substring-after($style, ':'))"/>
      <xsl:variable name="value">
        <xsl:choose>
          <xsl:when test="contains($value-and-rest, ';')">
            <xsl:value-of select="normalize-space(substring-before($value-and-rest, ';'))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$value-and-rest"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$name = 'width' and (self::html:col or self::html:colgroup)">
          <xsl:attribute name="column-width">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="$name = 'width' and (self::html:table)">
          <xsl:attribute name="column-width">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
          <xsl:attribute name="width">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="$name = 'margin-left' or $name = 'margin-right' or $name = 'margin'">
          <xsl:attribute name="{$name}">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="$name = 'vertical-align' and (
                                 self::html:table or self::html:caption or
                                 self::html:thead or self::html:tfoot or
                                 self::html:tbody or self::html:colgroup or
                                 self::html:col or self::html:tr or
                                 self::html:th or self::html:td)">
          <xsl:choose>
            <xsl:when test="$value = 'top'">
              <xsl:attribute name="display-align">before</xsl:attribute>
            </xsl:when>
            <xsl:when test="$value = 'bottom'">
              <xsl:attribute name="display-align">after</xsl:attribute>
            </xsl:when>
            <xsl:when test="$value = 'middle'">
              <xsl:attribute name="display-align">center</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="display-align">auto</xsl:attribute>
              <xsl:attribute name="relative-align">baseline</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      	<xsl:when test="$name = 'float'">
          <xsl:attribute name="float">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="$name = 'font-family'">
          <xsl:attribute name="font-family">
            <xsl:value-of select="$value"/>
          </xsl:attribute>
      	</xsl:when>
        <xsl:otherwise>
          <xsl:if test="$name != 'margin-left' and $name != 'margin-right' and $name != 'margin'">
            <xsl:attribute name="{$name}">
              <xsl:value-of select="$value"/>
            </xsl:attribute>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:variable name="rest" select="normalize-space(substring-after($style, ';'))"/>
    <xsl:if test="$rest">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$rest"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="process-class">
    <xsl:param name="class"/>
    <!-- e.g., Breaking logic (for table cells and block level objects) 'break-before' 
         and 'break-after' converted to break-before="<context>" or break-after="<context>" 
         where <context> is column if it is within a table otherwise page -->

    <!-- e.g., Keeping logic (for table cells and block level objects) 'keep-together' 
         and 'keep-with-next' and 'keep-with-previous' and converted to 
         keep-together.within-<context>="always" etc. where <context> is line if 
         the declaration is found on an inline level element, column if within a 
         table cell otherwise page -->

    <xsl:variable name="name" select="normalize-space(substring-before(concat($class, ' '), ' '))" />
    <xsl:if test="$name">
      <xsl:choose>
        <xsl:when test="($name = 'break-before' or $name = 'break-after') and 
                        (self::html:col or 
                         self::html:colgroup or 
                         self::html:th or 
                         self::html:td)">
          <xsl:attribute name="{$name}">column</xsl:attribute>
        </xsl:when>
        
        <xsl:when test="($name = 'keep-together' or $name = 'keep-with-next' or $name = 'keep-with-previous') and 
                        (self::html:a or 
                         self::html:abbr or 
                         self::html:acronym or 
                         self::html:b or 
                         self::html:basefont or 
                         self::html:bdo or 
                         self::html:big or 
                         self::html:br or 
                         self::html:cite or 
                         self::html:code or 
                         self::html:dfn or 
                         self::html:em or 
                         self::html:font or 
                         self::html:i or 
                         self::html:img or 
                         self::html:input or 
                         self::html:kbd or 
                         self::html:label or 
                         self::html:q or 
                         self::html:s or 
                         self::html:samp or 
                         self::html:select or 
                         self::html:small or 
                         self::html:span or 
                         self::html:strike or 
                         self::html:strong or 
                         self::html:sub or 
                         self::html:sup or 
                         self::html:textarea or 
                         self::html:tt or 
                         self::html:u or 
                         self::html:var)">
          <xsl:attribute name="{$name}.within-line">always</xsl:attribute>
        </xsl:when>
        
        <xsl:when test="($name = 'keep-together' or $name = 'keep-with-next' or $name = 'keep-with-previous') and 
                        (self::html:col or 
                         self::html:colgroup or 
                         self::html:th or 
                         self::html:td)">
          <xsl:attribute name="{$name}.within-column">always</xsl:attribute>
        </xsl:when>

        <xsl:when test="($name = 'keep-together' or $name = 'keep-with-next' or $name = 'keep-with-previous')"> 
          <xsl:attribute name="{$name}.within-page">always</xsl:attribute>
        </xsl:when>
        
        <xsl:when test="($name = 'break-before' or $name = 'break-after')">
          <xsl:attribute name="{$name}">page</xsl:attribute>
        </xsl:when>
        
        <xsl:otherwise>
          <xsl:call-template name="class-template">
            <xsl:with-param name="class" select="$name"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:variable name="rest" select="normalize-space(substring-after($class, ' '))" />
    <xsl:if test="$rest">
      <xsl:call-template name="process-class">
        <xsl:with-param name="class" select="$rest"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Block-level
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->
  
  <!--
      In this part we have changed the definition of h1-6 and p tags.
      These are extremely important tags in PDF/A documents and thus we have
      to define them according to the rules. Furthermore we give them the
      styles defined in the XHTML document which is why we pass them the
      def_x variables that we defined in the beginning of the stylesheet.
      
      We have also made some small changes til div tags - the original lines
      are commented out.
  -->

  <xsl:template match="html:h1">
    <fo:block xsl:use-attribute-sets="h1">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h1" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:h2">
    <fo:block xsl:use-attribute-sets="h2">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h2" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:h3">
    <fo:block xsl:use-attribute-sets="h3">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h3" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:h4">
    <fo:block xsl:use-attribute-sets="h4">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h4" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:h5">
    <fo:block xsl:use-attribute-sets="h5">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h5" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:h6">
    <fo:block xsl:use-attribute-sets="h6">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_h6" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:p">
    <fo:block xsl:use-attribute-sets="p">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_p" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <!-- initial paragraph, preceded by h1..6 or div -->
  <xsl:template match="html:p[preceding-sibling::*[1][
                       self::html:h1 or self::html:h2 or self::html:h3 or
                       self::html:h4 or self::html:h5 or self::html:h6 or
                       self::html:div]]">
    <fo:block xsl:use-attribute-sets="p-initial">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_p" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <!-- initial paragraph, first child of div, body or td -->
  <xsl:template match="html:p[not(preceding-sibling::*) and (
                       parent::html:div or parent::html:body or
                       parent::html:td)]">
    <fo:block xsl:use-attribute-sets="p-initial-first">
      <xsl:call-template name="process-style">
        <xsl:with-param name="style" select="$def_p" />
      </xsl:call-template>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:blockquote">
    <fo:block xsl:use-attribute-sets="blockquote">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:pre">
    <fo:block xsl:use-attribute-sets="pre">
      <xsl:call-template name="process-pre"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="process-pre">
    <xsl:call-template name="process-common-attributes"/>
    <!-- remove leading CR/LF/CRLF char -->
    <xsl:variable name="crlf"><xsl:text>&#xD;&#xA;</xsl:text></xsl:variable>
    <xsl:variable name="lf"><xsl:text>&#xA;</xsl:text></xsl:variable>
    <xsl:variable name="cr"><xsl:text>&#xD;</xsl:text></xsl:variable>
    <xsl:for-each select="node()">
      <xsl:choose>
        <xsl:when test="position() = 1 and self::text()">
          <xsl:choose>
            <xsl:when test="starts-with(., $lf)">
              <xsl:value-of select="substring(., 2)"/>
            </xsl:when>
            <xsl:when test="starts-with(., $crlf)">
              <xsl:value-of select="substring(., 3)"/>
            </xsl:when>
            <xsl:when test="starts-with(., $cr)">
              <xsl:value-of select="substring(., 2)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="html:address">
    <fo:block xsl:use-attribute-sets="address">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:hr">
    <fo:block xsl:use-attribute-sets="hr">
      <xsl:call-template name="process-common-attributes"/>
    </fo:block>
  </xsl:template>

  <!--
      This template has been changed so that it meets our needs. Before it was a
      normal match template.
      It will be called from within the htlm:div template further up.
  -->
  
  <xsl:template name="internal_div">
    <!-- need fo:block-container? or normal fo:block -->
    <xsl:variable name="need-block-container">
      <xsl:call-template name="need-block-container"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$need-block-container = 'true'">
        <fo:block-container>
          <xsl:if test="@dir">
            <xsl:attribute name="writing-mode">
              <xsl:choose>
                <xsl:when test="@dir = 'rtl'">rl-tb</xsl:when>
                <xsl:otherwise>lr-tb</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
          </xsl:if>
          <xsl:call-template name="process-common-attributes"/>
          <fo:block start-indent="0pt" end-indent="0pt">
            <xsl:apply-templates/>
          </fo:block>
        </fo:block-container>
      </xsl:when>
      <xsl:otherwise>
        <!-- normal block -->
        <fo:block role="Div">
          <xsl:call-template name="process-common-attributes"/>
          <xsl:apply-templates/>
        </fo:block>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="need-block-container">
    <xsl:choose>
      <xsl:when test="@dir">true</xsl:when>
      <xsl:when test="@style">
        <xsl:variable name="s"
                      select="concat(';', translate(normalize-space(@style),
                                                    ' ', ''))"/>
        <xsl:choose>
          <xsl:when test="contains($s, ';width:') or
                          contains($s, ';height:') or
                          contains($s, ';position:absolute') or
                          contains($s, ';position:fixed') or
                          contains($s, ';writing-mode:')">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="html:center">
    <fo:block text-align="center">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:fieldset | html:form | html:dir | html:menu">
    <fo:block space-before="1em" space-after="1em">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       List
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:ul">
    <fo:list-block xsl:use-attribute-sets="ul">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="html:li//html:ul">
    <fo:list-block xsl:use-attribute-sets="ul-nested">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="html:ol">
    <fo:list-block xsl:use-attribute-sets="ol">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="html:li//html:ol">
    <fo:list-block xsl:use-attribute-sets="ol-nested">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:list-block>
  </xsl:template>

  <xsl:template match="html:ul/html:li">
    <fo:list-item xsl:use-attribute-sets="ul-li">
      <xsl:call-template name="process-ul-li"/>
    </fo:list-item>
  </xsl:template>

  <xsl:template name="process-ul-li">
    <xsl:call-template name="process-common-attributes"/>
    <fo:list-item-label end-indent="label-end()"
                        text-align="end" wrap-option="no-wrap">
      <fo:block role="Div">
        <xsl:variable name="depth" select="count(ancestor::html:ul)" />
        <xsl:choose>
          <xsl:when test="$depth = 1">
            <fo:inline xsl:use-attribute-sets="ul-label-1">
              <xsl:value-of select="$ul-label-1"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="$depth = 2">
            <fo:inline xsl:use-attribute-sets="ul-label-2">
              <xsl:value-of select="$ul-label-2"/>
            </fo:inline>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline xsl:use-attribute-sets="ul-label-3">
              <xsl:value-of select="$ul-label-3"/>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <fo:block role="Div">
        <xsl:apply-templates/>
      </fo:block>
    </fo:list-item-body>
  </xsl:template>

  <xsl:template match="html:ol/html:li">
    <fo:list-item xsl:use-attribute-sets="ol-li">
      <xsl:call-template name="process-ol-li"/>
    </fo:list-item>
  </xsl:template>

  <xsl:template name="process-ol-li">
    <xsl:call-template name="process-common-attributes"/>
    <fo:list-item-label end-indent="label-end()"
                        text-align="end" wrap-option="no-wrap">
      <fo:block role="Div">
        <xsl:variable name="depth" select="count(ancestor::html:ol)" />
        <xsl:choose>
          <xsl:when test="$depth = 1">
            <fo:inline xsl:use-attribute-sets="ol-label-1">
              <xsl:number format="{$ol-label-1}"/>
            </fo:inline>
          </xsl:when>
          <xsl:when test="$depth = 2">
            <fo:inline xsl:use-attribute-sets="ol-label-2">
              <xsl:number format="{$ol-label-2}"/>
            </fo:inline>
          </xsl:when>
          <xsl:otherwise>
            <fo:inline xsl:use-attribute-sets="ol-label-3">
              <xsl:number format="{$ol-label-3}"/>
            </fo:inline>
          </xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <fo:block role="Div">
        <xsl:apply-templates/>
      </fo:block>
    </fo:list-item-body>
  </xsl:template>

  <xsl:template match="html:dl">
    <fo:block xsl:use-attribute-sets="dl">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:dt">
    <fo:block xsl:use-attribute-sets="dt">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:dd">
    <fo:block xsl:use-attribute-sets="dd">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Table
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:table">
    <xsl:call-template name="make-table-caption"/>
  </xsl:template>

  <xsl:template name="make-table-caption">
    <xsl:choose>
      <xsl:when test="html:caption/@align">
        <fo:block role="Div" xsl:use-attribute-sets="table-and-caption">
          <xsl:attribute name="caption-side">
            <xsl:value-of select="html:caption/@align"/>
          </xsl:attribute>
          <xsl:apply-templates select="html:caption"/>
          <fo:table xsl:use-attribute-sets="table">
            <xsl:call-template name="process-table"/>
          </fo:table>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <fo:table xsl:use-attribute-sets="table">
          <xsl:call-template name="process-table"/>
        </fo:table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="process-table">
    <!-- We add support for our custom classes -->
    <xsl:attribute name="writing-mode">
      <xsl:choose>
        <xsl:when test="@class">
          <xsl:choose>
            <xsl:when test="@class = 'table_order_left_to_right-top_down'">lr-tb</xsl:when>
            <xsl:when test="@class = 'table_order_right_to_left-top_down'">rl-tb</xsl:when>
            <xsl:when test="@class = 'table_order_top_down-right_to_left'">tb-rl</xsl:when>
            <xsl:otherwise>lr-tb</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>lr-tb</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:if test="@width">
            <xsl:attribute name="inline-progression-dimension">
              <xsl:choose>
                <xsl:when test="contains(@width, '%')">
                  <xsl:value-of select="@width"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@width"/>px
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@border or @frame">
      <xsl:choose>
        <xsl:when test="@border &gt; 0">
          <xsl:attribute name="border">
            <xsl:value-of select="@border"/>px</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@border = '0' or @frame = 'void'">
          <xsl:attribute name="border-style">hidden</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'above'">
          <xsl:attribute name="border-style">outset hidden hidden hidden</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'below'">
          <xsl:attribute name="border-style">hidden hidden outset hidden</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'hsides'">
          <xsl:attribute name="border-style">outset hidden</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'vsides'">
          <xsl:attribute name="border-style">hidden outset</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'lhs'">
          <xsl:attribute name="border-style">hidden hidden hidden outset</xsl:attribute>
        </xsl:when>
        <xsl:when test="@frame = 'rhs'">
          <xsl:attribute name="border-style">hidden outset hidden hidden</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="border-style">outset</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@cellspacing">
      <xsl:attribute name="border-spacing">
        <xsl:value-of select="@cellspacing"/>px</xsl:attribute>
      <xsl:attribute name="border-collapse">separate</xsl:attribute>
    </xsl:if>
    <xsl:if test="@rules and (@rules = 'groups' or
                      @rules = 'rows' or
                      @rules = 'cols' or
                      @rules = 'all' and (not(@border or @frame) or
                          @border = '0' or @frame and
                          not(@frame = 'box' or @frame = 'border')))">
      <xsl:attribute name="border-collapse">collapse</xsl:attribute>
      <xsl:if test="not(@border or @frame)">
        <xsl:attribute name="border-style">hidden</xsl:attribute>
      </xsl:if>
    </xsl:if>
    <xsl:call-template name="process-common-attributes"/>
    <xsl:apply-templates select="html:col | html:colgroup"/>
    <xsl:apply-templates select="html:thead"/>
    <xsl:apply-templates select="html:tfoot"/>
    <xsl:choose>
      <xsl:when test="html:tbody">
        <xsl:apply-templates select="html:tbody"/>
      </xsl:when>
      <xsl:otherwise>
        <fo:table-body xsl:use-attribute-sets="tbody">
          <xsl:apply-templates select="html:tr"/>
        </fo:table-body>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="html:caption">
    <fo:block xsl:use-attribute-sets="table-caption">
      <xsl:call-template name="process-common-attributes"/>
      <fo:block role="P">
        <xsl:apply-templates/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template match="html:thead">
    <fo:table-header xsl:use-attribute-sets="thead">
      <xsl:call-template name="process-table-rowgroup"/>
    </fo:table-header>
  </xsl:template>

  <xsl:template match="html:tfoot">
    <fo:table-footer xsl:use-attribute-sets="tfoot">
      <xsl:call-template name="process-table-rowgroup"/>
    </fo:table-footer>
  </xsl:template>

  <xsl:template match="html:tbody">
    <fo:table-body xsl:use-attribute-sets="tbody">
      <xsl:call-template name="process-table-rowgroup"/>
    </fo:table-body>
  </xsl:template>

  <xsl:template name="process-table-rowgroup">
    <xsl:if test="ancestor::html:table[1]/@rules = 'groups'">
      <xsl:attribute name="border">1px solid</xsl:attribute>
    </xsl:if>
    <xsl:call-template name="process-common-attributes-and-children"/>
  </xsl:template>

  <xsl:template match="html:colgroup">
    <fo:table-column role="Div" xsl:use-attribute-sets="table-column">
      <xsl:call-template name="process-table-column"/>
    </fo:table-column>
  </xsl:template>

  <xsl:template match="html:colgroup[html:col]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="html:col">
    <fo:table-column role="Div" xsl:use-attribute-sets="table-column">
      <xsl:call-template name="process-table-column"/>
    </fo:table-column>
  </xsl:template>

  <xsl:template name="process-table-column">
    <xsl:if test="parent::html:colgroup">
      <xsl:call-template name="process-col-width">
        <xsl:with-param name="width" select="../@width"/>
      </xsl:call-template>
      <xsl:call-template name="process-cell-align">
        <xsl:with-param name="align" select="../@align"/>
      </xsl:call-template>
      <xsl:call-template name="process-cell-valign">
        <xsl:with-param name="valign" select="../@valign"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="@span">
      <xsl:attribute name="number-columns-repeated">
        <xsl:value-of select="@span"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="process-col-width">
      <xsl:with-param name="width" select="@width"/>
      <!-- it may override parent colgroup's width -->
    </xsl:call-template>
    <xsl:if test="ancestor::html:table[1]/@rules = 'cols'">
      <!--
      <xsl:attribute name="border">1px solid</xsl:attribute>
      -->
    </xsl:if>
    <xsl:call-template name="process-common-attributes"/>
    <!-- this processes also align and valign -->
  </xsl:template>

  <xsl:template match="html:tr">
    <fo:table-row xsl:use-attribute-sets="tr" keep-together.within-page="always">
      <xsl:call-template name="process-table-row"/>
    </fo:table-row>
  </xsl:template>

  <xsl:template match="html:tr[parent::html:table and html:th and not(html:td)]">
    <fo:table-row xsl:use-attribute-sets="tr" keep-together.within-page="always">
      <xsl:call-template name="process-table-row"/>
    </fo:table-row>
  </xsl:template>

  <xsl:template name="process-table-row">
    <xsl:if test="ancestor::html:table[1]/@rules = 'rows'">
      <xsl:attribute name="border">1px solid</xsl:attribute>
    </xsl:if>
    <xsl:call-template name="process-common-attributes-and-children"/>
  </xsl:template>

  <xsl:template match="html:th">
    <fo:table-cell xsl:use-attribute-sets="th">
      <xsl:call-template name="process-table-cell"/>
    </fo:table-cell>
  </xsl:template>

  <xsl:template match="html:td">
    <fo:table-cell xsl:use-attribute-sets="td">
      <xsl:call-template name="process-table-cell"/>
    </fo:table-cell>
  </xsl:template>

  <xsl:template name="process-table-cell">
    <xsl:if test="@colspan">
      <xsl:attribute name="number-columns-spanned">
        <xsl:value-of select="@colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@rowspan">
      <xsl:attribute name="number-rows-spanned">
        <xsl:value-of select="@rowspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:for-each select="ancestor::html:table[1]">
      <xsl:if test="(@border or @rules) and (@rules = 'all' or
                    not(@rules) and not(@border = '0'))">
        <xsl:attribute name="border-style">inset</xsl:attribute>
      </xsl:if>
      <xsl:if test="@cellpadding">
        <xsl:attribute name="padding">
          <xsl:choose>
            <xsl:when test="contains(@cellpadding, '%')">
              <xsl:value-of select="@cellpadding"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@cellpadding"/>px</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="not(@align or ../@align or
                      ../parent::*[self::html:thead or self::html:tfoot or
                      self::html:tbody]/@align) and
                  ancestor::html:table[1]/*[self::html:col or
                      self::html:colgroup]/descendant-or-self::*/@align">
      <xsl:attribute name="text-align">from-table-column()</xsl:attribute>
    </xsl:if>
    <xsl:if test="not(@valign or ../@valign or
                      ../parent::*[self::html:thead or self::html:tfoot or
                      self::html:tbody]/@valign) and
                  ancestor::html:table[1]/*[self::html:col or
                      self::html:colgroup]/descendant-or-self::*/@valign">
      <xsl:attribute name="display-align">from-table-column()</xsl:attribute>
      <xsl:attribute name="relative-align">from-table-column()</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    <xsl:call-template name="process-common-attributes"/>
    <fo:block role="Div">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template name="process-col-width">
    <xsl:param name="width"/>
    <xsl:if test="$width and $width != '0*'">
      <xsl:attribute name="column-width">
        <xsl:choose>
          <xsl:when test="contains($width, '*')">
            <xsl:text>proportional-column-width(</xsl:text>
            <xsl:value-of select="substring-before($width, '*')"/>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:when test="contains($width, '%')">
            <xsl:value-of select="$width"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$width"/>px</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="process-cell-align">
    <xsl:param name="align"/>
    <xsl:if test="$align">
      <xsl:attribute name="text-align">
        <xsl:choose>
          <xsl:when test="$align = 'char'">
            <xsl:choose>
              <xsl:when test="$align/../@char">
                <xsl:value-of select="$align/../@char"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="'.'"/>
                <!-- todo: it should depend on xml:lang ... -->
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$align"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="process-cell-valign">
    <xsl:param name="valign"/>
    <xsl:if test="$valign">
      <xsl:attribute name="display-align">
        <xsl:choose>
          <xsl:when test="$valign = 'middle'">center</xsl:when>
          <xsl:when test="$valign = 'bottom'">after</xsl:when>
          <xsl:when test="$valign = 'baseline'">auto</xsl:when>
          <xsl:otherwise>before</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:if test="$valign = 'baseline'">
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Inline-level
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:b">
    <fo:inline xsl:use-attribute-sets="b">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:strong">
    <fo:inline xsl:use-attribute-sets="strong">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:strong//html:em | html:em//html:strong">
    <fo:inline xsl:use-attribute-sets="strong-em">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:i">
    <fo:inline xsl:use-attribute-sets="i">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:cite">
    <fo:inline xsl:use-attribute-sets="cite">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:em">
    <fo:inline xsl:use-attribute-sets="em">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:var">
    <fo:inline xsl:use-attribute-sets="var">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:dfn">
    <fo:inline xsl:use-attribute-sets="dfn">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:tt">
    <fo:inline xsl:use-attribute-sets="tt">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:code">
    <fo:inline xsl:use-attribute-sets="code">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:kbd">
    <fo:inline xsl:use-attribute-sets="kbd">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:samp">
    <fo:inline xsl:use-attribute-sets="samp">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:big">
    <fo:inline xsl:use-attribute-sets="big">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:small">
    <fo:inline xsl:use-attribute-sets="small">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:sub">
    <fo:inline xsl:use-attribute-sets="sub">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:sup">
    <fo:inline xsl:use-attribute-sets="sup">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:s">
    <fo:inline xsl:use-attribute-sets="s">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:strike">
    <fo:inline xsl:use-attribute-sets="strike">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:del">
    <fo:inline xsl:use-attribute-sets="del">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:u">
    <fo:inline xsl:use-attribute-sets="u">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:ins">
    <fo:inline xsl:use-attribute-sets="ins">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:abbr">
    <fo:inline xsl:use-attribute-sets="abbr">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:acronym">
    <fo:inline xsl:use-attribute-sets="acronym">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:span">
    <fo:inline>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:span[@dir]">
    <fo:bidi-override direction="{@dir}" unicode-bidi="embed">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:bidi-override>
  </xsl:template>

  <xsl:template match="html:span[@style and contains(@style, 'writing-mode')]">
    <fo:inline-container alignment-baseline="central"
                         text-indent="0pt"
                         last-line-end-indent="0pt"
                         start-indent="0pt"
                         end-indent="0pt"
                         text-align="center"
                         text-align-last="center">
      <xsl:call-template name="process-common-attributes"/>
      <fo:block wrap-option="no-wrap" line-height="1">
        <xsl:apply-templates/>
      </fo:block>
    </fo:inline-container>
  </xsl:template>

  <xsl:template match="html:bdo">
    <fo:bidi-override direction="{@dir}" unicode-bidi="bidi-override">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:bidi-override>
  </xsl:template>

  <xsl:template match="html:br">
    <fo:block role="P">
      &#x2028;
    </fo:block>
  </xsl:template>

  <xsl:template match="html:q">
    <fo:inline xsl:use-attribute-sets="q">
      <xsl:call-template name="process-common-attributes"/>
      <xsl:choose>
        <xsl:when test="lang('ja')">
          <xsl:text>「</xsl:text>
          <xsl:apply-templates/>
          <xsl:text>」</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <!-- lang('en') -->
          <xsl:text>“</xsl:text>
          <xsl:apply-templates/>
          <xsl:text>”</xsl:text>
          <!-- todo: other languages ...-->
        </xsl:otherwise>
      </xsl:choose>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:q//html:q">
    <fo:inline xsl:use-attribute-sets="q-nested">
      <xsl:call-template name="process-common-attributes"/>
      <xsl:choose>
        <xsl:when test="lang('ja')">
          <xsl:text>『</xsl:text>
          <xsl:apply-templates/>
          <xsl:text>』</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <!-- lang('en') -->
          <xsl:text>‘</xsl:text>
          <xsl:apply-templates/>
          <xsl:text>’</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </fo:inline>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Image
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:img">
    <fo:external-graphic xsl:use-attribute-sets="img">
      <xsl:call-template name="process-img"/>
    </fo:external-graphic>
  </xsl:template>

  <xsl:template match="html:img[ancestor::html:a/@href]">
    <fo:external-graphic xsl:use-attribute-sets="img-link">
      <xsl:call-template name="process-img"/>
    </fo:external-graphic>
  </xsl:template>

  <xsl:template name="process-img">
    <xsl:attribute name="src">
      <xsl:text>url('</xsl:text>
      <xsl:value-of select="@src"/>
      <xsl:text>')</xsl:text>
    </xsl:attribute>
    <xsl:if test="@alt">
      <!-- alt attribute is changed to fox:alt-text according to FOP-documentation. -->
      <xsl:attribute name="fox:alt-text">
        <xsl:value-of select="@alt"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@width">
      <xsl:choose>
        <xsl:when test="contains(@width, '%')">
          <xsl:attribute name="width">
            <xsl:value-of select="@width"/>
          </xsl:attribute>
          <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="content-width">
            <xsl:value-of select="@width"/>px</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@height">
      <xsl:choose>
        <xsl:when test="contains(@height, '%')">
          <xsl:attribute name="height">
            <xsl:value-of select="@height"/>
          </xsl:attribute>
          <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="content-height">
            <xsl:value-of select="@height"/>px</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="@border">
      <xsl:attribute name="border">
        <xsl:value-of select="@border"/>px solid</xsl:attribute>
    </xsl:if>
    <xsl:call-template name="process-common-attributes"/>
  </xsl:template>

  <xsl:template match="html:object">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="html:param"/>
  <xsl:template match="html:map"/>
  <xsl:template match="html:area"/>
  <xsl:template match="html:label"/>
  <xsl:template match="html:input"/>
  <xsl:template match="html:select"/>
  <xsl:template match="html:optgroup"/>
  <xsl:template match="html:option"/>
  <xsl:template match="html:textarea"/>
  <xsl:template match="html:legend"/>
  <xsl:template match="html:button"/>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Link
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:a">
    <fo:inline>
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="html:a[@href]">
    <fo:basic-link xsl:use-attribute-sets="a-link">
      <xsl:call-template name="process-a-link"/>
    </fo:basic-link>
  </xsl:template>

  <xsl:template name="process-a-link">
    <xsl:call-template name="process-common-attributes"/>
    <xsl:choose>
      <xsl:when test="starts-with(@href,'#')">
        <xsl:attribute name="internal-destination">
          <xsl:value-of select="substring-after(@href,'#')"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="external-destination">
          <xsl:text>url('</xsl:text>
          <xsl:value-of select="@href"/>
          <xsl:text>')</xsl:text>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@title">
      <xsl:attribute name="role">
        <xsl:value-of select="@title"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <!--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       Ruby
  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-->

  <xsl:template match="html:ruby">
    <fo:inline-container alignment-baseline="central"
                         block-progression-dimension="1em"
                         text-indent="0pt"
                         last-line-end-indent="0pt"
                         start-indent="0pt"
                         end-indent="0pt"
                         text-align="center"
                         text-align-last="center">
      <xsl:call-template name="process-common-attributes"/>
      <fo:block font-size="50%"
                wrap-option="no-wrap"
                line-height="1"
                space-before.conditionality="retain"
                space-before="-1.1em"
                space-after="0.1em"
                role="html:rt">
        <xsl:for-each select="html:rt | html:rtc[1]/html:rt">
          <xsl:call-template name="process-common-attributes"/>
          <xsl:apply-templates/>
        </xsl:for-each>
      </fo:block>
      <fo:block wrap-option="no-wrap" line-height="1" role="html:rb">
        <xsl:for-each select="html:rb | html:rbc[1]/html:rb">
          <xsl:call-template name="process-common-attributes"/>
          <xsl:apply-templates/>
        </xsl:for-each>
      </fo:block>
      <xsl:if test="html:rtc[2]/html:rt">
        <fo:block font-size="50%"
                  wrap-option="no-wrap"
                  line-height="1"
                  space-before="0.1em"
                  space-after.conditionality="retain"
                  space-after="-1.1em"
                  role="html:rt">
          <xsl:for-each select="html:rt | html:rtc[2]/html:rt">
            <xsl:call-template name="process-common-attributes"/>
            <xsl:apply-templates/>
          </xsl:for-each>
        </fo:block>
      </xsl:if>
    </fo:inline-container>
  </xsl:template>
</xsl:stylesheet>
