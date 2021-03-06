# resume-parser

A Java Spring Boot based Resume Parser API using GATE library.

Works well with any type of CV (PDF, HTML, DOC, DOCX, RTF, TXT) or LinkedIn Profile Document. 
Can extract all types of useful information correctly in English.

#### Local Run & Test

- Terminal 1
```
make run
```

- Terminal 2
```
make test
```

#### Docker Run & Test

- Terminal 1
```
make docker_build
```

- Terminal 2
```
make docker_run
```
- Terminal 3
```
make test
```

### Helm Dependency

```
apiVersion: v2
name: connexions
description: A Helm chart for Kubernetes
type: application
version: 0.0.1
appVersion: "0.0.1"
dependencies:
  - name: resume-parser
    alias: resume-parser
    version: 0.0.2
    condition: resume-parser.enabled
    repository: https://zbytes.github.io/resume-parser
```

#### References
- GATE (https://gate.ac.uk/) - Open source language processing framework.

