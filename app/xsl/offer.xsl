<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:param name="offer" />

    <xsl:template match="/">
        <xsl:apply-templates select="//Angebot[@id = $offer]" />
    </xsl:template>

    <xsl:template match="Angebot">
        <h2 class="text-center text-uppercase text-secondary mb-0">Angebot: <xsl:value-of select="Name"/></h2>
        <hr class="star-dark mb-5" />
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <xsl:value-of select="Description" />
                <br />
                <a href="/?page=registration&amp;offer={$offer}" class="btn btn-primary btn-xl" id="registrationButton">Anmelden</a>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
