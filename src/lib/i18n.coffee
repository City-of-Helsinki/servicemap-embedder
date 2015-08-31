i18n = require 'i18next-client'

resources =
    fi:
       translation:
           page:
               header: 'Palvelukartta-upotuksen esikatselu'
               subtitle: 'Muokkaa upotuksen asetuksia ja esikatsele näkymää.'
               summary_header: 'Upotuksen kohde on'
               summary:
                   single_unit: 'yksittäinen toimipiste'
                   service_units: 'toimipisteet, jotka tarjoavat nimettyjä palveluita'
                   address: 'katuosoite'
                   division: 'alue tai kaupunginosa'
                   other: 'maantieteellinen rajaus'
           title:
               language: 'Upotuksen kieli'
               level: 'Palvelut'
               bbox: 'Kartan rajaus'
               minHeight: 'Upotuksen korkeus'
               width: 'Upotuksen leveys'
               height: 'Upotuksen korkeus'
               map: 'Taustakartta'
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
               width:
                   full:
                       label: 'Automaattinen leveys'
                       help: 'Upotus täyttää leveyssuunnassa elementin, johon se on sijoitettu. Tässä esikatselussa upotus on sijoitettu katkoviivalla merkittyyn vakiolevyiseen elementtiin.'
                   custom:
                       label: 'Valittu leveys'
                       help: 'Upotuksen leveys on määritelty pikseleissä.'
                height:
                    ratio:
                        label: 'Suhteellinen korkeus'
                        help: 'Upotuksen korkeuden suhde leveyteen on määritelty'
                    fixed:
                        label: 'Absoluuttinen korkeus'
                        help: 'Upotuksen korkeus on määritelty pikseleissä'
                map:
                    servicemap:
                        label: 'Palvelukartta'
                        help: 'Palvelukartan oma karttapohja'
                    ortographic:
                        label: 'Ilmakuva'
                        help: 'Ortografinen ilmakuva'
                    accessible_map:
                        label: 'Suurikontrastinen'
                        help: 'Suurikontrastinen kartta'

    en:
       translation:
           page:
               header: 'Preview of an embedded Service map'
               subtitle: 'Modify the embedding parameters and preview the embedded view.'
               summary_header: 'The embedded view is defined by'
               summary:
                   single_unit: 'a single unit'
                   service_units: 'all units providing the specified service(s)'
                   address: 'a street address'
                   division: 'a neighborhood or division'
                   other: 'a geographic bound'
           title:
               language: 'The language of the embedded view'
               level: 'Service points'
               bbox: 'Map boundaries'
               minHeight: 'View height'
               width: 'View width'
           parameters:
               language:
                   fi:
                      label: 'Finnish'
                      help: 'The service points\' information and map labeling is in Finnish.'
                   sv:
                      label: 'Swedish'
                      help: 'The service points\' information and map labeling is in Swedish.'
                   en:
                      label: 'English'
                      help: 'The service points\' information is in English. The map labeling is in Finnish.'
               level:
                   all:
                       label: 'All service points'
                       help: 'All service points are shown on the map. If the map boundary is too large, it will delay the displaying of the embedded view and reduce its clarity.'
                   common:
                       label: 'The most common public services for citizens.'
                       help: 'The map will show the most commonly requested service points from the point of view of a citizens everyday life. '
                   none:
                       label: 'No service points'
                       help: 'The map is displayed without any service points.'
               bbox:
                   true:
                       label: 'Custom map bounds'
                       help: 'The map will span at least the area that was visible on the service map, when the embedding preview was first opened.'
                   false:
                       label: 'Automatic map bounds'
                       help: 'The map bounds adjust automatically to the desired service points.'
                width:
                    full:
                        label: 'Automatic width'
                        help: 'The embedded element fills the horizontal space of its containing element.'
                    custom:
                        label: 'Custom width'
                        help: 'The embedded element has the specified width.'

module.exports =
    t: (path...) => i18n.t path.join('.')
    init: (lang, cb) => i18n.init {resStore: resources, lng: lang}, => cb lang
