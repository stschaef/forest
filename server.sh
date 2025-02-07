#!/usr/bin/env sh

# Start the Python server in the background
python3 -m http.server 1313 -d output &
# Save the process ID of the Python server
PYTHON_SERVER_PID=$!

# Run the watch script
./watch.sh

# Kill the Python server after the watch script finishes
kill $PYTHON_SERVER_PID
