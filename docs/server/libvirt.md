### packages

- libvirt-clients
- libvirt-daemon-system
- libvirt-daemon
- libvirt-glib-1.0-0
- libvirt0
- python3-libvirt
- virt-viewer
- virtinst

### files

### commands

    # use host dns
    $ virsh net-edit default
    <network>
      <name>default</name>
      <uuid>...</uuid>
      <forward mode='bridge' />
      <bridge name='virbr0' />
    </network>
