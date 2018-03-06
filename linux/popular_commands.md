### View all available HDD's/partitions

```bash
sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
```

This command will show you somthing similar to this:
```
NAME   FSTYPE   SIZE MOUNTPOINT LABEL
sda           111.8G            
├─sda1 swap     121M [SWAP]     
└─sda2 ext4   111.7G /          
sdb             2.7T            
└─sdb1 ext4     2.7T            xtreme
sdc             3.7T            
└─sdc1 ext4     3.7T            titan
```

You can also use:
```bash
sudo fdisk -l
```

The result will be similar to this:
```
Disk /dev/sda: 160.0 GB, 160041885696 bytes
...

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *          63      208844      104391   83  Linux
/dev/sda2          208845     2313359     1052257+  82  Linux swap / Solaris
/dev/sda3         2313360   312576704   155131672+  83  Linux
```

### Format (USB) drive
1. Determine drive label you want to format (eg. using `lsblk`)
2. _Optional_: you can erase drive content with:
    ```bash
    sudo dd if=/dev/zero of=/dev/sdb bs=4k && sync
    ````
    Replace __/dev/sdb__ with you corresponding device. This will take some time. It may pretend to stuck - just be patient.
3. Make new partition table in the device `sudo fdisk /dev/sdb`. Then press letter `o` to create a new empty DOS partition table.
4. Make a new partition. 
    * Press letter `n` to add a new partition. You will be prompted for the size of the partition. Making a primary partition when prompted, if you are not sure.
    * Then press letter `w` to write table to disk and exit.
5. Format your new partition.
    * See what is your new partition with a command lsblk
    * Issue the command below to format the new volume to ext4 filesystem:
    ```bash
    sudo mkfs.vfat /dev/_your_partition_name_
    ```
    * If you want FAT32 use this command:
    ```bash
    mkdosfs -F 32 -I /dev/_your_partition_name_
    ```
### Update alternatives
    ```
    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.9 100    --slave /usr/bin/clang++ clang++ /usr/bin/clang++-3.9
    ```