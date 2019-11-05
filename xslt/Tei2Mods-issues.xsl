<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.loc.gov/mods/v3">
    <xsl:output encoding="UTF-8" indent="yes" method="xml" omit-xml-declaration="no" version="1.0"/>
    <!-- this stylesheet generates a MODS XML file with bibliographic metadata for each <div> in the body of the TEI source file. File names are based on the source's @xml:id and the @xml:id of the <div>. -->
    <xsl:include href="Tei2Mods-functions.xsl"/>
    <xsl:template match="/">
        <xsl:result-document href="../metadata/issues/{$vgFileId}.MODS.xml">
            <modsCollection xsi:schemaLocation="http://www.loc.gov/mods/v3 {$v_schema}">
                <!-- construct MODS -->
                <xsl:apply-templates select="descendant::tei:text/tei:body/descendant::tei:div"/>
            </modsCollection>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:div">
        <!-- tei:div[@type = 'section'][not(ancestor::tei:div[@type = 'article'])][not(ancestor::tei:div[@type = 'bill'])] |
        tei:div[@type = 'section'][not(ancestor::tei:div[@type = 'item'])][not(ancestor::tei:div[@type = 'bill'])] |
        tei:div[@type = 'article'][not(ancestor::tei:div[@type = 'bill'])] | 
        tei:div[@type = 'item'][not(ancestor::tei:div[@type = 'bill'])] | 
        tei:div[@type = 'bill'] -->
        <xsl:choose>
            <!-- prevent output for sections of legal texts -->
            <xsl:when
                test="ancestor::tei:div[@type = 'bill'] or ancestor::tei:div[@subtype = 'bill']"/>
            <!-- prevent output for sections of articles -->
            <xsl:when test="parent::tei:div[@type = 'item']"/>
            <xsl:when test="@type = ('section', 'item')">
                <xsl:call-template name="t_div-to-mods">
                    <xsl:with-param name="p_input" select="."/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
