i18n = require 'i18next-client'

resources =
  fi:
     translation:
         page:
             header: 'Palvelukartta-upotuksen esikatselu'
             subtitle: 'Muokkaa upotuksen asetuksia ja esikatsele näkymää.'
             summary:
                 single_unit: 'yksittäinen toimipiste'
                 service_units: 'toimipisteet, jotka tarjoavat nimettyjä palveluita'
                 address: 'katuosoite'
                 other: 'maantieteellinen rajaus'
         title:
             language: 'Upotuksen kieli'
             level: 'Palvelut'
             bbox: 'Kartan rajaus'
         parameters:
             language:
                 fi:
                    label: 'suomi'
                    help: 'Toimipisteiden tiedot näytetään suomen kielellä. Taustakartta on suomenkielinen.'
                 sv:
                    label: 'ruotsi'
                    help: 'Toimipisteiden tiedot näytetään ruotsin kielellä. Taustakartta on ruotsinkielinen.'
                 en:
                    label: 'englanti'
                    help: 'Toimipisteiden tiedot näytetään englannin kielellä. Taustakartta on suomenkielinen.'
             level:
                 all:
                     label: 'Kaikki toimipisteet'
                     help: 'Kartalla näytetään kaikki toimipisteet. Jos aluerajaus on liian laaja, upotuksen näyttäminen hidastuu ja sen havainnollisuus vähenee.'
                 common:
                     label: 'Tavallisimmat kaupunkilaisen julkiset palvelut'
                     help: 'Kartalla näytetään yleisimmät kaupunkilaisen arkeen liittyvät toimipisteet: koulut, päiväkodit ja terveyskeskukset.'
                 none:
                     label: 'Ei toimipisteitä'
                     help: 'Kartta näytetään ilman toimipisteitä.'
             bbox:
                 true:
                     label: 'Kiinteä karttarajaus'
                     help: 'Kartan rajaus kattaa vähintään koko alueen, joka palvelukartalla oli näkyvissä kun sieltä siirryttiin esikatselemaan upotusta.'
                 false:
                     label: 'Kartan sisältöön perustuva automaattinen rajaus'
                     help: 'Kartan rajaus mukautuu automaattisesti kartalla näkyviin kohteisiin.'
  en:
     translation:
         page:
             header: 'Servicemap: embedding preview'
         language:
             fi: 'Finnish'
             sv: 'Swedish'
             en: 'English'
  sv:
     translation:
         language:
             fi: 'finska'
             sv: 'svenska'
             en: 'engelska'

module.exports =
    t: (path...) => i18n.t path.join('.')
    init: (lang, cb) => i18n.init {resStore: resources, lng: lang}, => cb lang
