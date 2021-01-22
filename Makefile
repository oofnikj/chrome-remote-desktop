.PHONY: install disable-crd mirror

CRD_DIR=/opt/google/chrome-remote-desktop
SYSTEMD_USER_UNIT_DIR=/usr/lib/systemd/user


install: disable-crd
	@test `id -u` -ne 0 || { echo "This step SHOULD NOT be run as root."; exit 1; }
	@echo "* Patching chrome-remote-desktop script..."
	sudo install -b --suffix .orig chrome-remote-desktop ${CRD_DIR}/chrome-remote-desktop
	sudo install -m755 crd-mirror ${CRD_DIR}/crd-mirror
	@echo "Installing service..."
	sudo install -m644 crd-mirror.service ${SYSTEMD_USER_UNIT_DIR}/crd-mirror.service
	systemctl --user daemon-reload
	systemctl --user enable crd-mirror.service
	systemctl --user start crd-mirror.service
	@echo "* CRD mirror mode enabled"

disable-crd:
	@test `id -u` -ne 0 || { echo "This step SHOULD NOT be run as root."; exit 1; }
	@echo "* Disabling Chrome Remote Desktop service..."
	systemctl --user stop chrome-remote-desktop.service || true
	systemctl --user disable chrome-remote-desktop.service || true
	sudo systemctl stop chrome-remote-desktop.service || true
	sudo systemctl disable chrome-remote-desktop.service || true

uninstall:
	@test `id -u` -ne 0 || { echo "This step SHOULD NOT be run as root."; exit 1; }
	@echo "* Uninstalling files..."
	sudo mv ${CRD_DIR}/chrome-remote-desktop.orig ${CRD_DIR}/chrome-remote-desktop
	sudo rm -f ${CRD_DIR}/crd-mirror
	sudo rm -f ${SYSTEMD_USER_UNIT_DIR}/crd-mirror.service
	@echo "* Restoring services..."
	sudo systemctl daemon-reload
	sudo systemctl enable chrome-remote-desktop.service || true
	sudo systemctl start chrome-remote-desktop.service || true
	systemctl --user stop crd-mirror.service || true
	systemctl --user disable crd-mirror.service || true
	systemctl --user enable chrome-remote-desktop.service || true
	systemctl --user start chrome-remote-desktop.service || true