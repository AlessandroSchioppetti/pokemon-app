# pokemon-app
pokemon list detail app

Struttura:

All'avvio dell'app faccio un controllo: viene cercato in memoria se sono già presenti i dati. in caso affermativo, con un breve delay lascio vedere comunque lo splashController per poi atterrare sulla home. in caso contrario effettuto le chiamate di rete visualizzando un hud di caricamento nella splash e salvo tutto in locale per cosi avere a disposizione per tutti gli avvi seguenti i dati senza la necessità di avere una connessione. in questo frangente di tempo vengono scaricati i dati da API. parso e salvo in un file json locale solo i dati che poi vado effettivamente a visualizzare. salvo anche tutte le immagini dei pokemon in cartelle relative. per ogni pokemon ho salvato un'immagine di "profilo" di dimensione piu grnade e 4 immagini piu piccole che sono il fronte/retro default e dell'evoluzione pokemon (gallery)

Nella home (lista pokemon) e nel dettaglio pokemon, tutti i dati vengono letti dal json locale, mentre le immagini dai percorsi delle cartelle relative.
ho strutturato i percorsi nel seguente modo: 

applicationSupport/Images/{pokemonName}/ProfileImage/...
applicationSupport/Images/{pokemonName}/GalleryImage/...

Come da istruzioni ho cercato di non usare librerie esterne, fatta eccezion di due file di classi che sono rispettivamente: BaseViewModel, ViewModel.

*per problemi con xcode sono riuscito a testare l'app solo da simulatore e non su device fisico.

