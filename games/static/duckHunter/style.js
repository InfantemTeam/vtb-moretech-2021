window.onload = function() {
    game = document.getElementById("game");
    level = document.getElementById("level");
    // game.innerHTML+="<img id='duck' src='aim.png'>";
    document.addEventListener("click",clickedPos);
    randomDuck();
}
let score = 0;
let lastDuck = 0;
let posArray = [];
let idArray = [];

function randomDuck() {
    let startHeight = Math.floor(Math.random()*100);
    let finishHeight = 100-startHeight;

    // let duck = "<img src='duck.jpg' class='duck' style='left:0%;top:"+startHeight+"%'>";
    let duck = document.createElement('img');
    duck.src = 'duck.jpg';
    duck.style.top = startHeight+"%";
    let min = 3,
    max = 7;
    let rand = Math.floor(Math.random() * (max - min + 1) + min); //Generate Random number between 5 - 10
    duck.className = "duck";
    duck.setAttribute("onclick","Clicked("+(lastDuck++)+")");
    game.appendChild(duck);
    console.log(document.getElementsByClassName("duck"));
    setTimeout(function() {
        let tmp = document.getElementsByClassName("duck");
        tmp[tmp.length-1].style.left = "100%";
        tmp[tmp.length-1].style.top = finishHeight+"%";
    },100);
    setTimeout(randomDuck, rand * 1000);
    setTimeout(function() {
        game.removeChild(duck);
    },5050);
}

function ApplyInfo(a = water) {
    
}

window.Clicked = function(x) {
    idArray.push(x);

    if(idArray.length==1){ // target it 
    }
    else {
        if(idArray[0]==idArray[1]) {
            // kill it
        }
        else {
            //retarget
        }
    }
    if(idArray.length==posArray.length){
        console.log("pass");
    } else {
        console.log("wtf");
        console.log(idArray,posArray);
    }
}
function clickedPos(event){
    posArray.push([event.clientX,event.clientY]);
}

function updateScore(n) {
    let scoreEl = document.getElementById("score");
    scoreEl.innerHTML = "score: "+n;
}

window.ShowRules = function() {
    document.getElementById("rules-page").style.display = "block";
    setTimeout(function() {
        document.getElementById("rules-page").style.opacity = "1";
    },50);
}

window.HideRules = function() {
    setTimeout(function() {
        document.getElementById("rules-page").style.display = "none";
    },500);
    document.getElementById("rules-page").style.opacity = "0";
}