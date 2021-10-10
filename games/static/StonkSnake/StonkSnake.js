var canvas, rect,
    mx, my,
    held = false,
    snake = [];

var sHead = new Image(),
    sBody = new Image(),
    sTail = new Image();

sHead.src = 'shead.png';
sBody.src = 'sbody.png';
sTail.src = 'stail.png';

function draw() {
	if (!canvas.getContext) return;
	ctx = canvas.getContext('2d');

	ctx.clearRect(0, 0, canvas.width, canvas.height)

	ctx.drawImage(sHead, snake[0][0], snake[0][1]);
	for (let s in snake.slice(1, -1))
		ctx.drawImage(sBody, s[0], s[1]);
	ctx.drawImage(sTail, snake[snake.length-1][0], snake[snake.length-1][1]);

	if (held) {
		snake.shift();
		snake.push([mx, my]);
	}

	window.requestAnimationFrame(draw);
}

function onload() {
	canvas = document.getElementById('canvas');
	rect = canvas.getBoundingClientRect();

	for (let i = 0; i < 3; i++)
		snake.push([0, 0]);

	canvas.addEventListener('mousedown', (e) => {held = true});
	canvas.addEventListener('mouseup', (e) => {held = false});

	canvas.addEventListener('mousemove', (e) => {
		mx = e.clientX - rect.left;
		my = e.clientY - rect.top;
	});

	window.requestAnimationFrame(draw);
}
