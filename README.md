[ja](./README.ja.md)

# get_license

Create a LICENSE file.

# Features

* Create a LICENSE file in the current directory
* Get license ID and contents from web

# Requirement

* <time datetime="2020-01-28T07:15:46+0900">2020-01-28</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release
* jq 1.5-1

```sh
$ uname -a
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l GNU/Linux
```

# Installation

```sh
sudo apt install -y jq
git clone https://github.com/ytyaru/Shell.license_getter.20200129080000
```

# Usage

```sh
cd Shell.license_getter.20200129080000/src
./get_license mit
```

# Note

* What should a license file be?
    * `LICENSE`, `LICENSE.txt`, `LICENSE.md`, `LICENSE-APACHE`, `LICENSE-Apache.2.0`, `LICENSE-Apache.2.0.txt`, `LICENSE-apache.2.0.txt`
* What to do when you have multiple licenses (dual licenses)
    * [`SPDX license expression`](https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60)
        * `MIT OR Apache-2.0`
        * `AGPL-3.0-or-later AND Apache-2.0`
* Not replacing copyright in the license file
    * github
        * Not formatted.
            * Replacement processing corresponding to each license file should be implemented.
    * spdx
        * text: Not formatted.
        * template: Format is too esoteric.
* Append standard License Header
    * Add or not ?
        * Different for each license
    * where?
        * LICENSE file ?
        * README.md ?
        * Source code files ?
* The same thing with a different name is output as another thing.
    * examples 1:
        * `GPL-3.0`,` GPL-3.0-only` are the same
        * However, it is output as a separate file as follows.
            * `LICENSE-GPL-3.0.txt`
            * `LICENSE-GPL-3.0-only.txt`
    * examples 2:
        * `GPL-3.0+`,` GPL-3.0-or-later` are the same
        * However, it is output as a separate file as follows.
            * `LICENSE-GPL-3.0+.txt`
            * `LICENSE-GPL-3.0-or-later.txt`

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

