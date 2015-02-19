	#!/bin/bash

tail -1 temp.csv > mail.txt
tail -1 motion.csv >> mail.txt
mail -s "subject" taylorhogan@me.com  < mail.txt

