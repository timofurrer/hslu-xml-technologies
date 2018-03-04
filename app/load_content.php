<?php

function load_page($xml_path, $xsl_path) {
    // Hello security
    $input_data = file_get_contents($xml_path);
    $xml = new DOMDocument();
    $xml->loadXML($input_data);

    $xsl = new DOMDocument();
    $xsl->load($xsl_path);

    // transform
    $xslt_proc = new XSLTProcessor();
    $xslt_proc->importStylesheet($xsl);
    $dom = $xslt_proc->transformToDoc($xml);

    return $dom->saveXML();
}

$page = isset($_GET['page']) ? trim($_GET['page']) : 'offers';

switch($page) {
    case 'offers':
        echo load_page('xml/'.$page.'.xml', 'xsl/'.$page.'.xsl');
        break;
    default:
        die('Yet undefined page ' . $page);
}

?>
