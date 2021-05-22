#!/usr/bin/env bash

if ! which composer > /dev/null; then
    source "${MODULES_DIR}/composer.sh"
fi

run_as_user composer global require \
    sebastian/phpcpd \
    phploc/phploc \
    phpmd/phpmd \
    squizlabs/php_codesniffer \
    phpstan/phpstan \
    phpunit/phpunit
