<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:param name="eventXml" select="document('../xml/events.xml')"/>
    <xsl:param name="registrationXml" select="document('../xml/registrations.xml')"/>
    <xsl:param name="restrictionsXml" select="document('../xml/restrictions.xml')"/>
    <xsl:param name="offer"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//offers/offer[@id = $offer]"/>
    </xsl:template>
    <xsl:template match="offer">
        <h2 class="text-center text-uppercase text-secondary mb-0">
            <xsl:value-of select="title"/>
        </h2>
        <hr class="star-dark mb-5"/>
        <xsl:value-of select="description"/>
        <xsl:variable name="offerEvents" select="$eventXml//events/event/offerId[text() = $offer]"/>
        <xsl:choose>
            <xsl:when test="($offerEvents)">
                <table id="offerDetailTable">
                    <tr>
                        <th> Datum</th>
                        <th> Belegte Pl&#xE4;tze</th>
                        <th> Preis</th>
                        <th> Anmelden</th>
                    </tr>
                    <xsl:apply-templates select="$offerEvents"/>
                </table>
                <div class="control-group">
                    <div class="control-group">
                        <h4>Austragungsort</h4>
                        <img src="https://chsroundup.com/wp-content/uploads/2016/05/map-01.jpg"/>
                    </div>
                    <br />
                    <div class="control-group">
                        <h4>Besuchsstatistik</h4>
                        <!-- hier wird eine mit space seperierte liste von event ids zu diesem Angebot gemacht -->
                        <xsl:variable name="eventIdList">
                            <xsl:for-each select="$offerEvents/../@id">
                                <xsl:choose>
                                    <xsl:when test="position() = 1">
                                        <xsl:value-of select="."/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(' ', .) "/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:variable>
                        <figure>
                            <figcaption>
                                Besucherzahlen nach Einschraenkungen fuer die aktuellen und vergangenen Events
                            </figcaption>
                            <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="chart" width="420" height="400" aria-labelledby="title" role="img">
                                <title id="title">Besucherzahlen nach Einschraenkungen</title>
                                <xsl:for-each select="$restrictionsXml//restriction">
                                    <xsl:variable name="resId" select="./@id" />
                                    <xsl:variable name="numberOfVisited">
                                        <!-- Hier werden zuerst alle registration-nodes gesucht die eine event id in der eventIdList haben danach werden die restriction gezählt -->
                                        <!-- Dies macht man so weil XSLT 1.0 group by nicht unterstützt und Muenchian grouping funktionierte auch nicht -->
                                        <xsl:value-of select="count($registrationXml//registration/eventId[contains($eventIdList, text())]/../restrictions/restrictionId[text() = $resId])" />
                                    </xsl:variable>

                                    <xsl:variable name="barWidth" select="40 * $numberOfVisited" />
                                    <xsl:variable name="barYOffset" select="50 * ($resId - 1)" />
                                    <xsl:variable name="textXOffset" select="$barWidth + 10" />
                                    <xsl:variable name="textYOffset" select="20 + (($resId - 1) * 50)" />

                                    <g class="bar">
                                        <rect width="{$barWidth}" height="40" y="{$barYOffset}" />
                                        <text x="{$textXOffset}" y="{$textYOffset}" dy=".35em">
                                            <xsl:value-of select="$numberOfVisited"/>: <xsl:value-of select="." />
                                        </text>
                                    </g>

                                </xsl:for-each>
                            </svg>
                        </figure>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
					No Events
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//events/event/offerId">
        <xsl:variable name="evId" select="../@id"/>
        <tr>
            <td><xsl:value-of select="../from"/> - <xsl:value-of select="../to"/></td>
            <td><xsl:value-of select="count($registrationXml//registration/eventId[text() = $evId])"/>
				/ <xsl:value-of select="../maxParticipant"/>
			</td>
            <td><xsl:value-of select="../price"/> CHF.-</td>
            <td>
                <a href="/?page=registration&amp;offer={$offer}&amp;event={$evId}" class="btn btn-primary btn-xl" id="registrationButton">Anmelden</a>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
