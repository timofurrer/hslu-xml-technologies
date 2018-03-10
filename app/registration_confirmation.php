<?php

// load the FOP client.
require_once 'fo/fop_service_client.php';

function generate_fofile($xml_path, $xsl_path, $parameters = []) {
    // Hello security
    $input_data = file_get_contents($xml_path);
    $xml = new DOMDocument();
    $xml->loadXML($input_data);

    $xsl = new DOMDocument();
    $xsl->load($xsl_path);

    // transform
    $xslt_proc = new XSLTProcessor();
    $xslt_proc->importStylesheet($xsl);

    // set parameters to xslt processor
    foreach($parameters as $name => $value) {
        $xslt_proc->setParameter('', $name, $value);
    }

    $dom = $xslt_proc->transformToDoc($xml);

    return $dom->saveXML();
}

function generate_confirmation($registration) {
    $foData = generate_fofile('xml/registrations.xml', 'xsl/reg_confirmation.xsl', array('registration' => $registration));

    // create an instance of the FOP client and perform service request.
    $serviceClient = new FOPServiceClient();
    $pdfFile = $serviceClient->processData($foData, tempnam(sys_get_temp_dir(), 'fo'));

    return sprintf('Generated Confirmation PDF: <strong><a href="%s">download PDF</a></strong>', $pdfFile);
}

?>
