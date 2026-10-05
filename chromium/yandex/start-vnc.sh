#!/bin/sh
set -eu

export HOME=/home/jelenoid
export USER=jelenoid
export DISPLAY=:${SE_DISPLAY_NUM:-99}
export XAUTHORITY="${HOME}/.Xauthority"
export YANDEX_BIN="${YANDEX_BIN:-/usr/local/bin/google-chrome}"
export YANDEXDRIVER_BIN="${YANDEXDRIVER_BIN:-/opt/yandexdriver/yandexdriver}"
export CDP_PROXY_DEBUGGER_BASE="${CDP_PROXY_DEBUGGER_BASE:-127.0.0.1:9222}"

cd "${HOME}"
mkdir -p "${HOME}/.vnc"

VNC_PASSWORD="${SE_VNC_PASSWORD:-selenoid}"
x11vnc -storepasswd "${VNC_PASSWORD}" "${HOME}/.vncpasswd" >/dev/null 2>&1 || true

# -listen tcp обязателен: Xvfb/Xserver 21.x (bookworm) по умолчанию НЕ слушает
# TCP, а рекордер подключается по X11 TCP (порт 6000+DISPLAY_NUM).
# -ac отключает access control, поэтому foreign-клиенту не нужен xauth.
Xvfb "${DISPLAY}" -screen 0 "${SE_SCREEN_WIDTH:-1920}x${SE_SCREEN_HEIGHT:-1080}x${SE_SCREEN_DEPTH:-24}" -ac -listen tcp -dpi 96 +extension RANDR >/dev/null 2>&1 &
# Ждём готовность дисплея: openbox/x11vnc, стартовавшие до того, как Xvfb
# откроет слушающий сокет, молча умирают (stderr в /dev/null) - и VNC-порт
# не поднимается. Ожидание ограничено, чтобы повисший Xvfb не заблокировал
# старт контейнера навсегда.
i=0
until xdpyinfo -display "${DISPLAY}" >/dev/null 2>&1; do
    i=$((i + 1))
    if [ "$i" -ge 25 ]; then
        echo "WARNING: display ${DISPLAY} is not ready after 5s, continuing" >&2
        break
    fi
    sleep 0.2
done
openbox >/dev/null 2>&1 &
if [ "${ENABLE_VNC:-false}" = "true" ]; then
    x11vnc -display "${DISPLAY}" -forever -shared -rfbport "${SE_VNC_PORT:-5900}" -rfbauth "${HOME}/.vncpasswd" >/dev/null 2>&1 &
fi

"${YANDEXDRIVER_BIN}" --port=4445 --allowed-origins=* >/dev/null 2>&1 &
/usr/local/bin/cdp-proxy >/dev/null 2>&1 &
exec /usr/local/bin/wd-proxy
