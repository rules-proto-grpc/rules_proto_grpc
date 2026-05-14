use routeguide_grpc::routeguide;
use serde::Deserialize;
use std::fs::File;

#[derive(Debug, Deserialize)]
struct Feature {
    location: Location,
    name: String,
}

#[derive(Debug, Deserialize)]
struct Location {
    latitude: i32,
    longitude: i32,
}

pub fn load() -> Vec<routeguide::Feature> {
    let database_file = std::env::var("DATABASE_FILE").unwrap_or_else(|_| {
        "external/rules_proto_grpc_example_protos+/routeguide_features.json".to_owned()
    });
    let file = File::open(database_file).expect("failed to open data file");

    let decoded: Vec<Feature> =
        serde_json::from_reader(&file).expect("failed to deserialize features");

    decoded
        .into_iter()
        .map(|feature| routeguide::Feature {
            name: feature.name,
            location: Some(routeguide::Point {
                longitude: feature.location.longitude,
                latitude: feature.location.latitude,
            }),
        })
        .collect()
}
