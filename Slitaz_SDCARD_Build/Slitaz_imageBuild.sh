#!/bin/bash
# slitaz Raspi SDCARD image build script
# 11 Haziran 2016 Cumartesi Saat = 22:19
# caylakpenguen http://caylak.truvalinux.org.tr
# Lisans GNU/GPL-v3
#
CWD=$(pwd)
ARSIV=${CWD}/slitaz-rpi-desktop-20140329.tar.bz2
MYTMP=$(mktemp -d)
IMAGE="slitaz-rpi-desktop-20140329.img"
clear
buildimage(){
echo " SD image Hazirlaniyor."
	sleep 1
	dd if=/dev/zero of=${MYTMP}/$IMAGE bs=512 count=$(( 128 * 32 * 236 ))
#mbr bilgilerini yazdir.

echo " mbr bilgilerini yazma islemi yapiliyor."
	dd if=${CWD}/mbr of=${MYTMP}/${IMAGE} bs=512 count=1 conv=notrunc
echo ""
echo ""
echo ""

# images bağlama bölümleri oluşturma.
echo " Sd images Bolumleme islemi yapiliyor.."
echo ""
echo ""
echo ""
	LOOPDEV=$(losetup -f --show ${MYTMP}/$IMAGE)
	mdadm --build --force raspimg --level linear --raid-devices 1 ${LOOPDEV}
	sleep 5
	mkdosfs -I /dev/md/raspimg1
	sleep 1
	mkswap /dev/md/raspimg2
	sleep 1
	mkfs -t ext4 -O ^has_journal -E stride=2,stripe-width=1024 -b 4096 /dev/md/raspimg3
	clear
echo " Slitaz SD images Mount ediliyor."
echo ""
	mkdir -p ${MYTMP}/mnt/boot
	mkdir -p ${MYTMP}/mnt/rootfs
	sleep 5
	mount /dev/md/raspimg1 ${MYTMP}/mnt/boot
	mount /dev/md/raspimg3 ${MYTMP}/mnt/rootfs
echo " Slitaz Raspi Arsivi Decompress ediliyor."
	sleep 1
	tar -xf ${ARSIV} -C ${MYTMP}/
echo ""
echo ""
echo ""
echo " Slitaz Raspi Dosyalari Kopyalaniyor."
	sleep 1
	cp -a ${MYTMP}/slitaz-rpi-desktop-20140329/boot/* ${MYTMP}/mnt/boot/
	cp -a ${MYTMP}/slitaz-rpi-desktop-20140329/rootfs/* ${MYTMP}/mnt/rootfs/
	sleep 5
	sync
echo ""
echo ""
echo ""
}
finalize(){
	cd ${MYTMP}
	umount ${MYTMP}/mnt/boot/
	umount ${MYTMP}/mnt/rootfs/
	sleep 5
	mdadm --stop /dev/md/raspimg
	losetup -d ${LOOPDEV}
echo ""
echo ""
echo ""
echo " SD images Gzip ile Compress Yapiliyor ... ${IMAGE}"
	gzip -c ${MYTMP}/${IMAGE} > ${CWD}/${IMAGE}.gz
echo ""
echo ""
echo ""
echo " Slitaz Sd images Md5 ve Sha1 Hesaplaniyor"
	cd ${CWD}
	sha1sum ${IMAGE}.gz > ${IMAGE}.gz.sha1
	md5sum ${IMAGE}.gz > ${IMAGE}.gz.md5
echo ""
echo ""
echo ""
echo " ${MYTMP} Dizini temizleniyor."
	rm -rf ${MYTMP}
}
#
buildimage
finalize
clear
echo ""
echo ""
echo ""
echo " Slitaz Sd images ${CWD} dizininde ${IMAGE}.gz Hazir."
echo ""
echo ""
echo ""
chown -R caylak:caylak ${CWD}

