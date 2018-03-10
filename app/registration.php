<?php

function register($eventId, $name, $email, $tel, $address, $with_stayover, $restrictions, $description) {
    $xml = simplexml_load_file('xml/registrations.xml');

    // create new Registration entry
    $reg_node = $xml->addChild('registration');
    $reg_node->addChild('eventId', htmlentities($eventId));
    $participant_node = $reg_node->addChild('participant');
    $participant_node->addChild('name', htmlentities($name));
    $participant_node->addChild('email', htmlentities($email));
    $participant_node->addChild('tel', htmlentities($tel));
    $participant_node->addChild('address', htmlentities($address));
    $reg_node->addChild('needs_stayover', htmlentities($with_stayover));
    $restriction_node = $reg_node->addChild('restrictions');
    foreach($restrictions as $restriction) {
        $restriction_node->addChild('restriction', htmlentities($restriction));
    }
    $restriction_node->addChild('description', htmlentities($description));
    file_put_contents('xml/registrations.xml', $xml->asXML());

    echo "<div class=\"alert alert-success\" role=\"alert\">Sie wurden erfolgreich angemeldet!</div>";
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
            isset($_POST['uebernachtung']), $_POST['restrictions'], $_POST['restriction_description']);
    }
}
?>
