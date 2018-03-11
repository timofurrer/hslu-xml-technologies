validate:
	cd xml/ && for xml in *; do \
	    xmllint $$xml --schema ../xsd/$${xml%.xml}.xsd; \
	done

test-reg-conf-fo:
	xsltproc --stringparam registration 5aa3e973e0a7c xsl/reg_confirmation.xsl xml/registrations.xml > test.fo && fop test.fo test.pdf
