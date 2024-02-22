
<#
 Name: Chad Robertson, Samuel Carrasco, Seth Eaby, Alex Santalov
 Date: 21 Feb 2024
 Title: Guess that Artist
 Description: Fun game to test your musical knowledge. Uses the Top 500
 most popular songs according to Rolling Stone Times
#>


<#
 Script variables to store global variables. Initialize variables using
 starting values
#>
$songLibrary = (Get-Content '.\songs' | ConvertFrom-Json).data #Stored as a hashtable
$score = 0
$correctAnswers = @()
$streak = 1
$team = @("Chad Robertson", "Samuel Carrasco", "Seth Eaby", "Alex Santalov")

function Get-RandomSong () {
    $randomIndex = Get-Random -Minimum 0 -Maximum $script:songLibrary.Length
    return $songLibrary[$randomIndex]
    
}

function Get-UserResponse ($Song) {
    return Read-Host "Who sings $($Song.songTitle) (enter q to quit)"
}

function Check-Answer ($Song, $UserResponse) {
    if ($Song.artistTitle.ToLower() -eq $UserResponse.ToLower()) {
        $script:score += $script:streak * 100
        $script:streak++
        $script:correctAnswers += $Song
        Write-Host "
        👏👏👏
        👏     👏
     👏          👏
     👏          👏
       👏      👏
          👏👏
        "
        Write-Host "Your Score is now $script:score (streak $($script:streak -1))" -ForegroundColor Green
    }
    else {
        $script:streak = 1
        Write-Host "Sorry! The correct artist is $($Song.artistTitle)" -ForegroundColor Red
    }
}

function Print-Startup () {
    Write-Host "
    __      __       .__                                  __          
    /  \    /  \ ____ |  |   ____  ____   _____   ____   _/  |_  ____  
    \   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \  \   __\/  _ \ 
     \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/   |  | (  <_> )
      \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >  |__|  \____/ 
           \/       \/          \/            \/     \/                
    " -ForegroundColor Yellow

    Write-Host "
    ________                                __  .__            __       _____          __  .__          __   
    /  _____/ __ __   ____   ______ ______ _/  |_|  |__ _____ _/  |_    /  _  \________/  |_|__| _______/  |_ 
   /   \  ___|  |  \_/ __ \ /  ___//  ___/ \   __\  |  \\__  \\   __\  /  /_\  \_  __ \   __\  |/  ___/\   __\
   \    \_\  \  |  /\  ___/ \___ \ \___ \   |  | |   Y  \/ __ \|  |   /    |    \  | \/|  | |  |\___ \  |  |  
    \______  /____/  \___  >____  >____  >  |__| |___|  (____  /__|   \____|__  /__|   |__| |__/____  > |__|  
           \/            \/     \/     \/             \/     \/               \/                    \/      " -ForegroundColor Yellow
    Write-Host "Made by:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $Script:team.Length; $i++) {
        Write-Host "$($Script:team[$i])" -ForegroundColor Yellow
    }
}
function Start-Game () {
    Print-Startup
    while ($true) {
        $song = Get-RandomSong
        $userResponse = Get-UserResponse -Song $song
        switch ($userResponse) {
            "q" { End-Game }
            Default { Check-Answer -Song $song -UserResponse $userResponse }
        }
    }
}

function End-Game () {
    $isEmptyScore = $Script:correctAnswers.Length -eq 0
    if ($isEmptyScore) {
        Write-Host "
                           /\          /\
                         ( \\        // )
                          \ \\      // /
                           \_\\||||//_/
                            \/ _  _ \
                           \/|(O)(O)|
                          \/ |      |
      ___________________\/  \      /
     //                //     |____|
    //                ||     /      \
   //|                \|     \ 0  0 /
  // \       )         V    / \____/
 //   \     /        (     /
""     \   /_________|  |_/
       /  /\   /     |  ||
      /  / /  /      \  ||
      | |  | |        | ||
      | |  | |        | ||
      |_|  |_|        |_||
       \_\  \_\        \_\\" -ForegroundColor Magenta
    }
    else {
        Write-Host "Here is the list of your correct responses:"
        foreach ($song in $Script:correctAnswers) {
            Write-Host "$($song.songTitle) by $($song.artistTitle)" -ForegroundColor Green
        } 
    }
    Write-Host "Thanks for playing..."
    Exit
}

<#
 Starts the game
#>
Start-Game