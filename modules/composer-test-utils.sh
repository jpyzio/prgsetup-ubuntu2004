#!/usr/bin/env bash

which composer > /dev/null
if [[ "${?}" == "1" ]]; then
	source "${MODULES_DIR}/composer.sh"
fi

composer global require \
    sebastian/phpcpd \
    phploc/phploc \
    phpmd/phpmd \
    squizlabs/php_codesniffer \
    phpstan/phpstan
