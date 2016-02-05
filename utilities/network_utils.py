from __future__ import unicode_literals
# from psutil import Popen
from subprocess import Popen, PIPE
from re import findall


def get_ping_loss_rate(machine_name_or_ip, count=4, seconds_timeout=2):
    ping_cmd = ["ping", "-c", count, "-W", seconds_timeout, machine_name_or_ip]

    # Ensure that all parameters of command are utf8
    for x in xrange(len(ping_cmd)):
        ping_cmd[x] = str(ping_cmd[x]).encode('utf8')

    # Ping command
    ping_proc = Popen(ping_cmd, stdout=PIPE, stderr=PIPE)

    # Wait for execution complete
    outpt, error = ping_proc.communicate()

    # Regex match packet loss % string in output
    ping_loss_rate = findall(r"(\d+)% packet loss,", outpt)

    if len(ping_loss_rate) > 1:
        print("Something went wrong, regex returned more than one match.")
        for x in xrange(len(ping_loss_rate)):
            ping_loss_rate[x] = int(ping_loss_rate[x])
        return ping_loss_rate

    return int(ping_loss_rate[0])
