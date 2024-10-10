# Project Building 101
## Install Homebrew
Pertama-tama, make sure kalian udah install homebrew dulu. Cara installnya bisa ke websitenya langsung brew.sh atau liat di youtube cara install homebrew. Tapi, langkah awalnya adalah di terminal, kalian run command ini:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Setelah itu, seinget w lanjut2 aja.

## Install xcodegen

Kedua, kalian bisa install xcodegen. Cara installnya adalah dengan pake Homebrew yang udah diinstall diawal-awal. Cara installnya adalah dengan menjalankan command ini di Terminal.
```
brew install xcodegen
```

## Clone project
Kalo udah install xcodegen, kalian bisa langsung clone reponya dari terminal. Set direktori dari terminal ke folder yg mau dipake buat save projectnya, terus di clone projectnya.
```
git clone https://github.com/MProductionMacro/Manlingua2.git
```

## Build project
Setelah install xcodegen, kalian bisa langsung ke direktori Manlinguanya.
```
cd Manlingua2
```

Setelah sudah di direktori Manlingua, kalian bisa langsung build projectnya dengan menjalankan command ini di terminal.
```
make generate_project
```
Selamat, projectnya sudah ke build. Happy coding 😁

