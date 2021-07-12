import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void openAbout(context, String type) {
  LicenseRegistry.reset();

  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(<String>['Xshop mobile'], '''
	
  Copyright 2016 xshop.com. All rights reserved.
	
  
	
     * Redistributions of source code must retain the above copyright
	
  notice, this list of conditions and the following disclaimer.
	
   
	
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS''');
  });
  showAboutDialog(
    context: context,
    applicationIcon:
        Image(height: 50, width: 50, image: AssetImage('images/icon/icon.png')),
    applicationName: 'Xshop',
    applicationVersion: '0.0.1',
    applicationLegalese: '©2021 xshop.com',
    children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text('xshop $type login type'))
    ],
  );
}
