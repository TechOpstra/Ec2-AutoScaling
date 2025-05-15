# To increase the cpu utilization using a script
# Update and install stress-ng
1 sudo apt update -y
2 sudo apt install stress-ng -y

# Run a CPU stress test for 10 minutes (600 seconds)
paste below content in the cputest.sh

1 #!/bin/bash
2 stress-ng --cpu 4 --timeout 600s

3 echo "CPU stress test completed!"
