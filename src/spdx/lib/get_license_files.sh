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
	local ID_DIR="$(cd "$HERE"; cd "../../../res/spdx/ids"; pwd -P)"
	local JSON_DIR="$(cd "$HERE"; cd "../../../res/spdx/json"; pwd -P)"
	local TXT_DIR="$(cd "$HERE"; cd "../../../res/spdx/txt"; pwd -P)"
	echo -e "$HERE\n$ID_DIR\n$JSON_DIR\n$TXT_DIR"
	GetIds() {
		IsExistLicensesJson() { [ -f "$ID_DIR/all.json" ]; }
		GetLicensesJson() { curl -L https://raw.githubusercontent.com/spdx/license-list-data/master/json/licenses.json > "$ID_DIR/all.json"; sleep 1; }
		IsExistLicensesText() { [ -f "$ID_DIR/all.txt" ]; }
		GetLicensesText() { cat "$ID_DIR/all.json" | jq -r '.licenses[].licenseId' > "$ID_DIR/all.txt"; }
		IsExistLicensesJson || GetLicensesJson
		IsExistLicensesText || GetLicensesText
	}
	GetLicenses() {
		IsExistLicenseJson() { [ -f "${JSON_DIR}/${1}.json" ]; }
		GetLicenseUrl() { cat "$ID_DIR/all.json" | jq -r '.licenses[] | select(.licenseId=="'"$1"'") | .detailsUrl'; }
		GetLicenseJson() { curl -L "$(GetLicenseUrl "$1")" > "$JSON_DIR/$1.json"; sleep 1; }
		echo -e "$(cat "$ID_DIR/all.txt")" | ( while read id; do
			echo "$id: "$(GetLicenseUrl "$id")""
			IsExistLicenseJson "$id" || GetLicenseJson "$id"
		done; )
	}
	GetIds
	GetLicenses
}
Run "$@"
