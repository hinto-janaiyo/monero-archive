# WIP monero-archive
This is collection of scripts for archiving Monero related stuff. Requires GNU/Linux.

Scripts for scraping sites hosted by individual community members are not created on purpose.

**Other than PGP keys, there is no content in this repo, only scripts to speed up the process of obtaining it.**

**Copyright of the content's original creator(s) & contributor(s) apply.**

If you'd like something added/removed from the list, please contact me: `hinto.janaiyo@protonmail.com`  
Or submit a pull request. If adding a GitHub repo, please add alphabetically.

TODO
* create git clone/pull script
	- recursive
	- all submodules
* (github pr/issue scrape script?)
* create media scrape script
	- all metadata, thumbnails, etc
* create torrent
	- sign+hash afterwards

## Build
1. To build an archive, first clone this repo: `git clone https://github.com/hinto-janaiyo/monero-archive`
2. Goto the `build` directory: `cd monero-archive/build`
3. Run the appropriate script, for example if you want all GitHub repos: `./github.sh`

A folder within `build/` will be created named something like `monero-archive-a18f610`. This reflects the current git commit you're on.
Inside that folder you'll find `github`, `youtube`, `libera_logs` or all 3, depending on what you built.

## Requirements
| Script         | Requires             |
|----------------|----------------------|
| github.sh      | `git`                |
| youtube.sh     | `git` & `youtube-dl` |
| libera_logs.sh | `git` & `wget`       |

## Warnings
1. `github.sh` will RECURSIVELY clone repos. This means the **entire** history of the Git tree will be cloned along with any submodules.
2. `youtube.sh` may get your IP temporarily banned from Youtube.
3. `libera_logs.sh` will download the **entire** history of **all** channels. Empty logs will be removed. It sources from [`https://libera.monerologs.net`](https://libera.monerologs.net) which I'm not sure who operates so be gentle :D

## Content List
* [GitHub](#GitHub)
* [Youtube](#Youtube)
* [Libera Logs](#Libera Logs)
* [PGP Keys](#PGP-Keys)
* [Extra](#Extra)

## GitHub
* AsBenDoge
	- p2pool-report
* busyboredom
	- acceptxmr
	- ministo
* cake-tech
	- cake_wallet
	- monero
	- monerocom-charts
* cirocosta
	- go-monero
	- monero-exporter
* comit-network
	- xmr-btc-swap
	- rendezvous-server
	- maia
	- malax
	- comit.network
	- xtra-productivity
	- monero-rs
	- monero
* CryptoGrampy
	- HotShop
	- android-termux-monero-node
* dalek-cryptography
	- bulletproofs
* erciccione
	- haveno-site
	- monero-site
	- haveno
* farcaster-project
	- farcaster-node
	- farcaster-core
	- workflows
	- parallel-offer-taker
	- containers
	- client-side-validation
	- secp256kfun
	- meetings
	- RFCs
* feather-wallet
	- feather
	- feather-docs
* fluffypony
	- monero
* Gingeropolous
	- from0k2bp
	- monero
	- moneriote
* haveno-dex
	- haveno-site
	- haveno
	- haveno-ts
	- monero
	- haveno-ui-poc
	- haveno-ui
	- haveno-meta
	- haveno-design
* hinto-janaiyo
	- monero-bash
	- monero-gpg
	- monero-utils
* hyahatiph-labs
	- bitmonero
	- monero-gui
	- mass
	- infosec
	- hlc
	- monero-site
	- hlq
	- xmrbc-rs
* hyc
	- RandomX
	- RandomxAudits
* i2p-zero
	- i2p-zero
* j-berman
	- monero
	- node-cryptonote-util
	- nodejs-pool
* jeffro256
	- monero
* jtgrassie
	- monero-pool
	- monero-powpy
	- pyrx
	- monero
	- xmrpc
* kayabaNerve
	- monero
	- monero-secret-sharing
	- cryptonote-library
* LMDB
	- lmdb
	- bitmonero
* luigi1111
	- xmr.llcoins.net
* MAGICGrants
	- website
	- Monero-Fund
* m2049r
	- xmrwallet
	- monero
	- monerujo-site
	- monerujo-hw
* mj-xmr
	- SolOptXMR
	- monero-mj
* monerica-project
	- monerica
* monerodocs
	- md
	- mkdocs-material
* monero-ecosystem
	- monero-cpp
	- monero-javascript
	- monero-java
	- PiNode-XMR
	- monero-rpc-rs
	- monero-ecosystem.github.io
	- monero-python
	- monero-translations
	- telegram-monerotipbot
	- meta
	- go-monero-rpc-client
	- outreach-docs
	- monero_health
	- monero_scripts
	- MoneroTipper
	- monero-GUI-guide
	- csharp-monero-rpc-client
	- monerobox
	- moneriote-python
	- python-monerorpc
	- Stellumo
	- XMR-ETA
	- dont-buy-monero-sticker
	- vanity-monero
	- promo-video
	- qml-xmr
	- Monero-Crypto-Lock
	- pymonero
* moneroexamples
	- onion-monero-blockchain-explorer
	- openmonero
	- private-testnet
	- transactions-report
* moneroguides
	- 0x01-Mining-Monero-with-P2Pool-Windows-Quick-start-guide
	- 1x01-importing-public-keys-and-verifying-hashes
	- 1x02-setting-up-your-own-node
	- moneroguides-assets
	- getmonero.org
	- 2x01-an-introduction-to-mining
	- 2x02-setting-up-your-rig
	- 0x02-turning-your-node-into-a-service
	- 1x03-using-moneo-as-money
	- 0x03-Mining-Monero-P2Pool-quick-start-guide
	- moneroguides.org
	- 1x04-using-monero-with-enhanced-privacy
* monero-integrations
	- monerowhmcs
	- moneroodoo
	- monerowp
	- .github
	- monerophp
	- monerops
	- monerocart3
	- moneroshopify
	- moneromagento
	- monerocart
	- Payment-Plugin-Template
	- monerothirty
	- moneronodejs
	- monerogo
* moneromooo-monero
	- bitmonero
	- monero-site
	- monero-update
	- monero-wallet-generator
* moneropay
	- moneropay
	- moneropay-docs
	- go-monero
* monero-project
	- monero
	- monero-gui
	- monero-site
	- gitian.sigs
	- supercop
	- mininero
	- research-lab
	- kovri
	- unbound
	- monero-downloads
	- kastelo
	- kovri-docs
	- kovri-site
	- monero-forum
	- xmr-seeder
	- urs
* monero-rs
	- monero-lws
	- base58m
	- monero-rs
	- .github
	- monero-epee-bin-serde
	- base58-monero
	- workflows
* mymonero
	- mymonero-libapp-js
	- mymonero-libapp-cpp
	- mymonero-core-cpp
	- monero-core-custom
	- monero
	- mymonero-mobile
	- mymonero-utils
	- mymonero-app-js
	- mymonero-core-js
	- mymonero-android-js
	- mymonero-enterprise-site
	- mymonero-web-js
	- mymonero-app-ios
	- .github
	- mymonero-app-ios
	- mymonero-app-site
	- mymonero-app-android
	- mymonero-rpc-server
	- mymonero-exchange-js
	- mymonero-fraud-monitor
* nahuhh
	- android-termux-monero-node
* noot
	- atomic-swap
* ph4r05
	- monero
	- trezor-firmware
	- monero-serialize
* plowsof
	- listen_for_zmq
	- monero-gui
	- flipstarter-waas-wip
	- monero-fund-watch
	- monero-site
	- post-libera-metting-logs
	- userguide-drafts
	- monerodevs.org
	- funding-xmr-radio
	- make-gui-tarball
	- scrape-moneroj-net-charts
	- validate-sources
	- check-monero-bounties-subad
	- start-multi-rpcs
	- xmr-get-fee-estimate-test
	- flipstarter-alerts
* pokkst
	- monero-decoy-scanner
* Rucknium
	- OSPEAD
* rbrunner7
	- monero
	- monero-core
* rottenstonks
	- revuo-weekly
* SamsungGalaxyPlayer
	- monero-presentations
	- konferenco-2020
	- monero-meetup-kit
* SarangNoether
	- monero
	- monero-site
	- skunkworks
	- talks
	- qesa
	- zero-to-monero
* SChernykh
	- monero
	- monero-gui
	- p2pool
	- xmrig
	- vanity_xmr_cuda
	- RandomX
	- RandomX_CUDA
* selsta
	- monero
	- monero-gui
	- monero-site
* serai-dex
	- serai
	- substrate
* serhack
	- monero
	- exploremonero-i18n
	- getmonero.dev
	- monero-lws
	- monerobook
* sethforprivacy
	- simple-monerod-docker
	- p2pool-docker
	- simple-monero-wallet-rpc-docker
	- simple-monero-docker
* Snipa22
	- nodejs-pool
	- xmr-node-proxy
	- go-xmr-lib
* stoffu
	- monero-core
	- monero
* tari-project
	- tari
	- tari-launchpad
	- tari_utilities
	- tari-scanner
	- test-faucet
	- tari-explorer
	- tari-collectibles
	- tari-web-extension
	- wasm-examples
	- tari-crypto
	- tari-dot-com
	- wallet-android
	- wallet-ios
	- rfcs
	- randomx-rs
	- bulletproofs-plus
	- bulletproofs
	- lmdb-rs
	- pubsub
	- broadcast_channel
	- blockchain-explorer-api
	- meta
	- block-explorer-frontend
	- rpgp
	- desktop-client
	- tari-common-ios
	- action-buildlibs
	- miningcore
	- tari-data-analysis
	- tor-hash-password
	- tari-website
	- wallet-grpc-client
	- deploy
	- tari-config-generator
* tevador
	- mx25519
	- RandomX
	- polyseed
	- randomx-sniffer
	- bitmonero
	- RandomJS
* TheCharlatan
	- monero
* tobtoht
	- monero
* UkoeHB
	- monero
	- Monero-RCT-report
	- Seraphis
* vdo
	- xmr.sh
	- www.xmr.sh
* vtnerd
	- monero-lws
	- monero
	- motrix
* WeebDataHoarder
	- p2pool-log
	- p2pool-nsis
	- p2pool-compose
* woodser
	- haveno
	- haveno-ts
	- monero
	- monero-deposit-scanner
	- monerowebwallet.com
* xiphon
	- monero
	- monero-gui
	- monero-android-miner
* xmrig
	- xmrig
	- base
	- xmrig-proxy
	- xmrig-deps
	- xmrig-cuda
	- xmrig-amd
	- xmrig-workers
	- xmrig-nonces-heatmap
	- xmrig-config
* xrv0
	- monero-supply

## Libera Logs
- #monero [`https://libera.monerologs.net/monero/20210608`](https://libera.monerologs.net/monero/20210608)
- #monero-community [`https://libera.monerologs.net/monero-community/20210609`](https://libera.monerologs.net/monero-community/20210609)
- #monero-dev [`https://libera.monerologs.net/monero-dev/20210608`](https://libera.monerologs.net/monero-dev/20210608)
- #monero-gui [`https://libera.monerologs.net/monero-gui/20210610`](https://libera.monerologs.net/monero-gui/20210610)
- #monero-pow [`https://libera.monerologs.net/monero-pow/20210608`](https://libera.monerologs.net/monero-pow/20210608)
- #monero-research-lab [`https://libera.monerologs.net/monero-research-lab/20210609`](https://libera.monerologs.net/monero-research-lab/20210609)
- #monero-site [`https://libera.monerologs.net/monero-site/20210615`](https://libera.monerologs.net/monero-site/20210615)

## Youtube
- Monero Talk [`https://www.youtube.com/c/MoneroTalk`](https://www.youtube.com/c/MoneroTalk)
- Monero Space [`https://www.youtube.com/c/MoneroSpaceWorkgroup`](https://www.youtube.com/c/MoneroSpaceWorkgroup)
- Monero Community Workgroup [`https://www.youtube.com/c/MoneroCommunityWorkgroup`](https://www.youtube.com/c/MoneroCommunityWorkgroup)
- Sweetwater Digital Asset Consulting [`https://www.youtube.com/c/SweetwaterDAC`](https://www.youtube.com/c/SweetwaterDAC)
- Monero [`https://www.youtube.com/channel/UCnjUpT9gGxyQ_lud7uKoTCg`](https://www.youtube.com/channel/UCnjUpT9gGxyQ_lud7uKoTCg)
- Monero Guides [`https://www.youtube.com/c/MoneroGuides`](https://www.youtube.com/c/MoneroGuides)

## PGP Keys
PGP keys are already collected and found in this repo in `pgp/`.

Sources:
* https://github.com/monero-project/monero/tree/master/utils/gpg_keys
* https://github.com/monero-project/gitian.sigs/tree/master/gitian-pubkeys

Any other keys are found in the individual's GitHub or website.

* anon `9F60DD36E5DC287223B0D4F7D3857C17AA7F968B`
* anonimal `12186272CD48E2539E2DD29B66A76ECF914409F1`
* atroxes `603B7C6BE9128A7002904B3F212A57EFC35ADBA7`
* binaryfate `81AC591FE9C4B65C5806AFC3F0AF4D462A0BDF92`
* cirocosta `9CD11313857859CC0FADE93B6B93177A62D01DB8`
* dikdust `7A499ECDBF8A30A8B3B8A190144D6E86DA9446B8`
* erciccione `E9F5351F1FED34EEA9C04B07762AF8C608E56CDF`
* escapethe3RA `BCE15F74D18112824899608AFD103120DC7BCC36`
* fluffypony `BDA6BD7042B721C467A9759D7455C5E3C0CDCEB9`
* guzzi `334E923C8DEF43E0EAEC48125CDC3E3A58A315B2`
* halver `1F8FEC985EAB2D7D24E7EEEB1953D77F287A3ACB`
* hinto-janaiyo `21958EE945980282FCB849C8D7483F6CA27D1B1D`
* hyc `9404619A9BA7CB5F799E0EA1FD2A70B44AB11BA7`
* iDunk `B182B10F1104A923020580400F1715596D812FD8`
* jaquee `D21E9CC12F51C4FEA9E052FF384E52B09F45DC39`
* jeffro256 `2EAAC930E6B90CB019C01E806F79797A6E392442`
* jonathancross `9386A2FB2DA9D0D31FAF0818C0C076132FFA7695`
* jtgrassie `C469CCCBAC0556FA0B0A9A75DE8ED755616565BB`
* kenshi84 `1E97C2BBE10D8A80489D305B085D092F1F43D51A`
* luigi1111 `8777AB8F778EE89487A2F8E7F4ACA0183641E010`
* mikezackles `26019A83CF6B632EC8CEAC5E401DDF645791A4D1`
* mishi_choudhary `580BF0E4D0196BB9E834B00D40296A28A27AE0EC`
* mj-xmr `B33091EB10A272B9DD5702FAC101BF94093451E0`
* MoneroArbo `0C0FA204EB7516220E08964B18AD08024295A9AE`
* MoneroArbo_v0.17.1.6 `2D0480170CCDD7BE61295FA0905EED61A76476E8`
* MoneroArbo_v0.17.2.3 `82DD2788AB778E7B4B948CFAACC397EE2D19D307`
* monerobull `7E0EB1C10C8A70BE4AD5C6CB9374062D6094E98F`
* moneromooo `48B08161FBDADFE393ADFC3E686F07454D6CEFC3`
* nahuhh `E2CEC3A69683CFCE32DD2F206B0644AEAC099310`
* nanoakron `D9586EEE344B5FC5A6A4D664346A337AA2EA8B57`
* oranjuice `518A50B18F8A2591FD6D376471C5AF46CCB28124`
* plowsof4096 `A867E7A4F6EE73A2B52BBA378E5C9ED2D55C9955`
* plowsof `DC8BCF0C5083F2030782803E4E8A912D40ED052C`
* rbrunner7 `9F8C0A7E9CD85B2C522B9F306A251D571F7F7BC3`
* refactor-ring `BF0E269A13B13032E4C68A31022C486D73F8225B`
* sarang `6A9D3D7BA4F95DC3EE1AF95EDD4C6DDE9360DDED`
* SChernykh `1FCAAB4D3DC3310D16CBD508C47F82B54DA87ADF`
* scoobybejesus `8F4E3A12C0D30F6A29E83C890D9C693FDC7CF9EA`
* selsta `29A5B386FB943B684FBF7BBD2EA0A99A8B07AE5E`
* sethforprivacy `55EEC39E2EFDD3740F94DFFB6B9791C6214D1E57`
* sethsimmons `55EEC39E2EFDD3740F94DFFB6B9791C6214D1E57`
* snipa22 `487277A8BD0A209C16B700F3C64552D877C32479`
* snipa `487277A8BD0A209C16B700F3C64552D877C32479`
* stefanomarty `A7A9CF8A997C74ADE69BFEBCDB9F801EF4DE2230`
* stoffu `849FC42DA8067D7B9B00F24A41DAB8343A9EC012`
* tewinget `25A8ECF72457E05EC6F0FB3958131A160789E630`
* thecharlatan `A8FC55F3B04BA3146F3492E79303B33A305224CB`
* TheCharlatan `A8FC55F3B04BA3146F3492E79303B33A305224CB`
* tomerkon `62BEC70D7806EECB51262A0A96A7713F394EEAAB`
* twoofswords `6578DF51E4C3CF8E4C9A88934A03B23B4054D42C`
* vdo `80E49C9C44FADCE2764ACF50F10AD1E5C08EA7E2`
* warptangent `9EADA88DCB29BF0F7F480DA60E490BEBFBE4E92D`
* wowario `61E3EA3F7D2A6C2796F189FA24DCBE762DE9C111`
* xiphon `8F77964DBBA324198D78A603BD72EC6C3F187C67`
* xmrig `9AC4CEA8E66E35A5C7CDDC1B446A53638BE94409`

## Extra
WIP
- binaries + hashes + sig
