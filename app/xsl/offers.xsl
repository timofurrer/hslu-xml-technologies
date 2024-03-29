<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
	<xsl:param name="filter"/>		
	<xsl:param name="sportfile" select="document('../xml/sporttypes.xml')"/>
    <xsl:template match="/">
						<h2 class="text-center text-uppercase text-secondary mb-0">Angebote</h2>
					<hr class="star-dark mb-5" />
				<div class="wrapper">
			

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
							<a href="/?page=offers">Filter zurücksetzen</a>
							<xsl:apply-templates select="$sportfile//sporttype"/>
						</div>
					</aside>
				</div>
				
    </xsl:template>
				
    <xsl:template match="//offer">
		<div>
			<a href="/?page=offer&amp;offer={@id}" class="flexlink">
                <xsl:value-of select="title"/>
				 
				 <div class="bottom-left">
					<img src="../resources/{suitable}.png" height="70" width="70"/>
				 </div>
            </a>
		</div>
    </xsl:template>

	<xsl:template match="//sporttype">
		<div>
			<xsl:choose>
				<xsl:when test="@id = $filter">
					<a href="/?page=offers&amp;filter={@id}" class="selectedflexsidelink">
						<xsl:value-of select="title"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<a href="/?page=offers&amp;filter={@id}" class="flexsidelink">
						<xsl:value-of select="title"/>
					</a>
				</xsl:otherwise>
			</xsl:choose>	
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