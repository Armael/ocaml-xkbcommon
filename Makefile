default:
	dune build @install

regen-keysyms: tools/translate_keysyms.ml tools/translate_keysyms_lex.mll
	dune build tools/translate_keysyms.exe
	_build/default/tools/translate_keysyms.exe /usr/include/xkbcommon/xkbcommon-keysyms.h > lib/keysyms.ml

clean:
	rm -rf _build

.PHONY: default clean regen-keysyms
