$songLibrary = (Get-Content '.\songs' | ConvertFrom-Json).data
$score = 0

function Get-RandomSong () {
    $randomIndex = Get-Random -Minimum 0 -Maximum $script:songLibrary.Length
    return $songLibrary[$randomIndex]
    
}

function Get-UserResponse ($Song) {
    return Read-Host "Who sings $($Song.songTitle) (enter q to quit)"
}

function Check-Answer ($Song, $UserResponse) {
    if ($Song.artistTitle.ToLower() -eq $UserResponse.ToLower()) {
        $script:score += 100
        Write-Host "Awesome Job! Your Score is now $script:score"
    }
    else {
        Write-Host "Sorry! The correct artist is $($Song.artistTitle)"
    }
}

function Start-Game () {
    while ($true) {
        $song = Get-RandomSong
        $userResponse = Get-UserResponse -Song $song
        if ($userResponse -eq "q") {
            Write-Host "Thanks for playing..."
            break
        }
        Check-Answer -Song $song -UserResponse $userResponse
    }
}

Start-Game