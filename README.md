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

# IMPORTANT NOTES
Pas kalian baru buka projectnya, pasti gabisa langsung di run karena beberapa custom assetnya ga kebaca (ini juga w gatau kenapa padahal di Development Asset udah ke assign ke Assets.xcassets nya).

Jadi, caranya adalah kalian ke xcodeproj Manlingua2 nya, terus di bagian **Targets** itu yg Manlingua2 sama Manlingua2Tests, pilih bagian **Signing & Capabilities**, dan assign itu ke nama kalian. Setelah itu kalian coba run lagi, dan harusnya bakal ada warning (yg segitiga warna kuning) kek disuruh update konfigurasinya gitu lah pokoknya, w lupa kalimatnya gimana, intinya kek 'Update to recommended' atau sejenisnya lah. Nah, kalian klik aja itu warning terus fix warningnya dari situ, terutama yg bagian **Asset Catalog**, terus save changes.

