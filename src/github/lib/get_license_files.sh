#!/usr/bin/env bash
set -Ceu
Run() {
	Install() {
		IsInstalledJq() { [ -n "$(dpkg -l jq | cut -d " " -f 3 | grep jq)" ]; }
		InstallJq() { sudo apt install -y jq; }
		IsInstalledJq || InstallJq
	}
	Install
	local HERE="$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd -P)"
	local ID_DIR="$(cd "$HERE"; cd "../../../res/github/ids"; pwd -P)"
	local JSON_DIR="$(cd "$HERE"; cd "../../../res/github/json"; pwd -P)"
	local TXT_DIR="$(cd "$HERE"; cd "../../../res/github/txt"; pwd -P)"
	local TPL_ITM_DIR="$(cd "$HERE"; cd "../../../res/github/template_items"; pwd -P)"
	DeleteCommentAndBlankLine() { grep -v -e '^\s*#' -e '^\s*$' "$1"; }
	AllIdPath() { echo "$ID_DIR/all.txt"; }
	AllIds() { DeleteCommentAndBlankLine "$(AllIdPath)"; }
	IsExistJson() { [ -f "${JSON_DIR}/${1}.json" ]; }
	IsExistText() { [ -f "${TXT_DIR}/${1}.txt" ]; }
	IsExistTemplateItems() { [ -f "${TPL_ITM_DIR}/${1}.txt" ]; }
	GetLicenseJson() { curl https://api.github.com/licenses/${1} > "${JSON_DIR}/${1}.json"; sleep 2; }
	GetLicenseText() { cat "${JSON_DIR}/${1}.json" | jq -r '.body' > "${TXT_DIR}/${1}.txt"; }
#	echo -e "$HERE\n$ID_DIR\n$JSON_DIR\n$TXT_DIR"
	echo -e "$(AllIds)" | ( while read id; do
#		echo "$id"
		IsExistJson "$id" || GetLicenseJson "$id"
		IsExistText "$id" || GetLicenseText "$id"
	done; )
}
Run "$@"
