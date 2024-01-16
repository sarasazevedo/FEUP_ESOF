import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Profile feature', () {
    final editProfileBtn = find.byValueKey('editProfileBtn');
    final usernameField = find.byValueKey('usernameField');
    final submitBtn = find.byValueKey('submitBtn');
    final usernameText = find.byValueKey('usernameText');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('Navigate the Bottom Bar and edit profile', () async {
      // Given the "Profile" screen
      final profileScreen = find.byValueKey('profileScreen');
      expect(await driver.waitFor(profileScreen), isTrue);

      // When I tap "EditProfilPage"
      await driver.tap(editProfileBtn);

      // And I write "CodeMasters" in "UserName"
      await driver.tap(usernameField);
      await driver.enterText('CodeMasters');

      // And I submit
      await driver.tap(submitBtn);

      // Then I can see "CodeMasters"
      expect(await driver.getText(usernameText), 'CodeMasters');
    });
  });
}
