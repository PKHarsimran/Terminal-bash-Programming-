System Audit Script

A bash script to perform a quick system audit and save the information in a file located at $HOME/research/sys_info.txt.
Requirements

    Bash shell should be installed on the system.
    ip and find commands should be available.

Usage

To run the script, simply make it executable with chmod +x script.sh and then run ./script.sh. The script will not run as the root user to ensure security. If the script is run as root, it will display a message "Please do not run this script as root" and exit.
What the script does

    Checks if the user running the script is root. If yes, it displays a message "Please do not run this script as root" and exits.

    Creates the directory $HOME/research if it does not already exist.

    Clears the file sys_info.txt located at $HOME/research/sys_info.txt if it already exists.

    Writes the following system information to the file sys_info.txt:
        Date and time the script was run.
        Machine type information.
        Uname information.
        IP information.
        Hostname.
        DNS servers.
        Memory information.
        CPU information.
        SUID files on the system.
        Top 10 processes sorted by memory usage.

Note

    The script uses the find command with the -perm /4000 option to search for SUID files on the system. This option specifies that the file should have the set-user-ID bit set.
    The script uses the awk command to format the output of the ps command to show only the first, second, third, fourth and eleventh columns, which are the user, pid, %cpu, %mem and command of a process, respectively.
