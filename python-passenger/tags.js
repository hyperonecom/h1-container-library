'use strict';

const PYTHON_LIBS = "libmariadbclient18 libmariadbclient-dev libffi-dev libssl-dev libjpeg-dev libpng-dev libxml2-dev libxslt1-dev libjpeg62 python3-dev build-essential";


module.exports = {
    "3.7": {
        "args": {
            "PY_VERSION": "3.7",
            PYTHON_LIBS,
        }
    },
    "3.8": {
        "args": {
            "PY_VERSION": "3.8",
            PYTHON_LIBS,
        },
        "packages": ["python"],
    },
    "3.9": {
        "args": {
            "PY_VERSION": "3.9",
            PYTHON_LIBS,
        },
        "latest": true,
        "packages": ["python"],
    },
}