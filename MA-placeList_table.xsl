<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output method="xhtml" indent="yes" encoding="UTF-8"/>
    <!-- EGGER, Christopher - XSLT zum Masterprojekt/zur Masterarbeit -->
    <!-- Version 1.3 (Letzte Aktualisierung am 2021-10-28) -->
    <!-- erster Schritt: Allgemeiner Einstieg -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Verzeichnis listPlace</title>
            </head>
            <body>
                <br/>
                <h1>Tabelle/Verzeichnis aller vorkommenden "place"-Elemente*</h1>
                <br/>
                <xsl:apply-templates select="//listPlace"/>
                <br/>
                <footer>*Es werden alle "place"-Elemente angeführt, die innerhalb der Steiermark
                    vorkommen - in systematischer Reihung anhand der Typen und Subtypen (AAT) in
                    alphabetischer Reihung, innerhalb jener die chronologische Abfolge laut des
                    Reiseberichts. In Klammern werden Ergänzungen angeführt und die Lage wird nur
                    zur klaren Identifikation (teilweise) ergänzend angeführt.</footer>
            </body>
        </html>
    </xsl:template>
    <!-- zweiter Schritt: Table Grundgerüst -->
    <xsl:template match="//listPlace">
        <table border="1" style="border:2px solid black;">
            <tr style="background-color:grey">
                <th>lfd. Nr.</th>
                <th>xml:id</th>
                <th>Bezeichnung dato</th>
                <th>Bezeichnung Kyselak</th>
                <th>Bezeichnung Kataster</th>
                <th>Lage</th>
                <th>AAT</th>
                <th>@cert</th>
                <th>Stringlänge</th>
            </tr>

            <xsl:for-each select="//listPlace/place">

                <tr>
                    <td style="background-color:grey">
                        <xsl:number/>
                    </td>
                    <td style="background-color:lightgrey">
                        <xsl:value-of select="@xml:id"/>
                    </td>

                    <td>
                        <xsl:for-each select="placeName[@type = 'dato']">
                            <xsl:value-of select="placeName[@type = 'dato' and @xml:id='deu']"/>
                            <xsl:if test="position() > 1">
                                <xsl:text>; </xsl:text>
                            </xsl:if>
                            <xsl:apply-templates/>
                            <xsl:if test="@xml:lang='slo'">
                                <xsl:text> [SLO] </xsl:text>
                            </xsl:if>                            
                        </xsl:for-each>
                    </td>

                    <td style="background-color:lightgrey">
                        <xsl:for-each select="placeName[@type = 'kyselak']">
                            <xsl:value-of select="placeName[@type = 'kyselak']"/>
                            <xsl:if test="position() > 1">
                                <xsl:text>; </xsl:text>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </td>

                    <td style="background-color:lightgrey">
                        <xsl:for-each select="placeName[@type = 'kataster']">
                            <xsl:value-of select="placeName[@type = 'kataster']"/>
                            <xsl:if test="position() > 1">
                                <xsl:text>; </xsl:text>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </xsl:for-each>
                    </td>
                    
                    <td>
                        <xsl:value-of select="location/placeName"/>
                    </td>

                    <td style="background-color:lightgrey">
                        <xsl:value-of select="desc[@type = 'AAT']/text()/substring-after(., '-')"/>
                    </td>
                    <td>
                        <xsl:value-of select="@cert"/>
                    </td>
                    <td style="background-color:lightgrey;text-align:right">
                        <xsl:variable name="countString">
                            <xsl:for-each select="@xml:id">
                                <xsl:value-of select="."/>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:value-of
                            select="sum(//*[@corresp[contains(., $countString)]]/string-length(normalize-space(.)))"/>
                        <!-- Test der Variable <xsl:value-of select="$countString"/>-->
                    </td>
                </tr>
            </xsl:for-each>

        </table>
    </xsl:template>

</xsl:stylesheet>
