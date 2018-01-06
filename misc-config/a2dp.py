#! /usr/bin/env python3
"""
Workaround for bug: https://bugs.launchpad.net/ubuntu/+source/indicator-sound/+bug/1577197
Run it with python3.5 or higher after pairing/connecting the bluetooth stereo headphone.
Only works with bluez5.
See `a2dp.py -h` for info.
https://gist.github.com/pylover/d68be364adac5f946887b85e6ed6e7ae
Vahid Mardani
"""

__version__ = '0.1.0'

import sys
import re
import asyncio
import subprocess as sb
import argparse


HEX_PATTERN = '[0-9A-F]'
BYTE_HEX_PATTERN = '%s{2}' % HEX_PATTERN


class SubprocessError(Exception):
    pass


class BluetoothctlProtocol(asyncio.SubprocessProtocol):
    def __init__(self, exit_future, echo=True):
        self.exit_future = exit_future
        self.transport = None
        self.output = None
        self.echo = echo

    def listen_output(self):
        self.output = ''

    def not_listen_output(self):
        self.output = None

    def pipe_data_received(self, fd, raw):
        d = raw.decode()
        if self.echo:
            print(d, end='')

        if self.output is not None:
            self.output += d

    def process_exited(self):
        self.exit_future.set_result(True)

    def connection_made(self, transport):
        self.transport = transport
        print('Connection MADE')

    async def send_command(self, c):
        stdin_transport = self.transport.get_pipe_transport(0)
        stdin_transport._pipe.write(('%s\n' % c).encode())

    async def search_in_output(self, expression, fail_expression=None):
        if self.output is None:
            return None

        for l in self.output.splitlines():
            if fail_expression and re.search(fail_expression, l, re.IGNORECASE):
                raise SubprocessError('Expression "%s" failed with fail pattern: "%s"' % (l, fail_expression))

            if re.search(expression, l, re.IGNORECASE):
                return True

    async def send_and_wait(self, cmd, wait_expression, fail_expression='fail'):
        try:
            self.listen_output()
            await self.send_command(cmd)
            while not await self.search_in_output(wait_expression.lower(), fail_expression=fail_expression):
                await asyncio.sleep(.3)
        finally:
            self.not_listen_output()

    async def disconnect(self, mac):
        await self.send_and_wait('disconnect %s' % ':'.join(mac), 'Successful disconnected')

    async def connect(self, mac):
        await self.send_and_wait('connect %s' % ':'.join(mac), 'Connection successful')

    async def trust(self, mac):
        await self.send_and_wait('trust %s' % ':'.join(mac), 'trust succeeded')

    async def quit(self):
        await self.send_command('quit')

    async def list_devices(self):
        result = []
        try:
            self.listen_output()
            await self.send_command('devices')
            await asyncio.sleep(1)
            for l in self.output.splitlines():
                m = re.match('^Device\s(?P<mac>[:A-F0-9]{17})\s(?P<name>.*)', l)
                if m:
                    result.append(m.groups())
            return result
        finally:
            self.not_listen_output()

    async def list_controllers(self):
        result = []
        try:
            self.listen_output()
            await self.send_command('list')
            await asyncio.sleep(1)
            for l in self.output.splitlines():
                m = re.match('^Controller\s(?P<mac>[:A-F0-9]{17})\s(?P<name>.*)', l)
                if m:
                    result.append(m.groups())
            return result
        finally:
            self.not_listen_output()

    async def select_device(self):
        devices = await self.list_devices()
        count = len(devices)

        if count < 1:
            raise SubprocessError('There is no connected device.')
        elif count == 1:
            return devices[0]

        for i, d in enumerate(devices):
            print('%d. %s %s' % (i+1, d[0], d[1]))
        print('Select device[1]:')
        selected = input()
        return devices[int(selected) - 1]


async def execute_command(cmd):
    p = await asyncio.create_subprocess_shell(cmd, stdout=sb.PIPE, stderr=sb.PIPE)
    stdout, stderr = await p.communicate()
    stdout, stderr = \
        stdout.decode() if stdout is not None else '', \
        stderr.decode() if stderr is not None else ''
    if p.returncode != 0 or stderr.strip() != '':
        raise SubprocessError('Command: %s failed with status: %s\nstderr: %s' % (cmd, p.returncode, stderr))
    return stdout


async def execute_find(cmd, pattern):
    stdout = await execute_command(cmd)
    match = re.search(pattern, stdout)
    if match:
        return match.group()
    return match


async def find_dev_id(mac, tries=12):

    async def fetch():
        return await execute_find(
            'pactl list cards short',
            'bluez_card.%s' % '_'.join(mac))

    result = await fetch()
    while tries > 0 and result is None:
        await asyncio.sleep(.5)
        tries -= 1
        print('Cannot get device id, retrying %d more times.' % (tries+1))
        result = await fetch()
    return result


async def find_sink(mac, tries=12):

    async def fetch():
        return await execute_find(
            'pacmd list-sinks', 'bluez_sink.%s' % '_'.join(mac))

    result = await fetch()
    while tries > 0 and result is None:
        await asyncio.sleep(.5)
        tries -= 1
        print('Cannot find any sink, retrying %d more times.' % (tries+1))
        result = await fetch()
    return result


async def set_profile(device_id, profile='a2dp_sink'):
    return await execute_command('pactl set-card-profile %s %s' % (device_id, profile))


async def set_default_sink(sink):
    return await execute_command('pacmd set-default-sink %s' % sink)


async def main(args):
    mac = args.mac

    exit_future = asyncio.Future()
    transport, protocol = await loop.subprocess_exec(
        lambda: BluetoothctlProtocol(exit_future, echo=args.echo), 'bluetoothctl'
    )

    try:

        if mac is None:
            print('Selecting device:')
            mac, device_name = await protocol.select_device()

        mac = mac.split(':' if ':' in mac else '_')
        print('Device MAC: %s' % ':'.join(mac))

        device_id = await find_dev_id(mac, tries=5)

        if device_id is None:
            await protocol.trust(mac)
            await protocol.connect(mac)

        device_id = await find_dev_id(mac)

        sink = await find_sink(mac)
        if sink is None:
            await set_profile(device_id)
            sink = await find_sink(mac)

        print('Device ID: %s' % device_id)
        print('Sink: %s' % sink)

        print('Turning off audio profile.')
        await set_profile(device_id, profile='off')

        print('Disconnecting the device.')
        await protocol.disconnect(mac)

        print('Connecting againt.')
        await protocol.connect(mac)

        print('Setting A2DP profile')
        device_id = await find_dev_id(mac)
        print('Device ID: %s' % device_id)
        await set_profile(device_id)

        print('Updating default sink')
        await set_default_sink(sink)

    except SubprocessError as ex:
        print(str(ex))
        return 1
    finally:
        print('Exiting bluetoothctl')
        await protocol.quit()
        await exit_future

        # Close the stdout pipe
        transport.close()


if __name__ == '__main__':

    parser = argparse.ArgumentParser(prog=sys.argv[0])
    parser.add_argument('-e', '--echo', action='store_true', default=False)
    parser.add_argument('mac', nargs='?', default=None)
    args = parser.parse_args()

    loop = asyncio.get_event_loop()
    sys.exit(loop.run_until_complete(main(args)))
