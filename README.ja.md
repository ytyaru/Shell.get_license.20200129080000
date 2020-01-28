[en](./README.md)

# get_license

　LICENSEファイルを作成する。

# 特徴

* 現在のディレクトリに`LICENSE`ファイルを作成する
* WebからライセンスIDとコンテンツを取得する

# 開発環境

* <time datetime="2020-01-28T07:15:46+0900">2020-01-28</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release
* jq 1.5-1

```sh
$ uname -a
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l GNU/Linux
```

# インストール

```sh
sudo apt install -y jq
git clone https://github.com/ytyaru/Shell.license_getter.20200129080000
```

# 使い方

```sh
cd Shell.license_getter.20200129080000/src
./get_license mit
```

# 注意

* ライセンスファイル名はどうべきか？
    * `LICENSE`, `LICENSE.txt`, `LICENSE.md`, `LICENSE-APACHE`, `LICENSE-Apache.2.0`, `LICENSE-Apache.2.0.txt`, `LICENSE-apache.2.0.txt`
* 複数のライセンス（デュアルライセンス）がある場合の対処方法は？
    * [`SPDX license expression`](https://spdx.org/spdx-specification-21-web-version#h.jxpfx0ykyb60)
        * `MIT OR Apache-2.0`
        * `AGPL-3.0-or-later AND Apache-2.0`
* ライセンスファイルの著作権を置き換えない
    * github
        * フォーマットされていない
            * 各ライセンスファイルに対応する置換処理を実装する必要がある
    * spdx
        * text: フォーマットされていない
        * template: 形式が難解すぎる
* 標準ライセンスヘッダーを追加
    *追加するかどうか
        * ライセンスごとに異なる
    * どこに？
        * ライセンスファイル？
        * `README.md`？
        * ソースコードファイル？
* 別の名前で同じ名前が出力される
    *例1：
        * `GPL-3.0`、` GPL-3.0-only`は同じである
        * 次のように個別のファイルとして出力されてしまう
            * `LICENSE-GPL-3.0.txt`
            * `LICENSE-GPL-3.0-only.txt`
    *例2：
        * `GPL-3.0 +`、 `GPL-3.0-or-later`は同じである
        * 次のように個別のファイルとして出力されてしまう
            * `LICENSE-GPL-3.0+.txt`
            * `LICENSE-GPL-3.0-or-later.txt`

# 著者

　ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# ライセンス

　このソフトウェアはCC0ライセンスである。

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)

