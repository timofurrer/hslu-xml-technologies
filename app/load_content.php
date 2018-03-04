<?php
$page = isset($_GET['page']) ? trim($_GET['page']) : 'offers';

// Hello security
$input_data = file_get_contents('xml/'.$page.'.xml');
$xml = new DOMDocument();
$xml->loadXML($input_data);

$xsl = new DOMDocument();
$xsl->load('xsl/'.$page.'.xsl');

// transform
$xslt_proc = new XSLTProcessor();
$xslt_proc->importStylesheet($xsl);
$dom = $xslt_proc->transformToDoc($xml);

echo $dom->saveXML();
?>
