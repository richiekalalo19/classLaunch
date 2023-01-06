#!/usr/bin/env /Library/Frameworks/Python.framework/Versions/Current/bin/python3
import os, sys, webbrowser, plistlib, tkinter, tkinter.messagebox, tkinter.filedialog, datetime, subprocess, pathlib
################################################################### Ensuring macOS system python (deprecated tkinter) was not executed
if tkinter.TkVersion < 8.6:
  sys.exit()
################################################################### Setting Path Variables
file_path = os.path.realpath(__file__)
MastPath = os.path.expanduser(file_path[0:-25]+'Configuration')
SchedPath = os.path.join(MastPath, 'sched.plist')
LinksDBPath = os.path.join(MastPath, 'Links.plist')
if os.path.exists(MastPath) == False:
  if sys.platform == 'win32':
    subprocess.run(['mkdir', MastPath], shell=True)
  else:
    subprocess.run(['mkdir', MastPath])
################################################################### External File (Plist) Handling Functions
def writeInitPref(*args, plist, runopenPref=False): #Rebuild Default plist
  if 'Sched' in plist:
    schedSample = {
      "Row 1":{
        "Title": "Monday",
        "Items":{
          "IT ES3":{
            "Class": "11E",
            "Start": "7:30",
            "End": "8:50"
          },
          "Maths":{
            "Class": "11E",
            "Start": "9:10",
            "End": "10:30"
          },
          "Chem ES2":
          {
            "Class": "11B",
            "Start": "10:50",
            "End": "12:10"
          },
          "CS":{
            "Class": "11E",
            "Start": "13:20",
            "End": "14:00"
          }
        }
      },
      "Row 2":{
        "Title": "Tuesday",
        "Items":{
          "Maths/Civ":{
            "Class": "11E",
            "Start": "7:30",
            "End": "8:50"
          },
          "Phy ES1":{
            "Class": "11D",
            "Start": "9:10",
            "End": "10:30"
          },
          "CFYG":{
            "Class": "EL8",
            "Start": "10:50",
            "End": "12:10"
          },
          "English":{
            "Class": "11E",
            "Start": "13:20",
            "End": "14:00"
          }
        }
      },
      "Row 3":{
        "Title": "Wednesday",
        "Items":{
          "Phy ES1":{
            "Class": "11D",
            "Start": "7:30",
            "End": "8:50"
          },
          "IT ES3":{
            "Class": "11E",
            "Start": "9:10",
            "End": "10:30"
          },
          "English":{
            "Class": "11E",
            "Start": "10:50",
            "End": "12:10"
          },
          "PE":{
            "Class": "11E",
            "Start": "13:20",
            "End": "14:00"
          }
        }
      },
      "Row 4":{
        "Title": "Thursday",
        "Items":{
          "English":{
            "Class": "11E",
            "Start": "7:30",
            "End": "8:50"
          },
          "Phy ES1":{
            "Class": "11D",
            "Start": "9:10",
            "End": "10:30"
          },
          "Chem ES2":{
            "Class": "11B",
            "Start": "10:50",
            "End": "12:10"
          },
          "Maths":{
            "Class": "11E",
            "Start": "13:20",
            "End": "14:00"
          }
        }
      },
      "Row 5":{
        "Title": "Friday",
        "Items":{
          "IT ES3":{
            "Class": "11E",
            "Start": "7:30",
            "End": "8:50"
          },
          "Maths":{
            "Class": "11E",
            "Start": "9:10",
            "End": "10:30"
          },
          "Chem ES2":{
            "Class": "11B",
            "Start": "10:50",
            "End": "12:10"
          },
          "BI":{
            "Class": "11E",
            "Start": "13:20",
            "End": "14:00"
          }
        }
      }
    }
    with open(os.path.expanduser(SchedPath), 'wb') as writeSchedSample:
      plistlib.dump(schedSample, writeSchedSample, sort_keys=False)
    writeSchedSample.close()
  if 'Links' in plist:
    LinksDBBackupPath = os.path.expanduser('~/Library/Application Support/classLaunch/Configuration/Backup/linksDBBackup.plist')
    linksSample = {
      "Links":{
        "EL2": "https://us02web.zoom.us/j/8709873867?pwd=WUtHbmp0QS9tOWlaVitJU0I2VjhFUT09",
        "EL8": "https://us02web.zoom.us/j/3247244098?pwd=d3V5ay9XVXNMQXRBbTAyUWlNMytTQT09",
        "11B": "https://us02web.zoom.us/j/5087542387?pwd=dHhKMjNHSHhyTUgzcTJEMDNVRE56dz09",
        "11D": "https://us02web.zoom.us/j/8750020710?pwd=djhNMWF2UGpGM1p1OG45YkU5L1c3dz09",
        "11E": "https://us02web.zoom.us/j/3638858469?pwd=NlYyYjVWekMyM0RJWG5qNm5TMXBzdz09"
      },
      "Shortcuts":{
        "2": "EL2",
        "8": "EL8",
        "b": "11B",
        "d": "11D",
        "e": "11E"
      }
    }
    with open(os.path.expanduser(LinksDBPath), 'wb') as writeLinksSample:
      plistlib.dump(linksSample, writeLinksSample, sort_keys=False)
    writeLinksSample.close()
  if runopenPref:
    openPref()
  return None
  
def openPref(*args): #Edit Plists in seperate application
  if sys.platform == 'win32':
    subprocess.run(["start", LinksDBPath], shell=True)
    subprocess.run(["start", SchedPath], shell=True)
  else: 
    subprocess.run(['open', SchedPath])
    subprocess.run(['open', LinksDBPath])
  return sys.exit()
################################################################### Opening External (Plists) files, Assigning dictionaries to variables, Validating Links and Shotcut 
rebuildcount = 0 #Close GUI and edit after rebuilt
#Open Links External (Plist) File
if os.path.isfile(LinksDBPath) == False:
  writeInitPref(plist=['Links'])
  rebuildcount +=1
with open(LinksDBPath , 'rb') as ReadLinks:
  try:
    LinksandShortsDB = plistlib.load(ReadLinks)     
  except plistlib.InvalidFileException:
    writeInitPref(plist=['Links'])
    rebuildcount +=1
ReadLinks.close()
#Open Sched External (Plist) File
if os.path.isfile(SchedPath) == False:
  writeInitPref(plist=['Sched'])
  rebuildcount +=1
with open(SchedPath , 'rb') as ReadSched:
  try:
    Sched = plistlib.load(ReadSched)                 
  except plistlib.InvalidFileException:
    writeInitPref(plist=['Sched'])
    rebuildcount +=1
ReadSched.close()
#Closing after rebuild if rebuilt
if rebuildcount != 0:
  openPref() 
  rebuildcount = 0
#Seperating Links and Shotcuts into Seperate Dictionaries
LinksDB = LinksandShortsDB.get('Links')
ShortsDB = LinksandShortsDB.get('Shortcuts')
if LinksDB == None or ShortsDB == None:
  propmptLinksShortsDBDerrivationValidation = tkinter.messagebox.askyesnocancel(title='Incorrectly formatted Links Plist', message='Incorrectly formatted Links Plist. Rewrite Sample? Click Yes to Rewrite, Click No to Edit Preferences')
  if propmptLinksShortsDBDerrivationValidation is None:
    sys.exit()
  elif propmptLinksShortsDBDerrivationValidation:
    writeInitPref(plist=['Links'], runopenPref=True)
  else:
    openPref()
ShortsCapsCache = dict()
for short0 in ShortsDB:
  if short0.isupper() == True:
    ShortsCapsCache.update({short0.lower(): ShortsDB.get(short0)})
  else:
     ShortsCapsCache.update({short0: ShortsDB.get(short0)})   
ShortsDB = ShortsCapsCache
ShortsCapsCache = '' 
#################################################################### Schedule Validation and Variables Assignment
RowLabels, Entries, ClassDB, TimeDB = list(), list(), dict(), dict()
try:
  DaysCount = len(Sched)
  PeriodCount=len((Sched.get('Row 1')).get('Items'))
  for dayindex0 in range(len(Sched)):
    if dayindex0 < len(Sched) - 1 :
      ValidationRuleData = 'Validating Consistent Entries per Row: ' + str(dayindex0+1) + ' and ' + str(dayindex0+2) + ' '
      ValidationResultcurrData = len(Sched.get('Row ' + str(dayindex0 + 1)).get('Items')) == len(Sched.get('Row ' + str(dayindex0 + 2)).get('Items'))
      #print(ValidationRuleData, str(ValidationResultcurrData))
      if ValidationResultcurrData == False:
        tkinter.messagebox.showwarning(title='Inconsistent Entry counts', message='Inconsistent Entry counts')
    RowLabels.append(Sched.get('Row ' + str(dayindex0+1)).get('Title'))
    Entries.append(list(((Sched.get('Row ' + str(dayindex0+1))).get('Items')).keys()))
    ClassDBValue, DBKey, TimeDBValue = list(), list(), list()
    DBMetadata = list(((Sched.get('Row ' + str(dayindex0+1))).get('Items')).values())
    for datainjectindex in range(len(DBMetadata)): #loop periods
      ClassDBValue.append(DBMetadata[datainjectindex].get('Class'))
      DBKey.append(str(dayindex0) + ',' + str(datainjectindex)) #day, period
      TimeDBValue.append(DBMetadata[datainjectindex].get('Start') + " - " + DBMetadata[datainjectindex].get('End'))
      ClassDB.update(dict(zip(DBKey,ClassDBValue)))
      TimeDB.update((dict(zip(DBKey,TimeDBValue))))
except AttributeError: 
  responseIncorrectDataStrcturePrompt = tkinter.messagebox.askyesnocancel(title='Incorrect Data Structure', message='Incorrect Schedule Data Structure. Rewrite Sample? Click Yes to Rewrite, Click No to Edit Preferences') 
  if responseIncorrectDataStrcturePrompt is None:
    sys.exit()
  elif responseIncorrectDataStrcturePrompt:
    writeInitPref(plist=['Sched'], runopenPref=True)
  else:
    openPref()
##################################################################### Validation and Defenition of Non Essential optional variables
runDayindex = None
DaysOfTheWeekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
DaysOfTheWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
if DaysOfTheWeekDays == RowLabels or DaysOfTheWeek==RowLabels: 
  if datetime.datetime.now().weekday() < len(RowLabels):
    runDayindex = (datetime.datetime.now()).weekday()
    runDay = RowLabels[runDayindex]
runDayPeriods = list()
for periodindex2 in range(PeriodCount):
  if runDayindex != None:
    runDayPeriods.append(TimeDB.get(str(runDayindex) + ',' + str(periodindex2)))
  else: 
    runDayPeriods.append(None)
ValidationResultEnableColLabels = list()
for dayindex1 in range(DaysCount-1):
  for periodindex0 in range(PeriodCount):
    ValidationRuleEnableColLabels = (str(periodindex0) + ',' + str(dayindex1) + ' ? ' + str(periodindex0) + ',' + str(dayindex1+1))
    ValidationResultcurrEnableColLabels = TimeDB.get(str(dayindex1) + ',' + str(periodindex0)) == TimeDB.get(str(dayindex1+1) + ',' + str(periodindex0))
    ValidationResultEnableColLabels.append(ValidationResultcurrEnableColLabels)
    #print(ValidationRuleEnableColLabels, ValidationResultcurrEnableColLabels)
##################################################################### Window and Menus Defenition, animation and Properties Execution
expandcountwin, xsizewin, ysizewin = 0, 0, 0
window = tkinter.Tk()
window.title('Launch')
psywin = -270 + int(window.winfo_screenheight()/2 - window.winfo_reqheight()/2)
psxwin = -180 + int(window.winfo_screenwidth()/2 - window.winfo_reqwidth()/2)
menuBar = tkinter.Menu(window)
window.config(menu=menuBar)
menuBarNameSection = tkinter.Menu(menuBar)
menuBar.add_cascade(label="classLaunch", menu=menuBarNameSection)
menuBarNameSection.add_command(label="Preferences", command=openPref)
menuBarNameSection.add_separator()
menuBarNameSection.add_command(label="Quit", command=lambda: sys.exit())
menuBarDataSection = tkinter.Menu(menuBar)
menuBar.add_cascade(label="Data", menu=menuBarDataSection)
menuBarDataSection.add_separator()
menuBarDataSection.add_command(label="Rebuild New Schedule", command=lambda: writeInitPref(plist=['Sched'], runopenPref=True))
menuBarDataSection.add_command(label="Rebuild New Links and Shortcuts", command=lambda: writeInitPref(plist=['Links'], runopenPref=True))
menuBarDataSection.add_command(label="Rebuild New Schedule, Links and Shortcuts", command=lambda: writeInitPref(plist=['Links','Sched'], runopenPref=True))
def animateopenWindow():
  global expandcountwin, psxwin, xsizewin, ysizewin
  if expandcountwin < 8:
    psxwin -= 8
    xsizewin += int((20*PeriodCount))
    ysizewin += int((18.5*DaysCount))
    window.maxsize(xsizewin, ysizewin)
    window.minsize(xsizewin, ysizewin)
    expandcountwin += 1
    window.after(1, animateopenWindow)
    window.geometry("+{}+{}".format(psxwin, psywin))
animateopenWindow()
window.resizable(0,0)
###################################################################### Window Animation Functions
def RoundRectangle(parent, x1, y1, x2, y2, radius, **kwargs):   
  points = [
    x1+radius, y1,
    x1+radius, y1,
    x2-radius, y1,
    x2-radius, y1,
    x2, y1,
    x2, y1+radius,
    x2, y1+radius,
    x2, y2-radius,
    x2, y2-radius,
    x2, y2,
    x2-radius, y2,
    x2-radius, y2,
    x1+radius, y2,
    x1+radius, y2,
    x1, y2,
    x1, y2-radius,
    x1, y2-radius,
    x1, y1+radius,
    x1, y1+radius,
    x1, y1]
  return parent.create_polygon(points, smooth=True, **kwargs)

def updateRect(canvas, roundRect, fill, x1, y1, x2, y2, r):
    points = (x1+r, y1, x1+r, y1, x2-r, y1, x2-r, y1, x2, y1, x2, y1+r, x2, y1+r, x2, y2-r, x2, y2-r, x2, y2, x2-r, y2, x2-r, y2, x1+r, y2, x1+r, y2, x1, y2, x1, y2-r, x1, y2-r, x1, y1+r, x1, y1+r, x1, y1)
    canvas.coords(roundRect, *points)
    canvas.itemconfig(roundRect, fill=fill)
###################################################################### Time Handler Functions
def isWithinTime(range, timefn):
  now = datetime.datetime.now()
  if timefn == 'rawNow':
    return now
  nowFormat =("{:d}:{:02d}").format(now.hour, now.minute)
  if timefn == 'nowFormat':
    return nowFormat
  dashseperator = range.find('-')
  startStr = range[:dashseperator]
  endStr = range[dashseperator+1:]
  if timefn == 'dataDecode':
    return startStr, endStr, nowFormat
  startcolon = startStr.find(':')
  starthour = startStr[:startcolon]
  startmin = startStr[startcolon+1:]
  if starthour[0] == '0':
    starthour = int(starthour[1:])
  else:
    starthour = int(starthour)
  if startmin[0] == '0':
    startmin = int(startmin[1:])
  else:
    startmin=int(startmin)
  endcolon = endStr.find(':')
  endhour = endStr[:endcolon]
  endmin = endStr[endcolon+1:]
  if endhour[0] == '0':
    endhour = int(endhour[1:])
  else:
    endhour = int(endhour)
  if endmin[0] == '0':
    endmin = int(endmin[1:])
  else:
    endmin=int(endmin)  
  if starthour == 24 :
    starthour = 0
    starttoday = now.replace(day=int(now.day)+1, hour=starthour, minute=startmin, second = 0)
  else:
    starttoday = now.replace(hour=starthour, minute=startmin, second = 0)
  if endhour == 24 :
    endhour = 0
    endtoday = now.replace(day=int(now.day)+1, hour=endhour, minute=endmin, second = 0)
  else:
    endtoday = now.replace(hour=endhour, minute=endmin, second = 0)
  if timefn == 'currentisWithin':
    return starttoday < now < endtoday or endtoday < now < starttoday
  if timefn == 'rawDataDecode':
    return [starttoday, endtoday]
  if timefn == 'timeDifftoStart':
    timeDifftoStart = starttoday - now
    #timediffinnor = divmod(timeDifftoStart.days * 86400 + timeDifftoStart.seconds, 60)
    return timeDifftoStart

def StatFrame():
  if runDayindex == None:
    return None
  secbuffer = 1000*(60 - isWithinTime(None, 'rawNow').second)
  StatFrameMetadata = TimeBasedLaunch('StatFrame', 'runtime')
  currSubject, currClass, currStart, currEnd = '-', '-', '-', '-'
  runDaySubjects = Entries[runDayindex]
  if StatFrameMetadata != None:
    timePeriods = isWithinTime(StatFrameMetadata[1], 'dataDecode')
    currSubject = runDaySubjects[StatFrameMetadata[0]]
    currClass = ClassDB.get(str(runDayindex) + ',' + str(StatFrameMetadata[0]))
    currStart = timePeriods[0]
    currEnd = timePeriods[1]
    now = timePeriods[2]
  else:
    now = isWithinTime(None, 'nowFormat')
  StatFrameNextIndex = TimeBasedLaunch('StatFrame', 'closeStart')
  nextSubject, nextClass, nextStart, nextEnd = '-', '-', '-', '-'
  if StatFrameNextIndex != None:
    StatFrameNextTimeFrame = runDayPeriods[StatFrameNextIndex]
    nextTimePeriods = isWithinTime(StatFrameNextTimeFrame, 'dataDecode')
    nextSubject = runDaySubjects[StatFrameNextIndex]
    nextClass = ClassDB.get(str(runDayindex) + ',' + str(StatFrameNextIndex))
    nextStart = nextTimePeriods[0]
    nextEnd = nextTimePeriods[1]
  cspnBasedOnPeriodCount = int(PeriodCount/2)
  StatcurrFrame = tkinter.Frame(window, bd=0, height=50, width=50)
  StatFrameNext = tkinter.Frame(window, bd=0, height=50, width=50)
  StatcurrFrame.grid(column=2, row=1, columnspan=cspnBasedOnPeriodCount, sticky = 'w')
  StatFrameNext.grid(column=2+cspnBasedOnPeriodCount, row=1, columnspan=cspnBasedOnPeriodCount, sticky='e')
  tkinter.Label(StatcurrFrame, bd=0, text='Subject', width=5).grid(column=1, row=1)
  tkinter.Label(StatcurrFrame, bd=0, text=currSubject, width=7).grid(column=1, row=2)
  tkinter.Label(StatcurrFrame, bd=0, text='Class', width=5).grid(column=2, row=1)
  tkinter.Label(StatcurrFrame, bd=0, text=currClass, width=5).grid(column=2, row=2)
  tkinter.Label(StatcurrFrame, bd=0, text='Start', fg='red', width=5).grid(column=3, row=1)
  tkinter.Label(StatcurrFrame, bd=0, text=currStart, fg='red', width=5).grid(column=3, row=2)
  tkinter.Label(StatcurrFrame, bd=0, text='Now', fg='orange', width=5).grid(column=4, row=1)
  nowLabel = tkinter.Label(StatcurrFrame, bd=0, text=now, fg='orange', width=5).grid(column=4, row=2)
  tkinter.Label(StatcurrFrame, bd=0, text='End', fg='green', width=5).grid(column=5, row=1)
  tkinter.Label(StatcurrFrame, bd=0, text=currEnd, fg='green', width=5).grid(column=5, row=2)
  tkinter.Label(StatFrameNext, bd=0, text='Next  ', width=5).grid(column=1, row=1, rowspan=2)
  tkinter.Label(StatFrameNext, bd=0, text='Subject', width=5).grid(column=2, row=1)
  tkinter.Label(StatFrameNext, bd=0, text=nextSubject, width=7).grid(column=2, row=2)
  tkinter.Label(StatFrameNext, bd=0, text='Class', width=5).grid(column=3, row=1)
  tkinter.Label(StatFrameNext, bd=0, text=nextClass, width=5).grid(column=3, row=2)
  tkinter.Label(StatFrameNext, bd=0, text='Start', fg='red', width=5).grid(column=4, row=1)
  tkinter.Label(StatFrameNext, bd=0, text=nextStart, fg='red', width=5).grid(column=4, row=2)
  tkinter.Label(StatFrameNext, bd=0, text='End', fg='green', width=5).grid(column=5, row=1)
  tkinter.Label(StatFrameNext, bd=0, text=nextEnd, fg='green', width=5).grid(column=5, row=2)
  window.after(secbuffer, StatFrame)
###################################################################### Launching Links Functions
def launch(parentperiod, parentday):
  try:
    global Entries, ClassDB, LinksDB
    name = ((Entries[(parentday)])[parentperiod])
    room = ClassDB.get(str(parentday)+ ',' + str(parentperiod))
    link = LinksDB.get(room)
    #print(name, room, link)
    webbrowser.open(link)
    sys.exit()
  except AttributeError:
    responseNoClassProvidedinOneorManyInstances = tkinter.messagebox.askokcancel(title='Invalid or missing Class or Link', message='Invalid or missing Class or Link. Edit Preferences?')
    if responseNoClassProvidedinOneorManyInstances == True:
      openPref()

calledforcurrCountTBLSpace = 0
def TimeBasedLaunch(event, type):
  #print(event, type)
  global CanvasContainer, RectanglesContainer, LabelsContainer, PeriodCount, runDayindex, runDayPeriods, calledforcurrCountTBLSpace
  if '''None not in runDayPeriods''' and runDayindex != None:
    try:
      eventIsNotStr = isinstance(event, str) == False
      if type == 'closeStart' or (calledforcurrCountTBLSpace>0 and event.char == ' '):
        contextualizeDayStart  = datetime.datetime.now().replace(hour=23, minute=59, second=59)
        contextualizeDayEnd = datetime.datetime.now().replace(hour=0, minute=0, second=0)
        timeDeltamax = [datetime.timedelta(days=1), None]
        for period2idx, period2 in enumerate(runDayPeriods):
          contextualizeDayStartEndHelperPref = isWithinTime(period2, 'rawDataDecode')
          if contextualizeDayStartEndHelperPref[0] < contextualizeDayStart:
            contextualizeDayStart = contextualizeDayStartEndHelperPref[0]
          if contextualizeDayStartEndHelperPref[1] > contextualizeDayEnd:
            contextualizeDayEnd = contextualizeDayStartEndHelperPref[1]
          resBetween = isWithinTime(period2, 'timeDifftoStart')
          if datetime.timedelta() < resBetween < timeDeltamax[0]:
            timeDeltamax[0] = resBetween
            timeDeltamax[1] = period2idx
        if event == 'StatFrame':
          return timeDeltamax[1]
        contextualizeDayStart = datetime.datetime(contextualizeDayStart.year,contextualizeDayStart.month,contextualizeDayStart.day,contextualizeDayStart.hour,contextualizeDayStart.minute-30,0,0)
        if contextualizeDayStart <= datetime.datetime.now() <= contextualizeDayEnd:
          CanvasIndex = (PeriodCount*runDayindex+timeDeltamax[1])
          (LabelsContainer[CanvasIndex])['state']='disabled'
          if eventIsNotStr and (event.keysym == 'Return' or event.char == '\r'):
            window.after(5, lambda: launch(timeDeltamax[1], runDayindex))
        return timeDeltamax[1]
      elif type == 'runtime':
        for period0idx, period0 in enumerate(runDayPeriods):
          if isWithinTime(period0, 'currentisWithin') == True:
            if event == 'StatFrame':
              return [period0idx, period0]
            CanvasIndex = (PeriodCount*runDayindex+period0idx)
            updateRect(CanvasContainer[CanvasIndex], RectanglesContainer[CanvasIndex], 'grey', 12.8, 12.8, 128, 128, 20)
            LabelsContainer[CanvasIndex].config(bg='grey')
            if eventIsNotStr and (event.keysym == 'Return' or event.char == '\r'):
              window.after(5, lambda: launch(period0idx, runDayindex))
              return None
        if eventIsNotStr:
          calledforcurrCountTBLSpace += 1
    except IndexError:
      rundayindexNoneBypassedIndexErrorPropmpt0 = tkinter.messagebox.askokcancel(title='Incorrectly formatted plist or Start/End', message='Incorrectly formatted plist or Start/End. Edit Preferences?')
      if rundayindexNoneBypassedIndexErrorPropmpt0 == True:
        openPref()
      elif rundayindexNoneBypassedIndexErrorPropmpt0 == False:
        sys.exit()

def shortcutLaunch(event, **kwargs):
  Recursive = kwargs.pop('Recursive', False)
  roomInput = ShortsDB.get(event.char.lower())
  if Recursive == False:
    try:
      TimeBasedLaunch('Short','runtime')
      if runDayindex != None:
        for period1idx, period1 in enumerate(Entries[runDayindex]):
          roomCompare = ClassDB.get(str(runDayindex) + ',' + str(period1idx))
          if roomCompare == roomInput:
            CanvasIndex = (PeriodCount*runDayindex+period1idx)
            (LabelsContainer[CanvasIndex])['state']='disabled'
      window.after(7, lambda: shortcutLaunch(event, Recursive=True))
    except IndexError:
      rundayindexNoneBypassedIndexErrorPropmpt0 = tkinter.messagebox.askokcancel(title='Incorrectly formatted plist or Start/End', message='Incorrectly formatted plist or Start/End. Edit Preferences?')
      if rundayindexNoneBypassedIndexErrorPropmpt0 == True:
        openPref()
      elif rundayindexNoneBypassedIndexErrorPropmpt0 == False:
        sys.exit()
  else:
    try:
      link = LinksDB.get(roomInput)
      webbrowser.open(link)
      sys.exit()
    except AttributeError:
      ShortcutMissingLinkorClassPrompt = tkinter.messagebox.askokcancel(title='No matching Room or link of shortcut', message='Missing link for room of shortcut. Edit Preferences?')
      if ShortcutMissingLinkorClassPrompt == True:
        openPref()
###################################################################### Executing Main Grid
if False not in ValidationResultEnableColLabels:
  for periodindex1 in range(PeriodCount):
    tkinter.Label(window, text=TimeDB.get('0,' + str(periodindex1)), bd=0).grid(row=2, column=periodindex1 + 2)
for keybinds in ShortsDB:
  window.bind(str(keybinds).lower(), shortcutLaunch)
  window.bind(str(keybinds).upper(), shortcutLaunch)
CanvasContainer, LabelsContainer, RectanglesContainer = list(), list(), list()
for dayindex2 in range(DaysCount):
  tkinter.Label(window, text=RowLabels[dayindex2], bd=0).grid(row=dayindex2+3, column=1)
  for periodindex3 in range(PeriodCount):
    CanvasIndex = (PeriodCount*dayindex2+periodindex3)
    CanvasContainer.append(tkinter.Canvas(window, width=128, height=128))
    CanvasContainer[CanvasIndex].grid(row=dayindex2+3, column=periodindex3+2)
    CanvasContainer[CanvasIndex].bind('<Button-1>', lambda event:launch(periodindex3, dayindex2))
    LabelsContainer.append(tkinter.Label(CanvasContainer[CanvasIndex],text=((Entries)[dayindex2])[periodindex3],bd=0, bg="#CCCCCC", justify='center'))
    LabelsContainer[CanvasIndex].place(x=59.7-2.5*len(((Entries)[dayindex2])[periodindex3]), y=59.7)
    RectanglesContainer.append(RoundRectangle(CanvasContainer[CanvasIndex], 12.8, 12.8, 128, 128, 20, fill="#CCCCCC"))
StatFrame()
window.bind('<Return>', lambda event: TimeBasedLaunch(event, 'runtime'))
window.bind('<space>', lambda event: TimeBasedLaunch(event, 'runtime'))
if sys.platform == 'darwin':
  window.bind('<Command-Return>', lambda event: TimeBasedLaunch(event, 'closeStart'))
  window.bind('<Command-,>', lambda event: openPref(event))
  window.bind('<Command-.>', lambda event: writeInitPref(event, plist=['Sched'], runopenPref=True))
  window.bind('<Command-m>', lambda event: writeInitPref(event, plist=['Links'], runopenPref=True))
  window.bind('<Command-n>', lambda event: writeInitPref(event, plist=['Links', 'Sched'], runopenPref=True))
elif sys.platform == 'win32':
  window.bind('<Control-Return>', lambda event: TimeBasedLaunch(event, 'closeStart'))
  window.bind('<Control-,>', lambda event: openPref(event))
  window.bind('<Control-.>', lambda event: writeInitPref(event, plist=['Sched'], runopenPref=True))
  window.bind('<Control-m>', lambda event: writeInitPref(event, plist=['Links'], runopenPref=True))
  window.bind('<Control-n>', lambda event: writeInitPref(event, plist=['Links', 'Sched'], runopenPref=True))
window.mainloop()