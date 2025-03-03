### Build documentation
Widoco jar is located under `tools/`

Run this command from root dir
`./data/schemas/build-documentation.sh`

This performs the following actions:

1. Concatenates ontology parts from version directory (`v0.0.1`) into `qcy-v0.0.1.ttl`
1. Builds documentation for ontology in `DOCS/qcy-v0.0.1`
1. Concatenates enumeration parts from `enums` directory into `qce.ttl`
1. Builds documentation for enums in `DOCS/qce`
1. Concatenates shape parts from `shapes` directory into `shapes.ttl`
1. Updates all modification dates to the time of building