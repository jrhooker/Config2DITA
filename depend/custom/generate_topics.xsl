<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <xsl:import href="filtering-attribute-resolver.xsl"/>

  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Mathml Topic//EN" doctype-system="AtmelTopic.dtd"/>

  <xsl:template match="/">

    <xsl:apply-templates/>

  </xsl:template>

  <xsl:template match="section">  
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
        
        <xsl:result-document href="{$filename}.xml">
          <xsl:element name="topic">
            <xsl:attribute name="id">
              <xsl:value-of select="$filename"/>
            </xsl:attribute>
            <xsl:if test="@visible = 'false'">
              <xsl:attribute name="ishcondition">audience=Internal</xsl:attribute>
            </xsl:if>
            <xsl:element name="title">
              <xsl:value-of select="@name"/>
            </xsl:element>
            <xsl:element name="body">
              <xsl:call-template name="process-fields"/>
            </xsl:element>
          </xsl:element>
        </xsl:result-document>
        <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="subsection">
    
    <xsl:if test="not(@name = 'Block Information')">    
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
      
          <xsl:result-document href="{$filename}.xml">
            <xsl:element name="topic">
              <xsl:attribute name="id">
                <xsl:value-of select="$filename"/>
              </xsl:attribute>              
              <xsl:element name="title">
                <xsl:value-of select="@name"/>
              </xsl:element>
              <xsl:element name="body">
                <xsl:call-template name="process-fields"/>
              </xsl:element>
            </xsl:element>
          </xsl:result-document>
    </xsl:if>

    <xsl:apply-templates/>

  </xsl:template>

  <xsl:template match="content">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="options | tag_list"/>

  <xsl:template name="create-id">
    <xsl:variable name="temp" select="translate(normalize-space(@name), ' /()[]', '_')"/>
    <xsl:value-of select="concat($temp, '_', generate-id())"/>
  </xsl:template>

  <xsl:template name="process-fields">
    <xsl:for-each select="field">      
          <xsl:if test="@id_tag"> <!-- Reserved fields have no id_tag element -->            
            <xsl:element name="section">
              <xsl:if test="@visible = 'false'">
                <xsl:attribute name="ishcondition">audience=Internal</xsl:attribute>
              </xsl:if>
              <xsl:element name="title"><xsl:value-of select="@name"/></xsl:element>                 
              <xsl:element name="table">
                <xsl:attribute name="id"><xsl:value-of select="@id_tag"/></xsl:attribute>                 
                <xsl:element name="title"><xsl:value-of select="@id_tag"
                /></xsl:element>
                <xsl:element name="tgroup">
                  <xsl:attribute name="cols">2</xsl:attribute>
                  <xsl:element name="thead">
                    <xsl:element name="row">
                      <xsl:element name="entry">Parameter</xsl:element>
                      <xsl:element name="entry">Value</xsl:element>
                    </xsl:element>
                  </xsl:element>
                  <xsl:element name="tbody">
                    <xsl:for-each
                      select="@*[not(name() = 'id_tag') and not(name() = 'visible') and not(name() = 'name')]">
                      <xsl:choose>                        
                        <xsl:when test="name() = 'enabledBy'">
                          <xsl:variable name="is-the-target-visible"><xsl:call-template name="is-the-resource-hidden"></xsl:call-template></xsl:variable>
                          <xsl:choose>
                            <xsl:when  test="$is-the-target-visible = true()">
                              <xsl:element name="row">
                                <xsl:element name="entry">
                                  <xsl:value-of select="name()"/>
                                </xsl:element>
                                <xsl:element name="entry">
                                  <xsl:call-template name="create-enabledBy-link"/>
                                </xsl:element>
                              </xsl:element>
                            </xsl:when>
                            <xsl:when test="$is-the-target-visible = false()">
                              <xsl:element name="row">
                                <xsl:attribute name="ishcondition">audience=Internal</xsl:attribute>
                                <xsl:element name="entry">
                                  <xsl:value-of select="name()"/>
                                </xsl:element>
                                <xsl:element name="entry">
                                  <xsl:call-template name="create-enabledBy-link"/>
                                </xsl:element>
                              </xsl:element>
                            </xsl:when>
                          </xsl:choose>                       
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:element name="row">                   
                            <xsl:element name="entry">
                              <xsl:value-of select="name()"/>
                            </xsl:element>
                            <xsl:element name="entry">
                              <xsl:value-of select="."/>
                            </xsl:element>
                          </xsl:element>
                        </xsl:otherwise>
                      </xsl:choose>                    
                    </xsl:for-each>
                  </xsl:element>
                </xsl:element>
              </xsl:element>
              
              <xsl:element name="p">
                <xsl:attribute name="varref" select="@id_tag"/>
              </xsl:element>
              
            </xsl:element>
            
          </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="is-the-resource-hidden">
    <xsl:variable name="current" select="normalize-space(.)"/>    
      <xsl:choose>
        <xsl:when test="//field[@id_tag = $current][@visible='true']">
          <xsl:value-of select="true()"/>
        </xsl:when>
        <xsl:when test="//field[@id_tag = $current][@visible='false']">
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:when test="//field[@id_tag = $current][ancestor::*[@visible='false']]"><!-- Need to figure out how to determine if the closest ancestor is visible. -->
          <xsl:value-of select="false()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="true()"/>
        </xsl:otherwise>
      </xsl:choose>    
  </xsl:template>

  <xsl:template name="create-enabledBy-link">
    <xsl:variable name="current" select="normalize-space(.)"/>
    <xsl:variable name="subsection">
      <xsl:choose>
        <xsl:when test="//field[@id_tag = $current]/parent::*/@id_tag">
          <xsl:value-of select="//field[@id_tag = $current]/parent::*/@id_tag"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="temp" select="normalize-space(translate(//field[@id_tag = $current]/parent::*/@name, ' /()', '_'))"/>
          <xsl:value-of select="concat($temp, '_', //field[@id_tag = $current]/parent::*/generate-id())"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable> 
    <xsl:element name="xref">
      <xsl:attribute name="href">
        <xsl:value-of select="concat($subsection, '.xml#', $subsection, '/', .)"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
