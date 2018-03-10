<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <!-- Import barcode generator templates -->
    <xsl:import href="code128/code128.xsl"/>

    <xsl:param name="eventXml" select="document('../xml/events.xml')"/>
    <xsl:param name="registrationXml" select="document('../xml/registrations.xml')"/>
    <xsl:param name="registration" />

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="confirmation" page-height="29.7cm" page-width="21cm"
                    margin-top="1cm" margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="3cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="confirmation">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:table background-color="#18BC9C" border="1px solid black"  border-collapse="separate" border-separation="10pt">
                        <fo:table-column column-number="1" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block text-align="center" font-size="35pt">
                                        Sport fuer Sehbehinderte
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="//registration[@id = $registration]" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="registration">
        <fo:block text-align="left" font-size="30pt">
            Parathon
        </fo:block>
        <fo:block text-align="left" font-size="15pt">
            Parathon
            Von 15 - 30 April 2017
        </fo:block>
        <fo:table space-after.optimum="20pt" space-before.optimum="20pt" font-size="11pt" border="1px solid black"  border-collapse="separate" border-separation="5pt">
            <fo:table-column column-number="1" />
            <fo:table-column column-number="2" />
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block text-align="left" font-size="12pt">
                            <fo:table space-after.optimum="20pt" space-before.optimum="20pt" font-size="11pt">
                                <fo:table-column column-width="30%" column-number="1" />
                                <fo:table-column column-number="2" />
                                <fo:table-body>
                                     <fo:table-row>
                                         <fo:table-cell>
                                            <fo:block>
                                                Name:
                                            </fo:block>
                                         </fo:table-cell>
                                         <fo:table-cell>
                                             <fo:block>
                                                <xsl:value-of select="participant/name" />
                                            </fo:block>
                                        </fo:table-cell>
                                     </fo:table-row>
                                     <fo:table-row>
                                         <fo:table-cell>
                                            <fo:block>
                                                E-Mail:
                                            </fo:block>
                                         </fo:table-cell>
                                         <fo:table-cell>
                                             <fo:block>
                                                <xsl:value-of select="participant/email" />
                                            </fo:block>
                                        </fo:table-cell>
                                     </fo:table-row>
                                     <fo:table-row>
                                         <fo:table-cell>
                                            <fo:block>
                                                Telefon:
                                            </fo:block>
                                         </fo:table-cell>
                                         <fo:table-cell>
                                             <fo:block>
                                                <xsl:value-of select="participant/tel" />
                                            </fo:block>
                                        </fo:table-cell>
                                     </fo:table-row>
                                     <fo:table-row>
                                         <fo:table-cell>
                                            <fo:block>
                                                Adresse:
                                            </fo:block>
                                         </fo:table-cell>
                                         <fo:table-cell>
                                             <fo:block>
                                                <xsl:value-of select="participant/address" />
                                            </fo:block>
                                        </fo:table-cell>
                                     </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="barcode" />
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <fo:block text-align="left" font-size="15pt">
            Wir freuen uns Sie bald bei uns zu sehen!
        </fo:block>
    </xsl:template>

    <!-- This template call barcode generator to create SVG representation of code128 barcode -->
    <xsl:template name="barcode" mode="draw">
      <fo:block>
        <fo:instream-foreign-object content-width="100%" content-height="100%">
          <xsl:call-template name="barcode-code128">
            <xsl:with-param name="value" select="$registration"/>
            <xsl:with-param name="subset" select="'B'"/>
            <xsl:with-param name="string" select="concat('Registration Id: ', $registration)"/>
          </xsl:call-template>
        </fo:instream-foreign-object>
      </fo:block>
    </xsl:template>
</xsl:stylesheet>
