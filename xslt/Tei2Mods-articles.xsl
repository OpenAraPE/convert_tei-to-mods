<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.loc.gov/mods/v3">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no" version="1.0"/>
    <!-- this stylesheet generates a MODS XML file with bibliographic metadata for each <div> in the body of the TEI source file. File names are based on the source's @xml:id and the @xml:id of the <div>. -->
    <xsl:include href="Tei2Mods-functions.xsl"/>
    <!-- all parameters and variables are set in Tei2Mods-functions.xsl -->
    <xsl:template match="/">
        <xsl:apply-templates select="descendant::tei:text/tei:body/descendant::tei:div"/>
    </xsl:template>
    <xsl:template match="tei:div">
        <!-- tei:div[@type = 'section'][not(ancestor::tei:div[@type = ('article', 'bill', 'item')])] | tei:div[@type = ('article', 'item')][not(ancestor::tei:div[@type = 'bill'])] | tei:div[@type = ('article', 'item')][not(ancestor::tei:div[@type = 'item'][@subtype = 'bill'])] | tei:div[@type = 'bill'] | tei:div[@type = 'item'][@subtype = 'bill'] -->
        <xsl:choose>
            <!-- prevent output for sections of legal texts -->
            <xsl:when
                test="ancestor::tei:div[@type = 'bill'] or ancestor::tei:div[@subtype = 'bill']"/>
            <!-- prevent output for mastheads -->
            <xsl:when test="@type='masthead' or @subtype='masthead'"/>
            <!-- prevent output for sections of articles -->
            <xsl:when test="ancestor::tei:div[@type='item']"/>
            <xsl:when test="@type = ('section', 'item')">
                <xsl:result-document href="../metadata/{concat($vgFileId,'-',@xml:id)}.MODS.xml">
                    <xsl:element name="modsCollection">
                        <xsl:attribute name="xsi:schemaLocation" select="$v_schema"/>
                        <xsl:call-template name="t_div-to-mods">
                            <xsl:with-param name="p_input" select="."/>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
