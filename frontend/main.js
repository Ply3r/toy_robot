const faceMap = ['NORTH', 'EAST', 'SOUTH', 'WEST']
const robot = { position: [0, 0], face: 0 }
const gridElement = document.getElementById('grid');

const createGrid = () => {
  for (let x = 0; x < 5; x += 1) {
    for (let y = 0; y < 5; y += 1) {
      const gridItem = document.createElement('div');
      gridItem.id = `${y}${x}`;
      gridItem.className = 'grid-item';
  
      gridItem.addEventListener('click', () => {
        execCommand(`place ${y},${x},${faceMap[robot.face]}`)
      })
  
      gridElement.appendChild(gridItem)
    }
  }
}

const execCommand = (command) => {
  axios({ method: 'post', url: `http://localhost:4567/exec_command?command=${command}` })
    .then(({ data }) => {
      console.log(data);
      robot.position = data.position;
      robot.face = data.face;
      placeRobot();
    })
}

const placeRobot = () => {
  const old_element = document.getElementsByClassName('robot');
  Array.from(old_element).forEach((el) => el.classList.remove('robot'))

  const element = document.getElementById(`${robot['position'][0]}${robot['position'][1]}`);
  element.className += ' robot'
  element.style.transform = `rotate(${robot.face * 90}deg)`
}

const addEventsToButtons = () => {
  const move = document.getElementById('move');
  move.addEventListener('click', () => execCommand('move') )
  const left = document.getElementById('left');
  left.addEventListener('click', () => execCommand('left') )
  const right = document.getElementById('right');
  right.addEventListener('click', () => execCommand('right') )
}

const start = async () => {
  await execCommand('report');
  createGrid();
  placeRobot();
  addEventsToButtons();
}

start();

