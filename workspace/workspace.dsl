workspace {

    model {
        fagsystemDemo = softwareSystem "Fagsystem Demo" "Lar godkjente brukere se og endre aksjeinformasjon" {
            fagWeb = container "Web Applikasjon" "Lar godkjente brukere logge inn, se og gjøre endringer hvis de har rettighetene til dette" "Next JS"
            fagWallet = container "Web Wallet" "Lar brukeren vise og generere stealth addresser"
            fagListeMedBrukere = container "Liste med godkjente brukere" "Forhåndsgodkjente brukere som kan få tilgang til systemet på vegne av selskap X" 
            fagBrokAPI = container "BRØK API" "Lar godkjente fagsystem interaktere med BRØK" "Node"
            
            
            fagWeb -> fagWallet "Henter nøkkel for å kunne lese og skrive informasjon til BRØK for autentisert person"
            fagWeb -> fagListeMedBrukere "Sjekker om brukeren er godkjent"
            fagWeb -> fagBrokAPI "Les og skriv informasjon til BRØK"
        }
        
        brok = softwareSystem "BRØK" "Publisering og tilgjengeligjøring av aksjeeierinformasjon" {
            brokAksjebok = container "Test "
        }
        
        navnetjener = softwareSystem "Navnetjener" "Lagrer personinformasjonen om hvem som eier aksjene på BRØK" {
            navnAPI = container "Applikasjons API" "Tilgjengeligjør oppslag på person basert på wallet addresse via JSON"
            navnDb = container "Database" "Lagrer persondata"
            navnPersondata = container "Persondata" "Internmodul i BR for oppslag av navn"
            
            navnAPI -> navnPersondata "Henter persondata fra fødselsnr når ny eier registreres"
            navnAPI -> navnDb "Lagrer og henter person informasjon"
        }
        
        
        styreleder = person "Styreleder" "Fysisk person" "tag1"
        aksjeeier = person "Aksjeeier" "Juridisk eller fysisk person"
        brAdmin = person "BR Admin"

        styreleder -> fagWeb "Administrerer aksjeselskapet"
        aksjeeier -> fagWeb "Ser og bruker sine aksjer"
        brAdmin -> fagListeMedBrukere "Gir tilgang for utvalgte personer til systemet"
        
        fagBrokAPI -> brokAksjebok "Henter og skriver aksjeinformasjon"
        fagBrokAPI -> navnAPI "Slår opp navnet på en aksjeeier med wallet addressen som nøkkel"
    }

    views {
        systemContext fagsystemDemo "Oversikt" {
            include *
            autoLayout
        }
        
        container fagsystemDemo "Fagsystem" {
            include *
            autoLayout
        }
        
        container navnetjener "Navnetjener" {
            include *
            autoLayout
        }
            
        theme default
    }
    
}