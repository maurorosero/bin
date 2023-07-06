#!/usr/bin/env bash
#title           : setvideo-1600x900.sh
#description     : Set resolution to second monitor
#author		     : MRP/mrp - Mauro Rosero P.
#personal email  : mauro.rosero@gmail.com
#notes           :
#==============================================================================
#
#==============================================================================

### DISPLAY USB OPTIONS

usb_name='MRP-SECURE'

display_menu () {
  usb_media_list=`ls -l /dev/disk/by-path/*usb*  | grep -v "part" | awk '{print $NF}'|  awk -F "/" '{print $NF}' | sort`
  usb_media_count=`echo "${usb_media_list}" | wc -l`
  dev=/dev/

  clear
  echo "Save your personal secure information to USB Media"
  echo "====================================================="
  echo " Select USB Disk to Format and Save:"
  echo "${usb_media_list}" | nl | while read line
  do
    echo "  ${line}"
  done
  echo -e "  0\tExit"
}

get_usbdevice() {
  usb_device=`echo "${usb_media_list}" | head -n $option | tail -1`
}

format_usbdevice() {
  mount | grep -s "${usb_device}" > /dev/null
  if [ "$?" == "0" ]
  then
    echo "OK"
    partition=$(mount | grep ${usb_device} | cut -d\  -f1)
    umount ${partition}
  fi
  ### format usb disk
  sudo mkfs.vfat -F 32 -I -n ${usb_name} ${dev}${usb_device}1
}

copy_securebox() {
  mount | grep ${usb_name}
  if [ "$?" == "0" ]
  then
    partition=$(mount | grep ${usb_device} | cut -d\  -f1)
    umount ${partition}
  fi
  sudo mkdir -p /tmp/${usb_name}
  sudo chown ${USER}:${USER} /tmp/${usb_name}
  sudo chmod 700 /tmp/${usb_name}
  sudo mount -o rw,user ${dev}/${usb_device} /tmp/${usb_name}
  sudo cp -rf ~/Vaults/Secure/ /tmp/${usb_name}/secure/
}

### MAIN BLOCK PROGRAM
option=1
while [[ ${option} != 0 ]]
do
  display_menu
  read -p "Get option: " option
  if [[ ${option} -gt 0 && ${option} -le ${usb_media_count} ]]
  then
    get_usbdevice
    format_usbdevice
    #copy_securebox
    option=0
  fi
done
