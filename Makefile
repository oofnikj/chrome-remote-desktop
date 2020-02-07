.PHONY: install disable-crd mirror

CRD_DIR=/opt/google/chrome-remote-desktop
SYSTEMD_USER_UNIT_DIR=`pkg-config systemd --variable=systemduserunitdir`


install: disable-crd
				@echo "Installing service..."
				install -b --suffix .orig chrome-remote-desktop ${CRD_DIR}/chrome-remote-desktop
				install crd-mirror ${CRD_DIR}/crd-mirror
				install -m644 crd-mirror.service ${CRD_USER_UNIT_DIR}/crd-mirror.service
				@echo "To enable service, run `make mirror`.

disable-crd:
				@echo "Disabling Chrome Remote Desktop service..."
				systemctl stop chrome-remote-desktop.service || true
				systemctl disable chrome-remote-desktop.service || true

mirror:
				@test `id -u` -ne 0 || { echo "don't run this as root."; exit 1; }
				systemctl --user daemon-reload
				systemctl --user enable crd-mirror.service
				systemctl --user start crd-mirror.service
				@echo "CRD mirror mode enabled"