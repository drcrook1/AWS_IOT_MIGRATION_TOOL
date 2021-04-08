#!/bin/bash

echo "# cleaning policies.json to policies_new.json"

# \n   ""
sed  's/\\n/ /g' policies.json > temp.json
# \"   ""
sed  -i 's/\\\"/\"/g' temp.json
# "{   {
sed  -i 's/\"{/{/g' temp.json
# }"   }
sed  -i 's/}\s*\"/}/g' temp.json
jq '.policies' temp.json > policies_new.json
rm temp.json



