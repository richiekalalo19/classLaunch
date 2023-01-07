# What is it?

classLaunch is a cross-platform GUI schedule manager, automation tool, and launcher for zoom meetings(or anything launched with links)

## Features

- [x] Supports macOS and Windows *(compatible with python 3.x and Tkinter 8.6+)*
- [x] Separation of Subjects, Classes, and Links:
    - [x] Different instances of a subject name may link to different classes if desired
    - [x] Links are unique to every class
- [x] Customizable:
    - [x] Customizable Grid Schedule
        - [x] Customizable quantity of rows and columns
        - [x] Supports an inconsistent number of columns
            - [x] (eg. different number of subjects every day)
    - [x] Customizable Grid Row Names
        - [x] (Time automation can only be done with days of the week as row labels)
        - [x] (Rows Times will only display if the times are consistent for every entry)
- [x] Status:
    - [x] Status Bar
        - [x] Displays the current time
        - [x] Displays current and upcoming subjects, class/rooms, start times, and end times
        - [x] Updates every minute based on the OS clock
    - [x] {Space} [>] Highlights current subject(Shades Button)
    - [x] {Space + Space} [>] Highlights upcoming subject(Shades text)
- [x] Launching Applications:
    - [x] Clicking the subject to be launched on the schedule table
    - [x] Using assigned one-key shortcuts for each class
    - [x] Time Based
        - [x] {Enter/Return} [>] Highlights(Shades Button) and Launches the set class for the current time
        - [x] {Control/Command + Enter/Return} [>] Highlights(Shades text) and Launches the set upcoming class based on the current time
- [x] Direct Modification of Configuration Files
    - [x] classLaunch.app(macOS: Right Click -> Show Package Contents) [>] Contents [>] Configuration
    - [x] Filenames of configuration files must be "Links.plist" and "sched.plist"

***

## Installation

    ### Getting python
    
        - [1] Download the latest release of python 3 [here](https://www.python.org/downloads/)
        - [2] Install according to the setup instructions
        - [x] The program will exit upon failure to detect python 3

    ### Getting the program

        - [1] Click the green `Code` button, followed by the "Download ZIP" button. (or visit this [link to download](https://github.com/richiekalalo19/classLaunch/archive/refs/heads/main.zip)
        - [2] Proceed by unzipping the file
        - [x] Alternatively, clone the repo via Git from the command prompt or terminal
            ```
            git clone https://github.com/richiekalalo19/classLaunch
            ```
            
    ### Starting the program
    
        #### On macOS:
        
            - [1] Move classLaunch.app application from the downloaded folder to the Applications folder (or the desired location)
            - [2] Double-click to start the program
        
        #### On Windows:
        
            - [1] Move classLaunch.app folder from the downloaded folder to the desired location
            - [2] Run classLaunch.bat to start the program

    ### Supplying Data

        - [1] Upon the first start, the program will open the configuration files in a text editor
            - [x] A plist editor is recommended. Some options are:
                - [x] [Xplist](https://github.com/ic005k/Xplist)
                - [x] [ProperTree](https://github.com/corpnewt/ProperTree)
                - [x] [Xcode(macOS only)](https://apps.apple.com/id/app/xcode/id497799835?mt=12)
        - [2] In "Links.plist"
            - [2.1] Under the dictionary named "Links", define the classes as keys and their corresponding links as (string) values
            - [2.2] Under the dictionary named "Shortcuts", define the desired one-key shortcuts as keys and the classes (keys in [2.1]) they should correspond to as (string) values
        - [3] In "sched.plist"
            - [3.1] Under the root dictionary, define dictionaries with the name Row x (where x is a number)
                - [x] The program cannot interpret a name without a consecutive predecessor (e.g. a dictionary named Row 3 cannot be interpreted without one named Row 2)
            - [3.2] Inside each (Row x) dictionary, define a key "Title" with (string) values of the desired day to represent
            - [3.3] Inside each (Row x) dictionary, define a key "Items" with the value of a dictionary with the name of the desired subject
            - [3.4] Inside each subject's dictionaries ([3.3]), Define keys "Class", "Start",  and "End" in order. Enter their values (as strings) of the defined classes for "Class" and time (in 24-hour notation and colon separator - e.g. 14:00) for "Start" and "End"
        - [4] Save and close the "Links.plist" and "sched.plist" files and re-open the application
            - [4.1] If the structure is incorrect, you will have the option of rewriting the default sample (Prompt Yes), editing the file (Prompt No), or exiting the program (Prompt Cancel)
        - [5] If any edits were to be required, press {Command/Control + ,} to re-open the .plist files
        - [x] Refer to the built-in samples for examples
            - [x] classLaunch.app(macOS: Right Click -> Show Package Contents) [>] Contents [>] Configuration [>] Samples
        - [x] Modifying, or copy-pasting if more is required, the desired entries are advisable
        - [x] Please do not alter the root structure of the dictionary, each row element([3.2]-[3.3]), or each Item element ([3.4]-[3.5])
            - [x] (e.g. adding new elements or removing "Links" and "Shortcuts" dictionaries in "Links.plist")   
        
    ### Example .plist data files structure:
        
        #### Example .plist data files structure:
        
            - [x] String values are represented as "
            - [x] Dictionaries key-value pairs are designated by key : value
        
            ```
            ├── sched.plist (file root)
            │   ├── "Row 1" :
            │   │   ├── "Title" : "Monday"
            │   │   └── "Items" :
            |   │       ├── "English" :
            |   │       │   ├── Class   : "Class A"
            |   │       │   ├── Start   : "07:00"
            |   │       │   └── End     : "08:00"
            |   │       └── "Maths" :
            |   │           ├── Class   : "Class B"
            |   │           ├── Start   : "09:00"
            |   │           └── End     : "10:00
            │   └── "Row 2" :
            │       ├── "Title" : "Tuesday"
            │       └── "Items" :
            |           ├── "Subject 3" :
            |           │   ├── Class"  : "Class A"
            |           │   ├── Start   : "07:00"
            |           │   └── End     : "08:00"
            |           └── "Subject 6" :
            |               ├── "Class  : "Class C"
            |               ├── "Start" : "09:00"
            |               └── "End"   : "10:00"
            └── Links.plist (file root)
                ├── "Links" :
                │   ├── "Class A"     : "https://us02web.zoom.us/j/8709873867?pwd=WUtHbmp0QS9tOWlaVitJU0I2VjhFUT09"
                │   ├── "Class B"     : "https://us02web.zoom.us/j/8709873867?pwd=WUtHbmp0QS9tOWlaVitJU0I2VjhFUT09"
                │   └── "Class C"     : "https://us02web.zoom.us/j/8709873867?pwd=WUtHbmp0QS9tOWlaVitJU0I2VjhFUT09"
                └── "Shortcuts" :
                    ├── "A" : "Class A"
                    ├── "B" : "Class B"
                    └── "C" : "Class C"
            ```



## Contributing

        #### The python script is located under:
            ***
            - [x] classLaunch.app(macOS: Right Click -> Show Package Contents) [>] Contents [>] MacOS [>] classLaunch.command
            ***
            - [x] Open the file in a suitable text editor (Set syntax to Python if necessary)


## Limitations

* **Linux Compatibility**

  Due to my lack of experience with Linux, the program is yet to be validated and tested to work properly in the Operating System.
 
* **Setup Dependencies**

  Due to my lack of experience with Unix and windows scripting languages, the program requires the user to manually install python 3 to run instead of detecting and resolving the dependency automatically.
 
* **Incomplete Testing**

    Sufficient testing, particularly regarding different types of .plist configurations, is yet to be done as of the current release. (07/01/2023)
 
* **Code Efficiency and readability**

    Optimizations to the code; regarding performance efficiency, readability, and reliability; are yet to be made

