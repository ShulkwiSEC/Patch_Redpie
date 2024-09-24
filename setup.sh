#!/bin/bash 

# Create a wrapper script to run main.py as root
echo '#!/bin/bash\nexec python3 /home/redpie/app/Redpie/src/main.py "$@"' > /app/redpie.sh

# Make the wrapper executable
chmod +x /app/redpie.sh

# Change ownership of the wrapper script to root
chown root:root /app/redpie.sh

# Set the SUID bit to allow execution as root
chmod u+s /app/redpie.sh

# Ensure flag.txt is not readable by any user except root
chmod 600 /root/flag.txt