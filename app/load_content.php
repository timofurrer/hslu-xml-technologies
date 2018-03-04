<?php

function load_page($xml_path, $xsl_path, $parameters = []) {
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

$page = isset($_GET['page']) ? trim($_GET['page']) : 'offers';

switch($page) {
    case 'offers':
        echo load_page('xml/offers.xml', 'xsl/offers.xsl');
        break;
    case 'registration':
        $offer = $_GET['offer'];
        echo load_page('xml/offers.xml', 'xsl/registration.xsl', array('offer' => $offer));
        break;
    default:
        die('Yet undefined page ' . $page);
}

?>
