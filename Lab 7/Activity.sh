#!/bin/bash
# Shell Script for Monitoring Memory Usage
# Usage: ./memory_monitor.sh
# Modify the script to log memory usage every 10 seconds in a file (memory_log.txt) with timestamps.
# It also sends an alert email if memory usage is below 200MB.

# Define the email address for alerts
ALERT_EMAIL="your-email@example.com"

# Function to display current memory usage
display_memory_usage() {
    echo "Current Memory Usage:"
    free -h
    echo ""
}

# Function to check memory usage and send an alert if less than 200MB
check_memory_and_alert() {
    # Get the available memory in MB using free command and extract the value
    available_memory=$(free -m | grep -i "mem" | awk '{print $7}')
    
    # If available memory is less than 200MB, send an email alert
    if [ "$available_memory" -lt 200 ]; then
        echo "Alert: Available memory is less than 200MB!" | mail -s "Memory Alert: Low Available Memory" "$ALERT_EMAIL"
        echo "Memory Alert: Low Available Memory! An email has been sent to $ALERT_EMAIL."
    fi
}

# Function to monitor memory usage every 10 seconds and log it with timestamps
monitor_memory_usage() {
    echo "Monitoring memory usage every 10 seconds. Press [CTRL+C] to stop."
    
    while true; do
        # Get the current timestamp
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        
        # Log memory usage to memory_log.txt with timestamp
        memory_usage=$(free -m | grep -i "mem" | awk '{print $3}')
        
        # Log memory usage with timestamp in the file
        echo "$timestamp - Memory Usage: $memory_usage MB" >> memory_log.txt
        
        # Check memory and send alert if necessary
        check_memory_and_alert
        
        # Wait for 10 seconds before the next log entry
        sleep 10
    done
}

# Displaying options to the user
echo "Dynamic Memory Monitor"
echo "1. Display current memory usage"
echo "2. Monitor memory usage in real-time"
echo "3. Exit"

# Loop until the user chooses to exit
while true; do
    read -p "Select an option (1-3): " option
    case $option in
    1) # Display current memory usage
        display_memory_usage
        ;;
    2) # Monitor memory usage in real-time and log to file
        monitor_memory_usage
        ;;
    3) # Exit the script
        echo "Exiting the memory monitor. Goodbye!"
        exit 0
        ;;
    *) # Invalid option
        echo "Invalid option. Please select 1-3."
        ;;
    esac
    echo "" # Print a newline for better readability
done
