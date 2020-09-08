# dns-record-monitor

## Installation

run:

```sh
make tf-init
```

## Usage

run:

```sh
make tf-apply WS=<workspace>
```

To create a new workspace and switch it, run:

```sh
cd terraform
terraform workspace new <workspace>
```

### Test

First, make `.env` like:

```.env
# Twitter Auth
CONSUMER_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
CONSUMER_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXX
ACCESS_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Basic Config
HOST_NAME=github.com
HOST_PORT=443
```

and run:

```sh
make test
```
