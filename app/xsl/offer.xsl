<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
	<xsl:param name="eventXml" select="document('../xml/events.xml')"/>
	<xsl:param name="registrationXml" select="document('../xml/registrations.xml')"/>
	<xsl:param name="offer" />


    <xsl:template match="/">
			<xsl:apply-templates select="//offers/offer[@id = $offer]" />
    </xsl:template>

    <xsl:template match="offer">
		<h2 class="text-center text-uppercase text-secondary mb-0">
			<xsl:value-of select="title" />
		</h2>
		<hr class="star-dark mb-5" />


		<xsl:value-of select="description" />


		<table id="offerDetailTable" >
			<tr>
				<th> Datum</th>
				<th> Belegte Plätze</th>
				<th> Preis</th>
				<th> Anmelden</th>
			</tr>
			<xsl:apply-templates select="$eventXml//events/event/offerId" />
		</table>

		<div class="control-group">
			<div class="control-group">
				<h4 class="">
					Austragungsort
				</h4>
				<img src="https://chsroundup.com/wp-content/uploads/2016/05/map-01.jpg" />
			</div>
			<div class="control-group">
			<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" >
			  <rect x="10" y="10" width="10"
				height="50" fill="red" stroke="black"/>
			</svg>
			</div>
		</div>
    </xsl:template>

	<xsl:template match="//events/event/offerId">
                <xsl:variable name="evId" select="../@id" />
		 <tr>
			<td><xsl:value-of select="../from" /> - <xsl:value-of select="../to" /></td>
			<td>
				<xsl:value-of select="count($registrationXml//registration/eventId[text() = $evId])" />
				/ <xsl:value-of select="../maxParticipant" />
			</td>
			<td><xsl:value-of select="../price" /> CHF.-</td>
                        <td> <a href="/?page=registration&amp;offer={$offer}&amp;event={$evId}" class="btn btn-primary btn-xl" id="registrationButton">Anmelden</a></td>
		  </tr>
	</xsl:template>
</xsl:stylesheet>
