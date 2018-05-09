# PasswordChecker
BASH Script to check password Expiry and trigger a JAMF Helper notice to warn the user of upcoming password expiry

Variables have been created to customise the messages, AD Domain, Logo Path, Button Labels, and the Default Button

### Customisation

Variable `PWPolicy` is your password Expiry in # of Days (-1) Change this variable as needed. Set to 60 Days for my environment
Variable `PWNotify` is the number of days prior to expiry to begin prompting the end user about their password expiry.
Variable `Domain` is for the DSCL lookup. Make sure this is your AD Domain as it will fail to lookup with incorrect data where
Variable `logoPath` is the LOCAL path to a logo file to display on the popup
Variable `windowTitle` Changes the title of both popups
Variable `windowHeading` Changes the Heading text in the first popup
Variable `windowText` Changes the text displayed in the first popup
Variable `sureHeading` changes the heading on the Ignore Confirmation popup
Variable `sureText` changes the text displayed on the Ignore Confirmation popup
Variable `Button1Label` changes the label on the "Ignore" button
Variable `Button2Label` changes the label on the "Change Now" button


## Screenshots
![an example of the popup](https://github.com/DJStuey/PasswordChecker/blob/master/Sample1.png "Sample Window")
![an example of the popup](https://github.com/DJStuey/PasswordChecker/blob/master/Sample2.png "Confirm Ignore Window")
