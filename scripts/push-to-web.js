const { exec } = require('child_process');

require('dotenv').config();

const API_KEY = process.env.API_KEY;
const API_SECRET = process.env.API_SECRET

exec(`docker run --rm -v $PWD/workspace:/usr/local/structurizr structurizr/cli push -id 80820 -key ${API_KEY} -secret ${API_SECRET} -workspace workspace.dsl`
, (error, stdout, stderr) => {
  if (error) {
    console.log(`error: ${error.message}`);
    return;
  }
  if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
  }
  console.log(`stdout: ${stdout}`);
})