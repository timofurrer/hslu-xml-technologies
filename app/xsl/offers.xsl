<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>


    <xsl:template match="/">
        <h2 class="text-center text-uppercase text-secondary mb-0">Angebote</h2>
        <hr class="star-dark mb-5" />
        <div class="row">
            <div class="col-md-12">
                <ul>
                    <xsl:apply-templates />
                </ul>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="Angebot">
        <li>
            <a href="/?page=offer&amp;offer={@id}">
                <xsl:value-of select="Name" />
            </a>
        </li>
    </xsl:template>
</xsl:stylesheet>
