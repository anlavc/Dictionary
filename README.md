
# Dictionary App

Showing the nouns, adjectives, verbs and adverbs of English words and also listing the synonyms of the word.


## Features of the application

- Finding the noun, adjective, verb and adverb forms of the searched word.
- Warning if word is entered incorrectly
- Warning when null value is searched
- Saving the last 5 calls. Click to drill down
- If the searched value repeats, it will not be added to the list.
- Invoked synonyms score points are sorted from largest to smallest and show 5 values.
- Listening to the pronunciation of the word.
- Light and Dark mode

  
## Used technologies

-  Mvvm Design Pattern
- Url Session
- UIKit
- TableView
- CollectionView
- Xib
- User Default
- Extensions
- Json

  
## API Kullanımı


#### GET

```http
  GET https://api.dictionaryapi.dev/v2/entries/en/{word}
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `word`      | `string` | **Gerekli**. Çağrılacak öğenin anahtar değeri |

Return values

     word, phonetic,partOfSpeech,definition,example
     meanings,text,audio,sourceURL,sourceUrls,phonetics


#### GET - Synonym

```http
  GET /api.datamuse.com/words?rel_syn={word}
```

| Parametre | Tip     | Açıklama                       |
| :-------- | :------- | :-------------------------------- |
| `word`      | `string` | **Gerekli**. Çağrılacak öğenin anahtar değeri |

Return values

     word, score
## Ekran Görüntüleri

<img src="https://user-images.githubusercontent.com/50744756/219684758-fd8a748b-5f05-44b7-9064-6134cb18ecd6.PNG" width="300" height="568"><img src="https://user-images.githubusercontent.com/50744756/219684764-1f6ec23a-b45b-42bc-9af6-c510a6e2fd9a.PNG" width="300" height="568"><img src="https://user-images.githubusercontent.com/50744756/219684768-6a9a7da7-b29e-4a2f-9439-dba87ca8af3a.PNG" width="300" height="568"><img src="https://user-images.githubusercontent.com/50744756/219684774-25581582-dbd8-4f95-a578-cefe815350e4.PNG" width="300" height="568"><img src="https://user-images.githubusercontent.com/50744756/219684738-0b7d197e-53ba-40bd-8de5-25853c154828.PNG" width="300" height="568">
<img src="https://user-images.githubusercontent.com/50744756/219684738-0b7d197e-53ba-40bd-8de5-25853c154828.PNG" width="300" height="568">
<img src="https://user-images.githubusercontent.com/50744756/219684753-1c8364b3-3c48-485c-bbe3-e400abfa691f.PNG" width="300" height="568">
## Demo

Demoya gif veya bağlantı ekleyin

  
