import 'dart:html';

import 'package:states/states.dart';

import 'src/application.dart';
import 'src/const/Action.dart';
import 'src/const/State.dart';
import 'src/components/base/page.dart';
import 'src/components/navigator.dart';

void main() {

  DivElement root = querySelector('#root');
  Navigator navigator = new Navigator( root );
  Application application = new Application( navigator );

  States pagesStates = new States();
  pagesStates.add( State.INITIAL );

  pagesStates.add( State.PAGE_INDEX );
  pagesStates.add( State.PAGE_LOGIN );
  pagesStates.add( State.PAGE_GALLERY );
  pagesStates.add( State.PAGE_SIGNOUT );

  pagesStates.action( State.INITIAL, State.PAGE_INDEX, Action.INITIALIZE, (StateAction action) => application.goToIndexPage() );
  pagesStates.action( State.PAGE_INDEX, State.PAGE_LOGIN, Action.INDEX_PAGE_BUTTON_LOGIN_CLICKED, (StateAction action) => application.goToLoginPage() );
  pagesStates.action( State.PAGE_LOGIN, State.PAGE_INDEX, Action.LOGIN_PAGE_BUTTON_INDEX_CLICKED, (StateAction action) => application.goToIndexPage() );
  pagesStates.action( State.PAGE_LOGIN, State.PAGE_GALLERY, Action.LOGIN_PAGE_BUTTON_GALLERY_CLICKED, (StateAction action) => application.goToGalleryPage() );

  pagesStates.action(
      State.PAGE_GALLERY,
      State.PAGE_INDEX,
      Action.GALLERY_PAGE_BUTTON_INDEX_CLICKED, (StateAction action) => application.goToIndexPage() );

  pagesStates.action(
      State.PAGE_GALLERY,
      State.PAGE_SIGNOUT,
      Action.GALLERY_PAGE_BUTTON_EXIT_CLICKED, (StateAction action) => application.goToSignoutPage() );

  pagesStates.action(
      State.PAGE_SIGNOUT,
      State.PAGE_INDEX,
      Action.SIGNOUT_PAGE_TIMER_EXPIRED, (StateAction action) => application.goToIndexPage() );

  root.addEventListener(Page.EVENT_ACTION, (e) => pagesStates.perform((e as CustomEvent).detail));

  pagesStates.perform( Action.INITIALIZE );
}


