# Transfomers

### Requirements : Xcode 10.x
### Installation & Run

**First:** Open terminal

(Optional) Install cocoapods in your mac if not installed.
```sh
$ sudo gem install cocoapods
```
**Second:** go to folder ../Aequilibrium/Transformers/ 

**Third:** Install pod dependecies which required to run Transformers
```sh
$ pod install
```
**Fourth:** Open Transformer.xcworkspace in Xcode 10.x

**Fifth:** Select device(attached) or simulator from top left corner of the Xcode

**Sixth:** Press command+r or run it from play button located at top left corner of the Xcode

## Assumption!

>The document provided by you was up to mark. In particular, the war part in between “ The Decepticons and The Autobots “ was described very well. 
> By reading the document thoroughly, I prepared a note of functionality and challenges on a paper. 
> MVVM, that's the architecture I decide to follow to develop this app. Source code consists of a model called Transformer which iterates abilities of it. View-models like TeamViewDataSource, ResultDataSource iterates functionality of business logic that includes begin a war, calculate winning team. All the view-models holds the data and supplies it to respective controllers. Controllers holds the views tightly to display the data on required screens. API class named "APIServiceClient", provide the data to view-models. 