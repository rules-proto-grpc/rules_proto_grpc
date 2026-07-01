use person_place_rust_proto::examples::proto::Person;
use proto_runtime::{prost::Message, serde_json};

#[test]
fn generated_message_round_trips_with_public_proto_runtime() {
    let person = Person {
        name: "Ada".to_owned(),
        place: None,
    };

    let mut encoded = Vec::new();
    person.encode(&mut encoded).unwrap();

    let decoded = Person::decode(encoded.as_slice()).unwrap();
    assert_eq!(decoded.name, "Ada");

    let json = serde_json::to_string(&decoded).unwrap();
    assert_eq!(json, r#"{"name":"Ada"}"#);

    let decoded_json: Person = serde_json::from_str(&json).unwrap();
    assert_eq!(decoded_json.name, "Ada");
}
