#!/bin/bash

function replaceInFile(){
    search=$1
    replace=$2
    file=$3
    sed -i "s/$search/$replace/g" $file
}

function generatePassword(){
    openssl rand -base64 32
}

function enableService(){
    service=$1
    systemctl enable $service
    systemctl restart $service
}

function letsEncrypt(){
    domain=$1
    dir=/usr/share/nginx/$domain
    letsencrypt certonly -a webroot --webroot-path=$dir -d $domain
}