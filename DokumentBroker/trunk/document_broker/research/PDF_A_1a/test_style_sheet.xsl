<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xml.apache.org/fop/extensions">
  <!--
    This style sheet is based on documents found on this web site:
    http://www.ibm.com/developerworks/library/x-xslfo2app/
    as stated below:
  -->
  <!-- ============================================
    This stylesheet transforms most of the common
    HTML elements into XSL formatting objects.  

    This version written 1 November 2002 by
    Doug Tidwell, dtidwell@us.ibm.com.

    Brought to you by your friends at developerWorks:
    ibm.com/developerWorks.
    =============================================== -->

  <!-- ============================================
    This variable sets the size of the page.  If 
    it's 'ltr', we an 8.5 x 11 inch page; otherwise,
    we use an A4-sized page.  'ltr' is the default.
    To change the value, you can make the following
    line read select="'A4'", or you can check the
    documentation for your XSLT processor to see 
    how to set variables externally to the style
    sheet.  (For Xalan, add "-PARAM page-size a4"
    to the command.)
    =============================================== -->

  <xsl:variable name="page-size" select="'a4'"/>

  <xsl:template match="html">

  <!-- ============================================
    Because character entities aren't built into 
    the XSL-FO vocabulary, they're included here.  
    =============================================== -->

    <xsl:text disable-output-escaping="yes">
&lt;!DOCTYPE fo:root [
  &lt;!ENTITY tilde  "&amp;#126;"&gt;
  &lt;!ENTITY florin "&amp;#131;"&gt;
  &lt;!ENTITY elip   "&amp;#133;"&gt;
  &lt;!ENTITY dag    "&amp;#134;"&gt;
  &lt;!ENTITY ddag   "&amp;#135;"&gt;
  &lt;!ENTITY cflex  "&amp;#136;"&gt;
  &lt;!ENTITY permil "&amp;#137;"&gt;
  &lt;!ENTITY uscore "&amp;#138;"&gt;
  &lt;!ENTITY OElig  "&amp;#140;"&gt;
  &lt;!ENTITY lsquo  "&amp;#145;"&gt;
  &lt;!ENTITY rsquo  "&amp;#146;"&gt;
  &lt;!ENTITY ldquo  "&amp;#147;"&gt;
  &lt;!ENTITY rdquo  "&amp;#148;"&gt;
  &lt;!ENTITY bullet "&amp;#149;"&gt;
  &lt;!ENTITY endash "&amp;#150;"&gt;
  &lt;!ENTITY emdash "&amp;#151;"&gt;
  &lt;!ENTITY trade  "&amp;#153;"&gt;
  &lt;!ENTITY oelig  "&amp;#156;"&gt;
  &lt;!ENTITY Yuml   "&amp;#159;"&gt;

  &lt;!ENTITY nbsp   "&amp;#160;"&gt;
  &lt;!ENTITY iexcl  "&amp;#161;"&gt;
  &lt;!ENTITY cent   "&amp;#162;"&gt;
  &lt;!ENTITY pound  "&amp;#163;"&gt;
  &lt;!ENTITY curren "&amp;#164;"&gt;
  &lt;!ENTITY yen    "&amp;#165;"&gt;
  &lt;!ENTITY brvbar "&amp;#166;"&gt;
  &lt;!ENTITY sect   "&amp;#167;"&gt;
  &lt;!ENTITY uml    "&amp;#168;"&gt;
  &lt;!ENTITY copy   "&amp;#169;"&gt;
  &lt;!ENTITY ordf   "&amp;#170;"&gt;
  &lt;!ENTITY laquo  "&amp;#171;"&gt;
  &lt;!ENTITY not    "&amp;#172;"&gt;
  &lt;!ENTITY shy    "&amp;#173;"&gt;
  &lt;!ENTITY reg    "&amp;#174;"&gt;
  &lt;!ENTITY macr   "&amp;#175;"&gt;
  &lt;!ENTITY deg    "&amp;#176;"&gt;
  &lt;!ENTITY plusmn "&amp;#177;"&gt;
  &lt;!ENTITY sup2   "&amp;#178;"&gt;
  &lt;!ENTITY sup3   "&amp;#179;"&gt;
  &lt;!ENTITY acute  "&amp;#180;"&gt;
  &lt;!ENTITY micro  "&amp;#181;"&gt;
  &lt;!ENTITY para   "&amp;#182;"&gt;
  &lt;!ENTITY middot "&amp;#183;"&gt;
  &lt;!ENTITY cedil  "&amp;#184;"&gt;
  &lt;!ENTITY sup1   "&amp;#185;"&gt;
  &lt;!ENTITY ordm   "&amp;#186;"&gt;
  &lt;!ENTITY raquo  "&amp;#187;"&gt;
  &lt;!ENTITY frac14 "&amp;#188;"&gt;
  &lt;!ENTITY frac12 "&amp;#189;"&gt;
  &lt;!ENTITY frac34 "&amp;#190;"&gt;
  &lt;!ENTITY iquest "&amp;#191;"&gt;
  &lt;!ENTITY Agrave "&amp;#192;"&gt;
  &lt;!ENTITY Aacute "&amp;#193;"&gt;
  &lt;!ENTITY Acirc  "&amp;#194;"&gt;
  &lt;!ENTITY Atilde "&amp;#195;"&gt;
  &lt;!ENTITY Auml   "&amp;#196;"&gt;
  &lt;!ENTITY Aring  "&amp;#197;"&gt;
  &lt;!ENTITY AElig  "&amp;#198;"&gt;
  &lt;!ENTITY Ccedil "&amp;#199;"&gt;
  &lt;!ENTITY Egrave "&amp;#200;"&gt;
  &lt;!ENTITY Eacute "&amp;#201;"&gt;
  &lt;!ENTITY Ecirc  "&amp;#202;"&gt;
  &lt;!ENTITY Euml   "&amp;#203;"&gt;
  &lt;!ENTITY Igrave "&amp;#204;"&gt;
  &lt;!ENTITY Iacute "&amp;#205;"&gt;
  &lt;!ENTITY Icirc  "&amp;#206;"&gt;
  &lt;!ENTITY Iuml   "&amp;#207;"&gt;
  &lt;!ENTITY ETH    "&amp;#208;"&gt;
  &lt;!ENTITY Ntilde "&amp;#209;"&gt;
  &lt;!ENTITY Ograve "&amp;#210;"&gt;
  &lt;!ENTITY Oacute "&amp;#211;"&gt;
  &lt;!ENTITY Ocirc  "&amp;#212;"&gt;
  &lt;!ENTITY Otilde "&amp;#213;"&gt;
  &lt;!ENTITY Ouml   "&amp;#214;"&gt;
  &lt;!ENTITY times  "&amp;#215;"&gt;
  &lt;!ENTITY Oslash "&amp;#216;"&gt;
  &lt;!ENTITY Ugrave "&amp;#217;"&gt;
  &lt;!ENTITY Uacute "&amp;#218;"&gt;
  &lt;!ENTITY Ucirc  "&amp;#219;"&gt;
  &lt;!ENTITY Uuml   "&amp;#220;"&gt;
  &lt;!ENTITY Yacute "&amp;#221;"&gt;
  &lt;!ENTITY THORN  "&amp;#222;"&gt;
  &lt;!ENTITY szlig  "&amp;#223;"&gt;
  &lt;!ENTITY agrave "&amp;#224;"&gt;
  &lt;!ENTITY aacute "&amp;#225;"&gt;
  &lt;!ENTITY acirc  "&amp;#226;"&gt;
  &lt;!ENTITY atilde "&amp;#227;"&gt;
  &lt;!ENTITY auml   "&amp;#228;"&gt;
  &lt;!ENTITY aring  "&amp;#229;"&gt;
  &lt;!ENTITY aelig  "&amp;#230;"&gt;
  &lt;!ENTITY ccedil "&amp;#231;"&gt;
  &lt;!ENTITY egrave "&amp;#232;"&gt;
  &lt;!ENTITY eacute "&amp;#233;"&gt;
  &lt;!ENTITY ecirc  "&amp;#234;"&gt;
  &lt;!ENTITY euml   "&amp;#235;"&gt;
  &lt;!ENTITY igrave "&amp;#236;"&gt;
  &lt;!ENTITY iacute "&amp;#237;"&gt;
  &lt;!ENTITY icirc  "&amp;#238;"&gt;
  &lt;!ENTITY iuml   "&amp;#239;"&gt;
  &lt;!ENTITY eth    "&amp;#240;"&gt;
  &lt;!ENTITY ntilde "&amp;#241;"&gt;
  &lt;!ENTITY ograve "&amp;#242;"&gt;
  &lt;!ENTITY oacute "&amp;#243;"&gt;
  &lt;!ENTITY ocirc  "&amp;#244;"&gt;
  &lt;!ENTITY otilde "&amp;#245;"&gt;
  &lt;!ENTITY ouml   "&amp;#246;"&gt;
  &lt;!ENTITY oslash "&amp;#248;"&gt;
  &lt;!ENTITY ugrave "&amp;#249;"&gt;
  &lt;!ENTITY uacute "&amp;#250;"&gt;
  &lt;!ENTITY ucirc  "&amp;#251;"&gt;
  &lt;!ENTITY uuml   "&amp;#252;"&gt;
  &lt;!ENTITY yacute "&amp;#253;"&gt;
  &lt;!ENTITY thorn  "&amp;#254;"&gt;
  &lt;!ENTITY yuml   "&amp;#255;"&gt;
]&gt;
    </xsl:text>

  <!-- ============================================
    The XSL-FO section starts here....
    =============================================== -->

    <fo:root font-family="Free Serif" xmlns:fo="http://www.w3.org/1999/XSL/Format"
      xmlns:fox="http://xml.apache.org/fop/extensions">

<!-- ============================================
    Define the page layouts.  There are two sets of
    three page mastters here; we use one set for 
    letter-sized paper, the other set for A4.
    =============================================== -->

      <fo:layout-master-set>
        <xsl:choose>
          <xsl:when test="$page-size='ltr'">
            <fo:simple-page-master master-name="first"
              page-height="11in" page-width="8.5in"
              margin-right="72pt" margin-left="72pt"
              margin-bottom="36pt" margin-top="72pt">
	      <fo:region-body margin-bottom="50pt"/>
              <fo:region-after region-name="ra-right" 
                extent="25pt"/>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="left"
              page-height="11in" page-width="8.5in"
              margin-right="72pt" margin-left="72pt" 
              margin-bottom="36pt" margin-top="36pt">
              <fo:region-body margin-top="50pt" 
                margin-bottom="50pt"/>
              <fo:region-before region-name="rb-left" 
                extent="25pt"/>
              <fo:region-after region-name="ra-left" 
                extent="25pt"/>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="right"
              page-height="11in" page-width="8.5in"
              margin-right="72pt" margin-left="72pt" 
              margin-bottom="36pt" margin-top="36pt">
              <fo:region-body margin-top="50pt" 
                margin-bottom="50pt"/>
              <fo:region-before region-name="rb-right" 
                extent="25pt"/>
              <fo:region-after region-name="ra-right" 
                extent="25pt"/>
            </fo:simple-page-master>
          </xsl:when>

  <!-- ============================================
    Page layouts for A4-sized paper
    =============================================== -->

          <xsl:otherwise>
            <fo:simple-page-master master-name="first"
              page-height="29.7cm" page-width="21cm"
              margin-right="72pt" margin-left="72pt"
              margin-bottom="36pt" margin-top="72pt">
              <fo:region-body margin-top="1.5cm" 
                margin-bottom="1.5cm"/>
              <fo:region-after region-name="ra-right" 
                extent="1cm"/>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="left"
              page-height="29.7cm" page-width="21cm"
              margin-right="72pt" margin-left="72pt" 
              margin-bottom="36pt" margin-top="36pt">
              <fo:region-body margin-top="1.5cm" 
                margin-bottom="1.5cm"/>
              <fo:region-before region-name="rb-left" 
                extent="3cm"/>
              <fo:region-after region-name="ra-left" 
                extent="1cm"/>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="right"
              page-height="29.7cm" page-width="21cm"
              margin-right="72pt" margin-left="72pt" 
              margin-bottom="36pt" margin-top="36pt">
              <fo:region-body margin-top="1.5cm" 
                margin-bottom="1.5cm"/>
              <fo:region-before region-name="rb-right" 
                extent="3cm"/>
              <fo:region-after region-name="ra-right" 
                extent="1cm"/>
            </fo:simple-page-master>
          </xsl:otherwise>
        </xsl:choose>
        
  <!-- ============================================
    Now we define how we use the page layouts.  One
    is for the first page, one is for the even-
    numbered pages, and one is for odd-numbered pages.
    =============================================== -->

        <fo:page-sequence-master master-name="standard">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference 
              master-reference="first" 
              page-position="first"/>
            <fo:conditional-page-master-reference 
              master-reference="left" 
              odd-or-even="even"/>
            <fo:conditional-page-master-reference 
              master-reference="right" 
              odd-or-even="odd"/>
          </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
        
      </fo:layout-master-set>

  <!-- ============================================
    This is where the actual content of the document
    starts. 
    =============================================== -->

      <fo:page-sequence master-reference="standard">

  <!-- ============================================
    We define the static content for the headers 
    and footers of the various page layouts first. 
    =============================================== -->

        <fo:static-content flow-name="rb-right">
          <fo:block font-size="10pt" text-align-last="end">
            <fo:table table-layout="fixed">
              <fo:table-column column-width="396pt"/>
              <fo:table-column column-width="72pt"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block text-align="start">
                      developerWorks loves you!
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="end" font-weight="bold">
                      ibm.com/developerWorks
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="ra-right">
          <fo:block font-size="10pt" text-align-last="end">
            <fo:table table-layout="fixed">
              <fo:table-column column-width="396pt"/>
              <fo:table-column column-width="72pt"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block text-align="start">
                      <xsl:value-of select="/html/head/title"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="end">Page 
                      <fo:page-number/> of 
                      <fo:page-number-citation 
                        ref-id="TheVeryLastPage"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="rb-left">
          <fo:block font-size="10pt" text-align-last="end">
            <fo:table table-layout="fixed">
              <fo:table-column column-width="72pt"/>
              <fo:table-column column-width="396pt"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block text-align="start" font-weight="bold">
                      ibm.com/developerWorks
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="end">
                      developerWorks loves you!
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="ra-left">
          <fo:block font-size="10pt" text-align-last="end">
            <fo:table table-layout="fixed">
              <fo:table-column column-width="72pt"/>
              <fo:table-column column-width="396pt"/>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell>
                    <fo:block text-align="start">Page 
                      <fo:page-number/> 
                      of <fo:page-number-citation 
                      ref-id="TheVeryLastPage"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell>
                    <fo:block text-align="end">
                      <xsl:value-of select="/html/head/title"/> 
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table> 
          </fo:block>
        </fo:static-content>

          <xsl:apply-templates select="body"/>
      </fo:page-sequence>

      <!--
      Testing to see if date and language can be implemented in this way in order to achieve compliance
    -->

      <fo:declarations>
	<meta name="DC.date" content="2012-08-03" />
	<meta name="DC.language" content="en" />
      </fo:declarations>

    </fo:root>
  </xsl:template>

  <!-- ============================================
    The HTML <body> element contains everything in
    the main part of the document.  This is analogous
    to the <fo:flow flow-name="xsl-region-body">
    element, so we put the main document processing here.  
    =============================================== -->

  <xsl:template match="body">

  <!-- ============================================
    Start generating the content for the main page 
    area (xsl-region-body).
    =============================================== -->
        
    <fo:flow flow-name="xsl-region-body">
      <xsl:apply-templates select="/html/head/title"/>
      <fo:block space-after="12pt" line-height="17pt" 
        font-size="14pt" text-align="center">
        developerWorks loves you!
      </fo:block>
      <fo:block space-after="24pt" line-height="17pt" 
        font-size="14pt" text-align="center" font-weight="bold">
        ibm.com/developerWorks
      </fo:block>
          
  <!-- ============================================
    This one line of code processes everything in 
    the body of the document.  The template that
    processes the <body> element in turn processes
    everything that's inside it.
    =============================================== -->

      <xsl:apply-templates select="*|text()"/>

  <!-- ============================================
    We put an ID at the end of the document so we 
    can do "Page x of y" numbering.
    =============================================== -->
      <fo:block id="TheVeryLastPage" font-size="0pt"
        line-height="0pt" space-after="0pt"/>

    </fo:flow>
  </xsl:template>

  <!-- ============================================
    The title of the document is rendered in a large
    bold font, centered on the page.  This is the 
    <title> element in the <head> in <html>.
    =============================================== -->

  <xsl:template match="title">
    <fo:block space-after="18pt" line-height="27pt" 
      font-size="24pt" font-weight="bold" text-align="center">
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    For the <font> element, we handle the color, 
    face, and size attributes.  Color will work if
    it's one of the twelve colors supported by XSL-FO
    or it's a hex value like x0033ff.  (In other words,
    if you tell FOP to set the color to PapayaWhip, 
    you're out of luck.)  The face attribute will 
    work if FOP supports it.  (There are ways to add 
    fonts to FOP, see the FOP documentation for more 
    info.)  Size is supported for values like 
    size="14pt", size="3", and size="+3".
    =============================================== -->

  <xsl:template match="font">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="@color">
          <xsl:value-of select="@color"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>black</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="face">
      <xsl:choose>
        <xsl:when test="@face">
          <xsl:value-of select="@face"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Free Serif</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="size">
      <xsl:choose>
        <xsl:when test="@size">
          <xsl:choose>
            <xsl:when test="contains(@size, 'pt')">
              <xsl:text>@size</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+1'">
              <xsl:text>110%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+2'">
              <xsl:text>120%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+3'">
              <xsl:text>130%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+4'">
              <xsl:text>140%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+5'">
              <xsl:text>150%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+6'">
              <xsl:text>175%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '+7'">
              <xsl:text>200%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-1'">
              <xsl:text>90%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-2'">
              <xsl:text>80%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-3'">
              <xsl:text>70%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-4'">
              <xsl:text>60%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-5'">
              <xsl:text>50%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-6'">
              <xsl:text>40%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '-7'">
              <xsl:text>30%</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '1'">
              <xsl:text>8pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '2'">
              <xsl:text>10pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '3'">
              <xsl:text>12pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '4'">
              <xsl:text>14pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '5'">
              <xsl:text>18pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '6'">
              <xsl:text>24pt</xsl:text>
            </xsl:when>
            <xsl:when test="@size = '7'">
              <xsl:text>36pt</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>12pt</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise> 
          <xsl:text>12pt</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <fo:inline font-size="{$size}" 
      color="{$color}">
      <xsl:apply-templates select="*|text()"/>
    </fo:inline>
  </xsl:template>

  <!-- ============================================
    Processing for the anchor tag is complex.  First
    of all, if this is a named anchor, we write an empty
    <fo:block> with the appropriate id.  (In the special
    case that the next element is an <h1>, we ignore
    the element altogether and put the id on the <h1>.)
    Next, if this is a regular anchor and the href
    starts with a hash mark (#), we create a link with
    an internal-destination.  Otherwise, we create a
    link with an external destination. 
    =============================================== -->

  <xsl:template match="a">
    <xsl:choose>
      <xsl:when test="@name">
        <xsl:if test="not(name(following-sibling::*[1]) = 'h1')">
          <fo:block line-height="0pt" space-after="0pt" 
            font-size="0pt" id="{@name}"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="@href">
        <fo:basic-link color="blue">
          <xsl:choose>
            <xsl:when test="starts-with(@href, '#')">
              <xsl:attribute name="internal-destination">
                <xsl:value-of select="substring(@href, 2)"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="external-destination">
                <xsl:value-of select="@href"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:apply-templates select="*|text()"/>
        </fo:basic-link>
        <xsl:if test="starts-with(@href, '#')">
          <xsl:text> on page </xsl:text>
          <fo:page-number-citation ref-id="{substring(@href, 2)}"/>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ============================================
    <h2> is in a slightly smaller font than an <h1>,
    and it doesn't have a page break or a line.
    =============================================== -->

  <xsl:template match="h2">
    <fo:block font-size="24pt" line-height="28pt"
      keep-with-next="always" space-after="18pt">
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    <h3> is slightly smaller than <h2>.
    =============================================== -->

  <xsl:template match="h3">
    <fo:block font-size="21pt" line-height="24pt"
      keep-with-next="always" space-after="14pt">
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    <h4> is smaller than <h3>.  For the bookmarks
    and table of contents, <h4> is the lowest level
    we include.
    =============================================== -->

  <xsl:template match="h4">
    <fo:block font-size="18pt" line-height="21pt"
      keep-with-next="always" space-after="12pt">
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    <h5> is pretty small, and is underlined to 
    help it stand out. 
    =============================================== -->

  <xsl:template match="h5">
    <fo:block font-size="16pt" line-height="19pt"
      keep-with-next="always" space-after="12pt" text-decoration="underline">
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    <h6> is the smallest heading of all, and is
    underlined and italicized.  
    =============================================== -->

  <xsl:template match="h6">
    <fo:block font-size="14pt" line-height="17pt"
      keep-with-next="always" space-after="12pt" font-style="italic"
      text-decoration="underline">
      <xsl:attribute name="id">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="generate-id()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <!-- ============================================
    Your basic paragraph.
    =============================================== -->

  <xsl:template match="p">
    <fo:block font-size="12pt" line-height="15pt"
      space-after="12pt">
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>