COUNT=$(swaync-client --count)
PERCENTAGE=$(echo $COUNT | grep -q '^0$' && echo '0' || echo '100')
CLASS=$(echo $PERCENTAGE | grep -q '100' && echo 'highlight' || echo '')

echo "{\"count\": $COUNT, \"percentage\": $PERCENTAGE, \"class\": \"$CLASS\"}"
