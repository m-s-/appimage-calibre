.PHONY: all clean build pack

CALIBRE_VERSION = 6.3.0
APPIMAGEKIT_VERSION = 12

all: pack

clean:
	rm -fr build/
	rm -fr Calibre-*

build: clean
	mkdir -p build/calibre.AppDir/
	cp calibre.desktop build/calibre.AppDir/
	curl --location -o build/calibre.AppDir/AppRun https://github.com/AppImage/AppImageKit/releases/download/$(APPIMAGEKIT_VERSION)/AppRun-x86_64
	chmod +x build/calibre.AppDir/AppRun
	mkdir -p build/calibre.AppDir/usr/bin/
	cd build/calibre.AppDir/usr/bin/ \
	&& curl -o - https://download.calibre-ebook.com/$(CALIBRE_VERSION)/calibre-$(CALIBRE_VERSION)-x86_64.txz | tar -xJf -
	cp build/calibre.AppDir/usr/bin/resources/content-server/calibre.png build/calibre.AppDir

pack: build
	curl --location -o build/appimagetool https://github.com/AppImage/AppImageKit/releases/download/$(APPIMAGEKIT_VERSION)/appimagetool-x86_64.AppImage
	chmod +x build/appimagetool
	./build/appimagetool build/calibre.AppDir