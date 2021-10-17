const express = require('express');

const PORT = process.env.PORT || 3000;

const app = express();





app.get("/", (req, res) => {
    res.send("Hello World! CI/CD Test :)")
})


let reqCounter = 0;
app.get("/count", (req, res) => {
    reqCounter++;
    res.json({"count": "" + reqCounter})
})

app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`)
})
