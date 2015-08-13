i18n = require 'i18next-client'

resources =
  dev:
     translation:
         page:
             header: 'Palvelukartta-upotuksen esikatselu XX'
             subtitle: 'Muokkaa upotuksen asetuksia ja esikatsele näkymää.'
  fi:
     translation:
         page:
             header: 'Palvelukartta-upotuksen esikatselu'
  en:
     translation:
         page:
             header: 'Servicemap: embedding preview'

module.exports =
    t: i18n.t
    init: (cb) => i18n.init {resStore: resources, lng: 'dev'}, => cb()
