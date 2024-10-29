use Win32::GUI;

$folder=Win32::GUI::BrowseForFolder(
   -root=>"c:\\",
   -includefiles=>1
   );
   