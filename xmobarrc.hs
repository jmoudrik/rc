Config { font = "xft:Terminus:size=14:antialias=false"
     , bgColor = "#000000"
     , fgColor = "grey"
	 , lowerOnStart = True
     --, position = Static { xpos = 200 , ypos = 0, width = 1400, height = 20 }
     , position = TopW R 93 
     , commands = [ 
             Run Cpu ["-L","3","-H","50","--normal","green","--high","red", "-t", "<total>%"] 10 
             , Run Memory ["-t","<fc=green><usedratio></fc>%"] 10
             --, Run Network "wlan1" ["-L","0","-H","70","--normal","green","--high","red"] 10 
             , Run Battery ["-t","AC <acstatus>, <left>%, <timeleft>","-L","50","-H","75","-h","green","-n","yell","-l","red"] 20 
             , Run Com "/home/jm/prj/rc/bin/get_times.sh" [] "timeny" 10
             , Run Date "%d.%m. %H:%M" "date" 10
             --, Run Com "/home/jm/bin/get_current_layout.sh" [] "layout" 2
             , Run Com "/home/jm/prj/rc/bin/get_latency.sh" [] "latency" 20
             , Run Kbd            [ ("cz(qwerty)" , "<fc=red>cz</fc>")
                                  ,("us"         , "<fc=white>us</fc>")
                                  ,("ru"         , "<fc=orange>ru</fc>")
								  ]
			 , Run DiskU [("/", "<used>/<size>"), ("sda1", "<usedbar>")]
			        ["-L", "20", "-H", "50", "-m", "1", "-p", "3"]
					       20
             , Run StdinReader
           ]
     , sepChar = "%"
     , alignSep = "}{"
     , template = " %StdinReader%}{<fc=grey></fc>%kbd%<fc=grey></fc> <fc=grey>[%cpu% %memory%]</fc> <fc=grey></fc><fc=cyan>%latency%</fc><fc=grey></fc> %disku% <fc=grey>[</fc><fc=white>%battery%</fc><fc=grey>]</fc> <fc=grey></fc><fc=cyan>%timeny%</fc><fc=grey>,</fc> <fc=cyan>%date%</fc>"
     --, template = " %StdinReader%}{<fc=grey>(</fc>%kbd%<fc=grey>)</fc>  <fc=grey>[%cpu% %memory%]</fc>  <fc=grey>[</fc><fc=cyan>%wlan1%</fc><fc=grey>]</fc>  <fc=grey>[</fc><fc=white>%battery%</fc><fc=grey>]</fc>  <fc=cyan>%date%</fc>"
 }
