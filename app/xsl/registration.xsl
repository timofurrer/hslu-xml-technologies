<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    <xsl:param name="offer" />

    <xsl:template match="/">
        <xsl:apply-templates select="//offer[@id = $offer]" />
    </xsl:template>

    <xsl:template match="offer">
        <h2 class="text-center text-uppercase text-secondary mb-0">Registration: <xsl:value-of select="title"/></h2>
        <hr class="star-dark mb-5" />
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <form name="registration" id="registrationForm" novalidate="novalidate">
                  <div class="control-group">
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label>Name</label>
                      <input class="form-control" id="name" type="text" placeholder="Name" required="required" data-validation-required-message="Please enter your name." />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label>Email Address</label>
                      <input class="form-control" id="email" type="email" placeholder="Email Address" required="required" data-validation-required-message="Please enter your email address." />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label>Telefon</label>
                      <input class="form-control" id="phone" type="tel" placeholder="Phone Number" required="required" data-validation-required-message="Please enter your phone number." />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label>Adresse</label>
                      <input class="form-control" id="address" type="text" placeholder="Adresse" required="required" data-validation-required-message="Please enter your phone number." />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <div class="control-group">
                    <div class="form-group floating-label-form-group controls mb-0 pb-2">
                      <label>Mit Uebernachtung</label>
                      <input class="form-control" id="uebernachtung" type="checkbox" />
                      <p class="help-block text-danger"></p>
                    </div>
                  </div>
                  <br />
                  <div id="success"></div>
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-xl" id="sendMessageButton">Send</button>
                  </div>
                </form>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
