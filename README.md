# pokemon-app
pokemon list detail app

Struttura:

Per far si che l'app possa funzionare anche nell'eventualità che non ci fosse connessione, all'avvio dell'app faccio un controllo: viene cercato in memoria se sono già presenti i dati dei pokemon (precedentemente scaricati). in caso affermativo, con un breve delay lascio comunque vedere lo splashController per poi atterrare sulla home. in caso contrario (quindi non ho nessun dato in memoria relativo ai pokemon) effettuto le chiamate di rete in sequenza, visualizzando un hud di caricamento nella splash in quel frangente di tempo, e salvo poi tutto in locale per cosi avere a disposizione per tutti gli avvi seguenti i dati senza la necessità di avere una connessione. una volta scaricati i dati, parso e salvo in un file json locale solo i dati che poi vado effettivamente a visualizzare. salvo anche tutte le immagini dei pokemon in cartelle relative su dispositivo locale. per ogni pokemon ho salvato un'immagine di "profilo" di dimensione piu grande, e 4 immagini piu piccole che sono il fronte/retro default dell'evoluzione pokemon (gallery)

Nella home (lista pokemon) e nel dettaglio pokemon, tutti i dati vengono letti dal json locale, mentre le immagini dai rispettivi percorsi delle cartelle.
ho strutturato i percorsi nel seguente modo: 

applicationSupport/Images/{pokemonName}/ProfileImage/...
applicationSupport/Images/{pokemonName}/GalleryImage/...

fatta eccezion di due file di classi che sono rispettivamente "BaseViewModel" e "ViewModel" il codice è stato interamente scritto come da istruzioni senza l'uso e l'appoggio a librerie esterne.

