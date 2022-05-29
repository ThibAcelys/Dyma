const mongoose = require("mongoose");
const City = require("./model/city.model");


mongoose.connect("mongodb+srv://admin:admin@dbdyma.z4n28.mongodb.net/dbDyma?retryWrites=true&w=majority", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => {
    Promise.all([
        new City({
            name: 'Paris',
            image: 'http://10.0.2.2/public/assets/images/villes/Paris.jpg',
            activities: [
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/louvre.jpg',
                    name: 'Louvre',
                    id: 'a1',
                    city: 'Paris',
                    price: 12.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/chaumont.jpg',
                    name: 'Chaumont',
                    id: 'a2',
                    city: 'Paris',
                    price: 0.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/notreDame.jpg',
                    name: 'Notre Dame',
                    id: 'a3',
                    city: 'Paris',
                    price: 15.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/laDefense.jpg',
                    name: 'La Défense',
                    id: 'a4',
                    city: 'Paris',
                    price: 0.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/BFM.jpg',
                    name: 'Bibliothèque François Miterrand',
                    id: 'a5',
                    city: 'Paris',
                    price: 1.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/jeuPaume.jpg',
                    name: 'jeu de Paume',
                    id: 'a6',
                    city: 'Paris',
                    price: 11.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/paris/tourEiffel.jpg',
                    name: 'La Tour Eiffel',
                    id: 'a7',
                    city: 'Paris',
                    price: 21.00,
                },
                {
                    image: "https://upload.wikimedia.org/wikipedia/commons/c/ce/Galerie_nationale_du_Jeu_de_Paume.jpg",
                    name: "jeu de Paume",
                    id: 'a8',
                    city: "Paris",
                    price: 11,
                }
            ],
        }).save(),
        new City({
            name: 'Lyon',
            image: 'http://10.0.2.2/public/assets/images/villes/Lyon.jpg',
            activities: [
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/lyon/bellecourt.jpg',
                    name: 'Place Bellecourt',
                    id: 'a8',
                    city: 'Lyon',
                    price: 0.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/lyon/cat_st_jean.jpg',
                    name: 'Cathédrale de Saint-Jean',
                    id: 'a9',
                    city: 'Lyon',
                    price: 1.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/lyon/musee_beaux_art.jpg',
                    name: 'Musée des beaux Arts',
                    id: 'a10',
                    city: 'Lyon',
                    price: 10.00,
                },
            ],
        }).save(),
        new City({
            name: 'Nice',
            image: 'http://10.0.2.2/public/assets/images/villes/Nice.jpg',
            activities: [
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/nice/anglais.jpg',
                    name: 'Promenade des Anglais',
                    id: 'a11',
                    city: 'Nice',
                    price: 0.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/nice/carnaval.jpg',
                    name: 'Carnaval de Nice',
                    id: 'a12',
                    city: 'Nice',
                    price: 0.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/nice/matisse.jpg',
                    name: 'Musée Matisse',
                    id: 'a13',
                    city: 'Nice',
                    price: 10.00,
                },
                {
                    image: 'http://10.0.2.2/public/assets/images/activities/nice/parc_chateau.jpg',
                    name: 'Parc du Château',
                    id: 'a14',
                    city: 'Nice',
                    price: 1.00,
                },
            ],
        }).save()]).then(
            res => {
                console.log("data installed");
                mongoose.connection.close();
            });
});