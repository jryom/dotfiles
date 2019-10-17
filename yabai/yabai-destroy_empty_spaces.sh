yabai -m query --spaces --display | \
     jq -re 'map(select(."native-fullscreen" == 0)) | length > 1' \
     && bash <(yabai -m query --spaces | \
          jq -re 'map(select(."windows" == [] and ."focused" == 0)) | .[]| "yabai -m space \(.index|@sh) --destroy"')
