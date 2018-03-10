<?php

function register($eventId, $name, $email, $tel, $address, $with_stayover, $restrictions, $description) {
    $xml = simplexml_load_file('xml/registrations.xml');

    // create new Registration entry
    $reg_node = $xml->addChild('registration');
    $reg_node->addChild('eventId', $eventId);
    $participant_node = $reg_node->addChild('participant');
    $participant_node->addChild('name', $name);
    $participant_node->addChild('email', $email);
    $participant_node->addChild('tel', $tel);
    $participant_node->addChild('address', $address);
    $reg_node->addChild('needs_stayover', $with_stayover);
    $restriction_node = $reg_node->addChild('restrictions');
    foreach($restrictions as $restriction) {
        $restriction_node->addChild('restriction', $restriction);
    }
    $restriction_node->addChild('description', $description);

    file_put_contents('xml/registrations.xml', $xml->asXML());
}

function verify($available_fields, $required_fields) {
    # check required fields
    foreach($required_fields as $field) {
        if(empty($available_fields[$field])) {
            echo "Bitte das Feld $field angeben";
            return false;
        }
    }
    return true;
}

var_dump($_POST);

if(!empty($_POST)) {
    $required_fields = array('name', 'email', 'tel', 'address');

    if(verify($_POST, $required_fields)) {
        register($_GET['event'], $_POST['name'], $_POST['email'], $_POST['tel'], $_POST['address'],
            isset($_POST['uebernachtung']), $_POST['restrictions'], $_POST['description']);
    }
}
?>
