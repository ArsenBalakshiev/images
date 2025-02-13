# Browser Images
[![Build Status](https://github.com/aerokube/images/workflows/build/badge.svg)](https://github.com/aerokube/images/actions?query=workflow%3Abuild)
[![Release](https://img.shields.io/github/release/aerokube/images.svg)](https://github.com/aerokube/images/releases/latest)

**UNMAINTAINED**. Consider https://aerokube.com/moon/latest as alternative.

This repository contains [Docker](http://docker.com/) build files to be used for [Selenoid](http://github.com/aerokube/selenoid) and [Moon](http://github.com/aerokube/moon) projects. You can find prebuilt images [here](https://hub.docker.com/u/selenoid/).

## Download Statistics

### Firefox: [![Firefox Docker Pulls](https://img.shields.io/docker/pulls/selenoid/firefox.svg)](https://hub.docker.com/r/selenoid/firefox)

### Chrome: [![Chrome Docker Pulls](https://img.shields.io/docker/pulls/selenoid/chrome.svg)](https://hub.docker.com/r/selenoid/chrome)

### Opera: [![Opera Docker Pulls](https://img.shields.io/docker/pulls/selenoid/opera.svg)](https://hub.docker.com/r/selenoid/opera)

### Android: [![Android Docker Pulls](https://img.shields.io/docker/pulls/selenoid/android.svg)](https://hub.docker.com/r/selenoid/android)

## Building Images

Moved to: http://aerokube.com/images/latest/#_building_images

## Image information
Moved to: http://aerokube.com/images/latest/#_browser_image_information

Chrome driver source: https://googlechromelabs.github.io/chrome-for-testing/known-good-versions.json

Chrome browser for deb/ubuntu source: https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/

./images.exe chrome -b 133.0.6943.53-1 -d 133.0.6943.53 -t selenoid/vnc_chrome:133

docker build -t selenoid/dev_chrome:133.0.6943.98 --build-arg VERSION=133.0.6943.98-1 ./apt

подложить драйвер

docker build -t selenoid/vnc_chrome:133.0 --build-arg VERSION=133.0.6943.98 --label driver=chromedriver:133.0.6943.98 .

Yandex driver source: https://github.com/yandex/YandexDriver/releases/

Yandex browser for dev/ubuntu source: https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-stable/

./images yandex -b 24.12.4.1055-1 -d 24.12.4.1056 -t selenoid/vnc_yandex:24.12.4

docker build -t selenoid/dev_yandex:24.12.4.1055 --build-arg VERSION=24.12.4.1055-1 ./apt

подложить драйвер

docker build -t selenoid/vnc_yandex:24.12.4 --build-arg VERSION=24.12.4.1055 --label driver=yandexdriver:24.12.4.1056 .

Opera driver source: https://github.com/operasoftware/operachromiumdriver/releases

Opera browser for dev/ubuntu source: https://deb.opera.com/opera-stable/pool/non-free/o/opera-stable/ https://get.opera.com/pub/opera/desktop/

docker build -t selenoid/dev_opera:116.0.5366.127 --build-arg VERSION=116.0.5366.127 ./apt

docker build -t selenoid/vnc_opera:116.0 --build-arg VERSION=116.0.5366.127 --label driver=operadriver:131.0.67787.86 .
