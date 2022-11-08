<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times">

  <xsl:import href="filtering-attribute-resolver.xsl"/>

  <xsl:param name="OUTPUT-DIR"/>

  <xsl:variable name="OUTPUT-DIR-VAR">
    <xsl:choose>
      <xsl:when test="contains($OUTPUT-DIR, 'c:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'c:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($OUTPUT-DIR, 'C:')">
        <xsl:value-of select="translate(substring-after($OUTPUT-DIR, 'C:'), '\', '/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($OUTPUT-DIR, '\', '/')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:param name="FILENAME"/>

  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="map.dtd"/>

  <xsl:template match="/">
 
    <xsl:result-document href="{concat($OUTPUT-DIR-VAR, $FILENAME)}">
      <xsl:element name="map">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="iso_data/*"/>


  <xsl:template match="iso_data/title">
    <xsl:element name="title">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="section">
    <xsl:element name="topicref">
      <xsl:attribute name="navtitle">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:if test="@visible = 'false' or child::subsection[1][contains(name,'Block Information')]/@visible = 'false'">
        <xsl:attribute name="ishcondition">audience=Internal</xsl:attribute>
      </xsl:if>     
      <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="@id_tag"><xsl:value-of select="concat(@id_tag, '.xml')"/></xsl:when>
          <xsl:otherwise>
            <xsl:variable name="xml-filename">
              <xsl:call-template name="create-id"></xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="concat($xml-filename, '.xml')"/>
          </xsl:otherwise>
        </xsl:choose>        
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>  

  </xsl:template>

  <xsl:template match="subsection">
    <xsl:choose>
      <xsl:when test="not(@name = 'Block Information')">
        <xsl:choose>
          <xsl:when test="child::field"><!-- Not all subsections have fields; some just have information blocks -->
            <xsl:element name="topicref">
              <xsl:attribute name="navtitle">
                <xsl:value-of select="@name"/>
              </xsl:attribute>
              <xsl:if test="@visible = 'false'">
                <xsl:attribute name="ishcondition">audience=Internal</xsl:attribute>
              </xsl:if>
              <xsl:attribute name="href">
                <xsl:choose>
                  <xsl:when test="@id_tag"><xsl:value-of select="concat(@id_tag, '.xml')"/></xsl:when>
                  <xsl:otherwise>
                    <xsl:variable name="xml-filename">
                      <xsl:call-template name="create-id"></xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="concat($xml-filename, '.xml')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>        
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="topichead">
              <xsl:variable name="filename">
                <xsl:choose>
                  <xsl:when test="@id_tag">
                    <xsl:value-of select="@id_tag"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="create-id"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <xsl:attribute name="navtitle">
                <xsl:value-of select="@name"/>
              </xsl:attribute>
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>    
  </xsl:template>

  <xsl:template match="content">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="options | tag_list"/>

  <xsl:template name="create-id">
    <xsl:variable name="temp" select="translate(normalize-space(@name), ' /()[]', '_')"/>
    <xsl:value-of select="concat($temp, '_', generate-id())"/>
  </xsl:template>

</xsl:stylesheet>
