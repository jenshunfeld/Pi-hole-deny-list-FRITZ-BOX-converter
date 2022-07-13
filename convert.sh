#!/bin/bash
##############################
# Author: Jens Hunfeld       #
# Nick: Lehrling             #
# Website: http://hunfeld.eu #
##############################

function greenMessage() {
  echo -e "\\033[32;1m${*}\\033[0m"
}
#setter
main_verz=`pwd`
config_name=config.yml
#
#cofig geter
line_mumber_start="$(cat $config_name|head -n4|tail -n1|awk '{print $2}')"
number_of_urls="$(cat $config_name|head -n6|tail -n1|awk '{print $2}')"
file_name="$(cat $config_name|head -n8|tail -n1|awk '{print $2}')"
file_name_new="$(cat $config_name|head -n10|tail -n1|awk '{print $2}')"
console_output="$(cat $config_name|head -n12|tail -n1|awk '{print $2}')"
log_writing="$(cat $config_name|head -n14|tail -n1|awk '{print $2}')"
log_file_name="$(cat $config_name|head -n16|tail -n1|awk '{print $2}')"
#
#

if [[ "$console_output" == "true" ]]; then
  echo ""
else
  greenMessage "Pi-hole Converter starting... Please wait."
fi


while [[ true ]]; do
      if [[ "$line_mumber_start" == "$number_of_urls" ]]; then
      #if [[ "$count" == "100" ]]; then
        echo "done"
        break
      fi
#
  domain_name="$(cat $file_name|head -n$line_mumber_start|tail -n1|awk '{print $2}')"
  domain_name_sort="$(cat $file_name|head -n$line_mumber_start|tail -n1|awk '{print $1}')"
    if [[ "$domain_name_sort" == "0.0.0.0"  ]]; then
      echo "$domain_name," >> url_new.yml
#
            if [[ "$console_output" == "true" ]]; then
              greenMessage "$(date "+%T"): Pi-hole converter: URL-Nr:$line_mumber_start URL: $domain_name übermittelt"
            fi
            if [[ "$log_writing" == "true" ]]; then
              echo -e "$(date "+%T"): Pi-hole converter: URL-Nr:$line_mumber_start URL:$domain_name einegtragen " >> $log_file_name
            fi
#
        line_mumber_start=$((line_mumber_start+1))
    else
      line_mumber_start=$((line_mumber_start+1))
    fi
#
done
greenMessage "List succesful convertet"
sleep 5
exit
#
