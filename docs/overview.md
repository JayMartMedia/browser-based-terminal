# Overview

This project consists of a few main features:
- Docker for containerization
- Express server for serving static files
- Express server for web-socket connection to allow UI to interact with shell
- Express server to allow UI to check status of test
- Bash files which Express can call to check status of test
- UI terminal which interacts with Express web-socket server
- UI challenge/guide panel for questions/instructions

What about if we have a dir for each question that contains .html for the instruction section and multiple .sh files for each question. Possible HTMX. The UI can make one call to the API to get the number of questions, then the ui can request Q1 and receive .html and insert it into section. Then user clicks check (or at end) each of the bash files is run to detect which things are finished.

Issue: Bash file needs some way to tell API an error message if not finished yet (or general text with red/green mark to indicate completeness)