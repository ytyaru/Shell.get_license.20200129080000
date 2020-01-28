#!/usr/bin/env bash
set -Ceu
Run() { # $1: license_id
	local HERE="$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd -P)"
	local ID_DIR="$(cd "$HERE"; cd "../../res/github/ids"; pwd -P)"
	local JSON_DIR="$(cd "$HERE"; cd "../../res/github/json"; pwd -P)"
	local license_json=
	Initialize() {
		Install() {
			IsInstalledJq() { [ -n "$(dpkg -l jq | cut -d " " -f 3 | grep jq)" ]; }
			InstallJq() { sudo apt install -y jq; }
			IsInstalledJq || InstallJq
		}; Install;
		[ -f "${ID_DIR}/all.txt" ] || "$HERE/lib/get_license_files.sh"
	}
	ValidArgs() {
		Error() {
			local ERR_CODE=$BASH_LINENO; [ 0 -eq $ERR_CODE ] && ERR_CODE=255;
			local args=("$@"); local msg="$(IFS=$'\n'; echo -e "${args[*]}")"
			echo -e 'ERROR '"$ERR_CODE"': '"$msg" 1>&2
			exit $ERR_CODE
		}
		ShowIdPath() { echo 'Please refer to the following file for the list of license ID.'"\n${ID_DIR}/all.txt"; }
		[ 0 -eq $# ] && { Error 'Specify the license ID as the first argument.' "$(ShowIdPath)"; }
		license_json="$(find "$JSON_DIR" -iname "$1.json")"
		[ -n "$license_json" ] && { return; }
		license_json="$(find "$JSON_DIR" -iname "$1*.json")"
		[ -z "$license_json" ] && { Error 'Invalid license ID.: '"$1" "$(ShowIdPath)"; }
		local find_one="$(echo "$license_json" | grep "$1.json")"
		ShowHitCandicates() { echo "$(echo -e "$license_json" | xargs -I@ basename @ | sed 's/^/  /g' | sed 's/\.json//g')"; }
		# If you don't add '||:;' at the end, it will stop. Is it a bug in the if statement?
		[ 1 -ne $(echo -e "$license_json" | wc -l) ] && { Error 'The license_id entered could not be uniquely identified. : '"${1}" 'The hit candidates are as follows.' "$(ShowHitCandicates)" "$(ShowIdPath)"; } || :;
	}
	Initialize
	ValidArgs "$@"
	local id="$(basename "$license_json" | sed 's/\.json//g')"
	OutputLicenseFile() { cat "$license_json" | jq -r '.body' > "./LICENSE-${1}.txt"; }
	OutputLicenseFile "$id"
}
Run "$@"
