# Hosting Web Application in Windows

- IIS [ Internet Information Services ] ( just like nginx )
- This PC > c drive > inetpu > wwwroot > <mysite-folder>

- open InternetInformationServices 
	- add your site configuration and restart 
- This PC > c drive > Windows > system32 > drvers > etc > hosts - add 127.0.0.1 <site-name>

--------------------------------
goto server manager
goto local server
-------
- open browser and download website zip file
- unzip it you and click on index.html
- copy to c drive
- goto server manager
  - add roles and feature
    - role > dns server
----------------------------------------
## server manager
- add roles and feature
  - next
  - role > web server
  - next -> install
### close window
##### start menu windows admin tool
- open InternetInformationServices
  - sites
    - default wesite
- This PC > c drive > inetpu > wwwroot > <mysite-folder>
