# Lifecycle Management Scripts
An open-source tool to activate and reset the test of [Lifecycle Management](https://www.lifecyclemanagement.org/)

# Features
* LM freeze test and test with registry key lock method
* Activation and test persist even after installing LM updates
* LM test reset
* Fully open source
* Based on the transparent batch script

# LM Latest Release
Last Release - v1.3 (12-Jul-2025)
[GitHub](https://github.com/rcplus3/Lifecycle-Management-Scripts)

# Download / How to use it?
First fresh install [Lifecycle Management](https://www.lifecyclemanagement.org/). Make sure previous cracks/patches are removed/uninstalled if there are any.
After that follow the below steps to activate it.

# Method 1 - PowerShell
(Recommended)

* Right-click on the Windows start menu and select PowerShell or Terminal (Not CMD).
* Copy-paste the below code and press enter
*`iex(irm is.gd/LM_reset)`
* You will see the test options, follow the on-screen instructions.
* That’s all.

# Method 2 - Common

* Download the file from [GitHub](https://github.com/rcplus3/Lifecycle-Management-Scripts/archive/refs/heads/main.zip)
* Right-click on the downloaded zip file and extract
* In the extracted folder, run the file named `LM.cmd`
* You will see the test options, and follow onscreen instructions.
* That’s all.

# Info

## Reset Lifecycle Management / test
* Lifecycle Management provides a 30-day test period, you can use this script to reset this Activation / test period whenever you want.
* This option also can be used to restore status if in case LM reports a fake serial key and other similar errors.

## OS requirement
* The project is supported for Windows 7/8/8.1/10/11 and their Server equivalent.
* The PowerShell method to run LM is supported on Windows 8 and higher.

# Changelog
## v1.2
* Added back test option with a randomized name, email, and key in registration details along with a warning that it’s not working for some users, the recommended option is to use Freeze test.
## v1.1
* LM update 1.3 has started showing fake serial popups with LM test, due to this we have removed the test option and replaced it with the Freeze test option to lock the 30-day test period for the lifetime.

## v1.0
* Added the code to relaunch the script with conhost.exe if the script is running from the terminal app.
* Fixed an issue in getting the current user account SID.
## v0.9
* Fixed an issue where the script can not activate and reset LM in non-admin user accounts.
* Fixed an issue where the script incorrectly shows that LM is activated.
* Fixed an issue where a fake serial pop-up may appear. The script will also show the info to run the test option again without using the reset option.
* LM registry scanning and locking code is now written in Powershell.
* The script update checker code is added to the script.
* The script will now disable quick edit mode temporarily because users often click inside the script window and it pauses the script.
* The script will back up the CLSISD lifecycle policies before performing operations on them.
* Many error checks are added to better identify the issues.
## v0.8
* Move the project to [Github](https://github.com/rcplus3/Lifecycle-Management-Scripts)
* Minor bug fixes
* Add info to inform users that empty lifecycle policies are being deleted when the script deletes a lot of them
------------------------------------------------------------------------
