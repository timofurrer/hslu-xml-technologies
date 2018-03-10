<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:param name="offer" />
    <xsl:param name="restrictionsXml" select="document('../xml/restrictions.xml')"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//offer[@id = $offer]" />
    </xsl:template>

    <xsl:template match="offer">
        <h2 class="text-center text-uppercase text-secondary mb-0">Registration: <xsl:value-of select="title"/></h2>
        <hr class="star-dark mb-5" />
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <form name="registration" id="registrationForm" method="post" action="#">
                  <div class="control-group">
                    <h3>Zu Ihnen</h3>
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label for="name">Name</label>
                      <input class="form-control" id="name" name="name" type="text" placeholder="Name" required="required" data-validation-required-message="Bitte geben Sie Ihren Namen ein." />
                      <p class="help-block text-danger"></p>
                    </div>
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label for="email">Email Address</label>
                      <input class="form-control" id="email" name="email" type="email" placeholder="Email Address" required="required" data-validation-required-message="Bitte geben Sie Ihre E-Mail Adresse ein." />
                      <p class="help-block text-danger"></p>
                    </div>
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label for="phone">Telefon</label>
                      <input class="form-control" id="phone" name="tel" type="tel" placeholder="Phone Number" required="required" data-validation-required-message="Bitte geben Sie Ihre Telefonnummer ein." />
                      <p class="help-block text-danger"></p>
                    </div>
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label for="address">Adresse</label>
                      <input class="form-control" id="address" name="address" type="text" placeholder="Adresse" required="required" data-validation-required-message="Bitte geben Sie Ihre Adresse ein." />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <h3>Uebernachtung</h3>
                    <div class="form-group form-check floating-label-form-group controls mb-0 pb-2">
                      <input class="form-check-input" id="uebernachtung" name="uebernachtung" type="checkbox" />
                      <label class="form-check-label">Mit Uebernachtung</label>
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <h3>Einschraenkungen</h3>
                    <xsl:apply-templates select="$restrictionsXml/restrictions/restriction" />
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                        <label>Beschreibung Ihrer Einschraenkung</label>
                        <textarea class="form-control" id="description" name="restriction_description" rows="5"></textarea>
                        <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <br />
                  <div id="success"></div>
                  <button type="submit" class="btn btn-primary btn-xl" id="sendMessageButton">Send</button>
                </form>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="restriction">
        <xsl:variable name="restrictionId" select="@id" />
        <div class="form-group form-check floating-label-form-group controls mb-0 pb-2">
            <input class="form-check-input" id="restrictions" name="restrictions[]" value="{$restrictionId}" type="checkbox" />
            <label class="form-check-label">
                <xsl:value-of select="text()" />
            </label>
        </div>
    </xsl:template>
</xsl:stylesheet>
