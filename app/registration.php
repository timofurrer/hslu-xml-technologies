<?php

require_once 'registration_confirmation.php';

function register($eventId, $name, $email, $tel, $address, $with_stayover, $restrictions, $description) {
    $xml = simplexml_load_file('xml/registrations.xml');

    $registration_id = uniqid();

    // create new Registration entry
    $reg_node = $xml->addChild('registration');
    $reg_node->addAttribute('id', $registration_id);
    $reg_node->addChild('eventId', htmlentities($eventId));
    $participant_node = $reg_node->addChild('participant');
    $participant_node->addChild('name', htmlentities($name));
    $participant_node->addChild('email', htmlentities($email));
    $participant_node->addChild('tel', htmlentities($tel));
    $participant_node->addChild('address', htmlentities($address));
    $reg_node->addChild('needs_stayover', htmlentities((string)$with_stayover));
    $restriction_node = $reg_node->addChild('restrictions');
    foreach($restrictions as $restriction) {
        $restriction_node->addChild('restriction', htmlentities($restriction));
    }
    $restriction_node->addChild('description', htmlentities($description));

    $to_persist_xml = new DOMDocument();
    $to_persist_xml->formatOutput = true;
    $to_persist_xml->preserveWhiteSpace = false;
    $to_persist_xml->loadXML($xml->asXML());

    // validate XML before persisting
    // disable error output to client
    libxml_use_internal_errors(true);
    $result = $to_persist_xml->schemaValidate('xsd/registrations.xsd');

    if(!$result) {
        echo '<div class="alert alert-danger" role="alert">';
        // schema validation failed
        $errors = libxml_get_errors();
        foreach($errors as $error) {
            echo sprintf('Line [%d]: %s', $error->line, $error->message);
        }
        libxml_clear_errors();

        echo "</div>";
    }
    else {
        file_put_contents('xml/registrations.xml', $to_persist_xml->saveXML());

        // generate confirmation PDF
        $confirmation = generate_confirmation($registration_id);

        echo '<div class="alert alert-success" role="alert">';
        echo "Sie wurden erfolgreich angemeldet! ";
        echo $confirmation;
        echo "</div>";
    }
}

function verify($available_fields, $required_fields) {
    # check required fields
    foreach($required_fields as $field) {
        if(empty($available_fields[$field])) {
            echo "<div class=\"alert alert-danger\" role=\"alert\">Bitte das Feld $field angeben</div>";
            return false;
        }
    }
    return true;
}

if(!empty($_POST)) {
    $required_fields = array('name', 'email', 'tel', 'address');

    if(verify($_POST, $required_fields)) {
        register($_GET['event'], $_POST['name'], $_POST['email'], $_POST['tel'], $_POST['address'],
            $_POST['uebernachtung'] ? 'true' : 'false', $_POST['restrictions'], $_POST['restriction_description']);
    }
}
?>
