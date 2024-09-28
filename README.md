# Project Building 101
## Install Homebrew
Pertama-tama, make sure kalian udah install homebrew dulu. Cara installnya bisa ke websitenya langsung brew.sh atau liat di youtube cara install homebrew.

## Install xcodegen

Kedua, kalian bisa install xcodegen. Cara installnya adalah dengan pake Homebrew yang udah diinstall diawal-awal. Cara installnya adalah dengan menjalankan command ini di Terminal.
```
brew install xcodegen
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

Jadi, caranya adalah kalian klik **Manlingua2.xcodeproj -> Targets -> Manlingua2 -> Build Settings -> Deployment -> Development Assets.**

Dari situ kalian bisa liat ada path 'Manlingua2/Assets.xcassets'. Kalian utak atik aja Deployment Assets nya itu, ketik apa aja terserah, pokoknya nanti balik lagi ke 'Manlingua2/Assets.xcassets' lagi, terus build. Seharusnya, setelah itu ada warning (yg segitiga warna kuning). Kalian klik aja terus fix warningnya dari situ.

