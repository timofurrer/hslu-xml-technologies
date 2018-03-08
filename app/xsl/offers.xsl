<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
	<xsl:param name="filter"/>		
    <xsl:template match="/">
						<h2 class="text-center text-uppercase text-secondary mb-0">Angebote</h2>
					<hr class="star-dark mb-5" />
				<div class="wrapper">
					<!--<header class="header">Sport für alle</header>-->

					<article class="main">
						<div id="flex-container">
							<xsl:choose>
								<xsl:when test="$filter = ''">
									<xsl:apply-templates select="//offer"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="//offer[./sport = $filter]"/>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</article>
					<aside class="aside aside-1">
						<div id="flex-side">
							<xsl:apply-templates select="//sporttype"/>

						</div>
					</aside>
				</div>
    </xsl:template>
				
    <xsl:template match="//offer">
		<div>
			<a href="/?page=offer&amp;offer={sport/text()}" class="flexlink">
                <xsl:value-of select="title"/>
				<!--<xsl:value-of select="$filter"/>-->
            </a>
		</div>
    </xsl:template>
	
	
	<xsl:template match="//sporttype">
		<div>
			<a href="/?page=offers&amp;filter={@id}" class="flexsidelink">
				<xsl:value-of select="title"/>
			</a>
		</div>
	</xsl:template>
</xsl:stylesheet>

<!--
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
-->