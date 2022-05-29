const express = require("express");
const mongoose = require('mongoose');
const app = express();
const bodyParser = require("body-parser");
const path = require("path");
const City = require("./model/city.model");
const Trip = require("./model/trip.model");
const multer = require("multer");
const subpath = "/public/assets/images/activities";

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, subpath));
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname)
    }
});

var upload = multer({ storage: storage });

mongoose.set('debug', true);
mongoose.set('useFindAndModify', false);
mongoose.connect("mongodb+srv://admin:admin@dbdyma.z4n28.mongodb.net/dbDyma?retryWrites=true&w=majority", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log('connexion ok!'));

var db = mongoose.connection;
db.on('error', console.error.bind(console, "Erreur de connextion"));
db.once('open', () => console.log("Connection à MongoDB OK"));

app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());
//app.use(bodyParser.json());


app.get("/api/cities", (req, res) => {

    City.find((err, cities) => {
        err ? res.send(err) : res.status(200).json(cities);
    });

});

app.get("/", (req, res) => {
    console.log("GET /");
    res.send("Hello world");
});

app.get("/api/trips", async (req, res) => {
    try {
        const trips = await Trip.find({}).exec();
        return res.json(trips)
    } catch (e) {
        return res.status(500).json(e);
    }
});


app.post("/api/trip", async (req, res) => {
    try {
        const body = req.body;
        const trip = await new Trip(body).save();
        res.json(trip)
        console.log("je suis dans l'api post");
    } catch (e) {
        res.status(500).json(e);
    }
});

app.put("/api/trip", async (req, res) => {
    try {
        const body = req.body;
        const trip = await Trip.findOneAndUpdate({ _id: body._id }, body, { new: true }).exec();
        res.json(trip);

    } catch (e) {
        res.status(500).json(e);
    }
});


app.post("/api/city/:cityId/activity", async (req, res) => {
    try {
        const cityId = req.params.cityId;
        const activity = req.body;
        const city = await City.findByIdAndUpdate({ _id: cityId }, { $push: { activities: activity } }, { new: true }).exec();

        setTimeout(() => {
            res.json(city);
        }, 3000)

    } catch (e) {
        console.log(e);
        res.status(500).json(e);
    }
})

app.get("/api/city/:cityId/activities/verify/:activityName", async (req, res) => {

    const { cityId, activityName } = req.params;
    const city = await City.findById(cityId).exec();
    const index = city.activities.findIndex(activity => activity.name === activityName);
    console.log(activityName);
    index == -1 ? res.json() : res.json("L'activité est déja présente");

});


app.post("/api/activity/image", upload.single("activity"), (req, res, next) => {
    try {
        const publicPath = `http//:localhost/public/assets/images/activities/${req.file.originalname}`;
        res.json(publicPath || 'error');
    } catch (e) {
        next(e);
    }
})


const port = 3001;
const hostname = "127.0.0.1";
//const hostname = "192.168.20.53";
app.listen(port, hostname, function () {
    console.log(`runing on port: ${port}`);
});