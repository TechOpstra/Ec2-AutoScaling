# To increase the cpu utilization using a script
# Update and install stress-ng
sudo apt update -y
sudo apt install stress-ng -y

# Run a CPU stress test for 10 minutes (600 seconds)
paste below content in the cputest.sh

#!/bin/bash
stress-ng --cpu 4 --timeout 600s

echo "CPU stress test completed!"
