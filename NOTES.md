* Bug dit "des namespaces"
* NoSchemaF

## Schematron / NVDL

### Le problème 

Le XML-Maven Plugin ne reconnait pas d'implémentations pour Schematron (ISO ou 1.5) ou NVDL.

D'où un joli message :
`No SchemaFactory that implements the schema language 
specified by: {Le NameSpace} could be loaded`

Jing les Valide mais n'est pas JAXP-compliant.

L'API JAXP :

* SchemaFactory (schemaLanguageSupported)
* Schema
  * newValidator() : méthode Validate() et je fais ce que je veux
  * newValidatorHandler() : Implémente ContentHandler ; méthodes classiques
    de SAX, startElement, endDocument, etc...
 

l'API JAXP semble avoir été pensée
pour les grammaires "classiques", c'est à dire

* Constituées d'un ensemble de règles modélisables statiquement


Le xml-maven-plugin

* Par défaut XSD
* A défaut, le schemaLanguage doit être spécifié
* Il crée une SchemaFactory sf pour ce langage
* appelle sf.newSchema.newValidator()

JXVC (de @rosslamont, par ailleurs contributeur sur Jing)
permet d'utiliser la PI `<?xml-model ... >` du document.  
C'est un peu alambiqué ; il crée un Validor, il en appelle la méthode
validate(), parse le document, lit le type et l'emplacement du schema,
puis construit une `SchemaFactory` pour le langage du schema,
mais, à la différence du xml-maven-plugin, crée un `ValidatorHandler` à
partir du `Schema` obtenu.

### Solutions potentielles

* Trouver pour Chaque grammaire un Parser qui implémente les deux méthode ?
* Passer sur Un Plugin "Maison" ?
  * Un plugin JING "Stupide" ?  
    Jing (en particulier la version "Made in ELS" se débrouille bien avec 
    RNG/RNC (bien sur), mais aussi Schematron (toutes versions) et NVDL
  * Récupérer les travaux de rosslamont sur le xml-mdel ?  
    OUI, tout à fait possible. C'est pas bien compliqué mais fastidieux
  * D'ailleurs, il a bossé sur le xs::schemaLocation, aussi ?  
    Yep.
  * Utiliser des plugins dédiés (pour chaque grammaire...) ?
* Si plugin Maison, reprendre le validationSet du xml-maven-plugin
  * OUI => peu de modifs pour les projets ELS
  * NON => Quelquechose de plus souple et de plus adapté (le schemaLanguage Intrinsic, bof bof)
  * 

## Bug dit "des namespaces / attributs xmlns"

https://github.com/mojohaus/xml-maven-plugin/issues/21#issuecomment-379674586

*TODO : à tester avec la nouvelle version de Jing*




