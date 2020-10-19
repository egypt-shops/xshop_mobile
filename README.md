# xshop_mobile

A new Flutter project.

## lib SubFolders

- [The theme folder:](./lib/theme)
  just contains a style.dart with my app theme which I access in the main.dart file
- [The services folder:](./lib/services)
  holds some web APIs and native interaction code
- [The components folder:](./lib/components)
  has custom widgets which are used in multiple different screens
- [The models folder:](./lib/models)
  contains files each with a custom class of an object widely used throughout the app
- [The blocs](./lib/blocs) and [blocprovs:](./lib/blocprovs)
  folders are both pretty straightforward, with each holding a file with a BLoC and a BLoC Provider in it respectively.
- [The screens folder:](./lib/screens)
  holds many different folders, each of which corresponds to a different screen of the app.
  Each screen folder holds two things:
  - a primary screen file which serves to organize each component
  - a “components” folder which holds each component in its own separate file.
  Any piece of a screen more complicated then a few widgets should be its own component.
