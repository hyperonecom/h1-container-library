'use strict';
module.exports = {
    "3.7": {
        "args": {
            "PY_VERSION": "3.7",
            "PYTHON_LIBS": "libmariadbclient18 libmariadbclient-dev libffi-dev libssl-dev libjpeg-dev libpng-dev libxml2-dev libxslt1-dev libjpeg62 python3-dev build-essential"
        }
    },
    "3.8": {
        "args": {
            "PY_VERSION": "3.8",
            "PYTHON_LIBS": "libmariadbclient18 libmariadbclient-dev libffi-dev libssl-dev libjpeg-dev libpng-dev libxml2-dev libxslt1-dev libjpeg62 python3-dev build-essential"
        },
        "latest": true,
        "packages": ["python"],
    }
}