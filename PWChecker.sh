#!/bin/bash
###################### Get current user ########################

CurrentUser=`ls -l /dev/console | cut -d " " -f4`

#set Password Policy
PWPolicy=59
#set Password Notification period
PWNotify=14
#Active Directory Domain
Domain="IGS"

###################### Get Password Expiry ########################
#get Last Password change from DSCL
MSLastPWD=`dscl "/Active Directory/$Domain/All Domains" -read /Users/$CurrentUser | grep -i SMBPasswordLastSet | cut -d ' ' -f 2 | sed q`
#get today's date in Unix time
todayUnix=`date "+%s"`
#Convert Last Password Change date into Unix Time
lastPWDUnix=$((MSLastPWD / 10000000 - 11644473600))
#Calculate Difference between Today's Date and Last Changed Date
diffUnix=$((todayUnix - lastPWDUnix))
#Calculate number of days since last Password change
diffDays=$((diffUnix / 86400 ))
#calculate Number of days until password Expiry
expireDays=$((PWPolicy - diffDays ))
#expireDays=9
#echo $expireDays

###################### User Interface ########################
#Path on local machine where the logo is stored
logoPath="/Users/Shared/.profiles/Crest 4x6.png"
#Title of the Window
windowTitle="Ivanhoe Grammar School - IT Services"
#Heading of the Window
windowHeading="Your Password is due to expire in $expireDays Days"
#Text to display in the Window
windowText="Your password is due to expire in $expireDays Days. Please Change your password now to avoid account access problems. If you aren't sure how to change your password, please come to IT Services for Assistance."

#If user Ignores initial Prompt, they will get a second prompt asking to confirm they wish to ignore it
#Heading of the "Confirmation" Window
sureHeading="Are you sure?"
#Text of the "Confirmation" Window
sureText="You have chosen to Ignore this warning. You will continue to be prompted until your password is changed."

#Label for "Cancel" Button
Button1Label="Ignore"
#Label for "Password Change" Button
Button2Label="Change Now"

#Default Button. 0 is "Ignore", 2 is "Change Now"
DefaultButton=0

###############################################
#Avoid Modifying the script below this line
#
#
###############################################
if [[ $expireDays -le $PWNotify ]]; then
  #Prompt User that their password is due to expire soon
  RESULT=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType utility -title "$windowTitle" -heading "$windowHeading" -alignHeading center -description "$windowText" -alignDescription center -icon "$logoPath" -button1 "$Button1Label" -button2 "$Button2Label" -defaultButton $DefaultButton -cancelButton 0 -lockHUD`
fi

if [[ $RESULT = 0 ]]; then
  #On Ignore, provide user an opportunity to change their mind
  windowHeading=$sureHeading
  windowText=$sureText
  RESULT2=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" -windowType utility -title "$windowTitle" -heading "$windowHeading" -alignHeading center -description "$windowText" -alignDescription center -icon "$logoPath" -button1 "$Button1Label" -button2 "$Button2Label" -defaultButton $DefaultButton -cancelButton 0 -lockHUD`
elif [[ $RESULT = 2 ]]; then
  #open System Preferences -> Accounts preference pane
  sudo -u $CurrentUser open /System/Library/PreferencePanes/Accounts.prefPane
fi

if [[ $RESULT2 = 2 ]]; then
  #open System Preferences -> Accounts preference pane
  sudo -u $CurrentUser open /System/Library/PreferencePanes/Accounts.prefPane
elif [[ $RESULT2 = 0 ]]; then
  #inject log file to JSS
fi
