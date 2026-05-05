-- SQL cebiche for Recipes Database
-- Versión Mejorada: Español, Favoritos, Comentarios y Recetas Premium

DROP DATABASE IF EXISTS recetas_db;
CREATE DATABASE IF NOT EXISTS recetas_db;
USE recetas_db;

-- Tabla de Recetas
CREATE TABLE IF NOT EXISTS recipes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category ENUM('Food', 'Dessert') NOT NULL,
    description TEXT,
    ingredients TEXT,
    instructions TEXT,
    image_url VARCHAR(500),
    is_premium BOOLEAN DEFAULT FALSE,
    price DECIMAL(10, 2) DEFAULT 0.00,
    rating_sum INT DEFAULT 0,
    rating_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Favoritos
CREATE TABLE IF NOT EXISTS favorites (
    user_id INT,
    recipe_id INT,
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Tabla de Comentarios
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recipe_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Tabla de Compras (Recetas Premium)
CREATE TABLE IF NOT EXISTS purchases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recipe_id INT,
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ratings (
    user_id INT,
    recipe_id INT,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    PRIMARY KEY (user_id, recipe_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- Limpiar datos previos
DELETE FROM recipes;

-- Insertar Recetas en Español
INSERT INTO recipes (title, category, description, ingredients, instructions, image_url, is_premium, price) VALUES
('Spaghetti Carbonara', 'Food', 'Clásica pasta italiana con huevo, queso, panceta y pimienta negra.', 'Spaghetti, Huevos, Queso Pecorino, Panceta, Pimienta Negra', 'Hervir la pasta. Freír la panceta. Mezclar huevos y queso. Combinar todo con un poco de agua de pasta.', 'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Chocolate Lava Cake', 'Dessert', 'Pastel de chocolate decadente con un centro fundido.', 'Chocolate Negro, Mantequilla, Azúcar, Huevos, Harina', 'Derretir chocolate y mantequilla. Batir huevos y azúcar. Incorporar harina. Hornear 12 min a 200C.', 'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Salmón a la Parrilla', 'Food', 'Salmón saludable a la parrilla con limón y hierbas.', 'Filetes de Salmón, Aceite de Oliva, Limón, Ajo, Romero', 'Marinar el salmón. Parrilla 5-6 min por lado. Exprimir limón fresco al final.', 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Cheesecake de Frutos Rojos', 'Dessert', 'Cheesecake cremoso con topping de frutas frescas.', 'Queso Crema, Galletas, Mantequilla, Azúcar, Frutos Rojos', 'Base de galleta. Mezclar crema y azúcar. Hornear y enfriar. Decorar con frutas.', 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Tacos de Res', 'Food', 'Tacos estilo mexicano con carne molida sazonada.', 'Tortillas, Carne Molida, Sazonador, Lechuga, Queso, Salsa', 'Cocinar la carne. Agregar sazonador. Armar los tacos con toppings.', 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Tiramisú Tradicional', 'Dessert', 'Postre italiano con sabor a café y cacao.', 'Bizcochos, Café, Mascarpone, Cacao, Huevos, Azúcar', 'Remojar bizcochos en café. Capas de crema mascarpone. Espolvorear cacao. Refrigerar.', 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Ensalada César con Pollo', 'Food', 'Lechuga romana fresca con pollo a la parrilla.', 'Pollo, Lechuga Romana, Crutones, Parmesano, Aderezo César', 'Parrillar pollo. Mezclar lechuga con aderezo. Servir con pollo y crutones.', 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Pie de Manzana', 'Dessert', 'Pie tibio con corteza crujiente.', 'Manzanas, Harina, Mantequilla, Azúcar, Canela', 'Preparar masa. Sazonar manzanas. Rellenar y hornear hasta dorar.', 'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Risotto de Hongos (Premium)', 'Food', 'El secreto del mejor risotto italiano con trufa negra.', 'Arroz Arborio, Hongos Porcini, Trufa, Caldo de Verduras, Parmesano', 'Tostar el arroz. Agregar caldo poco a poco. Añadir hongos salteados. Mantecar con queso y trufa.', 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?q=80&w=1000&auto=format&fit=crop', TRUE, 15.00),
('Langosta al Termidor (Premium)', 'Food', 'Plato de lujo con carne de langosta en salsa cremosa de brandy.', 'Langosta, Brandy, Crema de Leche, Mostaza Dijon, Queso Gruyer', 'Cocer langosta. Preparar salsa Termidor. Rellenar caparazón y gratinar.', 'https://images.pexels.com/photos/28446393/pexels-photo-28446393.jpeg', TRUE, 45.00),
('Soufflé de Grand Marnier (Premium)', 'Dessert', 'Soufflé francés perfectamente elevado con toque de naranja.', 'Huevos, Azúcar, Grand Marnier, Naranja, Mantequilla', 'Preparar base de naranja. Montar claras a punto de nieve. Mezclar con cuidado. Hornear y servir inmediato.', 'https://images.unsplash.com/photo-1579954115567-dff2eeb6fdeb?q=80&w=1000&auto=format&fit=crop', TRUE, 12.00),
('Bombones de Oro (Premium)', 'Dessert', 'Bombones de chocolate artesanal con láminas de oro comestible.', 'Chocolate Belga, Ganache de Avellana, Oro de 24k', 'Templar chocolate. Rellenar con ganache. Desmoldar y decorar con oro.', 'https://images.unsplash.com/photo-1548907040-4baa42d10919?q=80&w=1000&auto=format&fit=crop', TRUE, 25.00),
('Pollo al Curry', 'Food', 'Aromático curry de pollo con leche de coco y especias indias.', 'Pollo, Leche de Coco, Curry en Polvo, Cebolla, Ajo, Jengibre, Tomate', 'Dorar el pollo. Sofreír cebolla, ajo y jengibre. Añadir curry y tomate. Incorporar leche de coco y cocinar 20 min.', 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Paella Valenciana', 'Food', 'El clásico arroz español con pollo, conejo y verduras.', 'Arroz, Pollo, Conejo, Judías Verdes, Tomate, Pimentón, Azafrán, Aceite de Oliva', 'Dorar las carnes. Sofreír verduras. Añadir pimentón y tomate. Incorporar arroz y caldo. Dejar cocinar sin remover 18 min.', 'https://images.unsplash.com/photo-1534080564583-6be75777b70a?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Hamburguesa Clásica', 'Food', 'Jugosa hamburguesa casera con todos los toppings.', 'Carne Molida, Pan de Hamburguesa, Lechuga, Tomate, Queso Cheddar, Cebolla, Pepinillos, Salsa', 'Formar y sazonar la carne. Cocinar a la parrilla. Montar con toppings al gusto.', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Sopa de Tomate', 'Food', 'Cremosa sopa de tomate asado con albahaca fresca.', 'Tomates, Cebolla, Ajo, Caldo de Verduras, Crema, Albahaca, Aceite de Oliva', 'Asar tomates y cebolla. Licuar con caldo. Colar y calentar con crema. Servir con albahaca.', 'https://images.unsplash.com/photo-1547592166-23ac45744acd?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Pad Thai', 'Food', 'Fideos de arroz salteados al estilo tailandés con gambas.', 'Fideos de Arroz, Gambas, Huevo, Brotes de Soja, Cebollín, Salsa de Tamarindo, Maní', 'Remojar fideos. Saltear gambas y huevo. Añadir fideos y salsa. Decorar con maní y limón.', 'https://images.unsplash.com/photo-1559314809-0d155014e29e?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Pizza Margherita', 'Food', 'Pizza italiana clásica con salsa de tomate y mozzarella fresca.', 'Masa de Pizza, Salsa de Tomate, Mozzarella Fresca, Albahaca, Aceite de Oliva', 'Estirar la masa. Añadir salsa y mozzarella. Hornear a 250°C por 12 min. Decorar con albahaca fresca.', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Ceviche Peruano', 'Food', 'Fresco ceviche de pescado con limón, ají y cilantro.', 'Pescado Blanco, Limón, Ají Amarillo, Cebolla Morada, Cilantro, Sal, Choclo', 'Cortar el pescado en cubos. Marinar con limón 10 min. Mezclar con ají, cebolla y cilantro. Servir frío.', 'https://images.pexels.com/photos/26586571/pexels-photo-26586571.jpeg', FALSE, 0),
('Ramen Japonés', 'Food', 'Sopa japonesa con caldo umami, fideos y huevo marinado.', 'Fideos Ramen, Caldo de Cerdo, Cerdo Chashu, Huevo, Nori, Cebollín, Maíz, Bambú', 'Preparar el caldo 4 horas. Cocinar el cerdo. Marinar los huevos. Montar el ramen con todos los toppings.', 'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Falafel con Hummus', 'Food', 'Croquetas de garbanzo fritas con cremoso hummus casero.', 'Garbanzos, Perejil, Cilantro, Ajo, Comino, Harina, Aceite, Tahini, Limón', 'Procesar garbanzos con hierbas. Formar bolas y freír. Preparar hummus con tahini y limón. Servir juntos.', 'https://images.pexels.com/photos/29177208/pexels-photo-29177208.jpeg', FALSE, 0),
('Lasaña Boloñesa', 'Food', 'Clásica lasaña italiana con ragú de carne y bechamel.', 'Láminas de Pasta, Carne Molida, Tomate Triturado, Bechamel, Parmesano, Zanahoria, Apio', 'Preparar el ragú 1 hora. Hacer la bechamel. Montar capas de pasta, ragú y bechamel. Hornear 40 min.', 'https://images.unsplash.com/photo-1619895092538-128341789043?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Tacos de Camarón', 'Food', 'Tacos con camarones al ajillo, aguacate y pico de gallo.', 'Tortillas, Camarones, Ajo, Aguacate, Tomate, Cebolla, Cilantro, Limón, Chile', 'Saltear camarones con ajo y chile. Preparar pico de gallo. Montar tacos con aguacate y salsa.', 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Pollo a la Naranja', 'Food', 'Muslos de pollo glaseados con reducción de naranja y miel.', 'Muslos de Pollo, Naranja, Miel, Soja, Ajo, Jengibre, Maicena', 'Marinar el pollo con jugo de naranja y soja. Hornear 35 min. Glasear con la reducción de naranja y miel.', 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Brownies de Chocolate', 'Dessert', 'Brownies densos y fudgy con chispas de chocolate.', 'Chocolate Negro, Mantequilla, Azúcar, Huevos, Harina, Cacao, Chispas de Chocolate', 'Derretir chocolate y mantequilla. Batir con azúcar y huevos. Incorporar harina. Hornear 25 min a 180°C.', 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Crepes Suzette', 'Dessert', 'Delicadas crepes francesas con salsa de naranja y mantequilla.', 'Harina, Huevos, Leche, Mantequilla, Naranja, Azúcar, Grand Marnier', 'Preparar la masa y hacer las crepes. Cocinar la salsa de naranja. Flamear las crepes en la salsa.', 'https://images.unsplash.com/photo-1519676867240-f03562e64548?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Panna Cotta de Vainilla', 'Dessert', 'Suave panna cotta italiana con coulis de frutos rojos.', 'Crema de Leche, Azúcar, Gelatina, Vainilla, Frutos Rojos, Limón', 'Calentar crema con azúcar y vainilla. Añadir gelatina. Verter en moldes y refrigerar 4 horas.', 'https://images.pexels.com/photos/15942852/pexels-photo-15942852.jpeg', FALSE, 0),
('Helado de Mango', 'Dessert', 'Cremoso helado de mango natural sin máquina heladera.', 'Mango Maduro, Leche Condensada, Crema de Leche, Limón', 'Licuar el mango. Mezclar con leche condensada y crema batida. Congelar 6 horas removiendo cada 2 horas.', 'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Tarta de Limón', 'Dessert', 'Tarta con crema de limón sedosa y merengue italiano tostado.', 'Harina, Mantequilla, Huevos, Limón, Azúcar, Maicena', 'Preparar la masa quebrada. Hornear en blanco. Rellenar con crema de limón. Cubrir con merengue y tostar.', 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Churros con Chocolate', 'Dessert', 'Crujientes churros españoles con chocolate caliente para mojar.', 'Harina, Agua, Sal, Aceite, Azúcar, Canela, Chocolate Negro, Leche', 'Hervir agua con sal. Incorporar harina. Freír en manga. Pasar por azúcar y canela. Servir con chocolate caliente.', 'https://images.pexels.com/photos/5255955/pexels-photo-5255955.jpeg', FALSE, 0),
('Mousse de Maracuyá', 'Dessert', 'Aireada mousse de maracuyá con base de galleta crujiente.', 'Maracuyá, Leche Condensada, Crema de Leche, Gelatina, Galletas, Mantequilla', 'Preparar base de galleta. Mezclar pulpa de maracuyá con leche condensada y crema batida. Gelatinar y enfriar.', 'https://images.unsplash.com/photo-1587314168485-3236d6710814?q=80&w=1000&auto=format&fit=crop', FALSE, 0),
('Wagyu con Demi-Glace (Premium)', 'Food', 'Solomillo de Wagyu A5 con salsa demi-glace y trompetas de la muerte.', 'Wagyu A5, Trompetas de la Muerte, Fondo de Ternera, Vino Tinto, Mantequilla, Trufa', 'Reposar la carne a temperatura ambiente. Sellar en mantequilla clarificada 2 min por lado. Reposar 5 min. Servir con demi-glace y setas.', 'https://images.pexels.com/photos/36138049/pexels-photo-36138049.jpeg', TRUE, 65.00),
('Bogavante a la Americana (Premium)', 'Food', 'Bogavante bretón en salsa americana con bisque de marisco.', 'Bogavante, Brandy, Tomate, Nata, Estragón, Mantequilla, Cebolla, Zanahoria', 'Trocear el bogavante vivo. Flamear con brandy. Preparar la salsa americana con el coral. Cocinar y montar.', 'https://images.pexels.com/photos/20150644/pexels-photo-20150644.jpeg', TRUE, 55.00),
('Tarta Tatín de Foie (Premium)', 'Food', 'Tarta tatin salada de manzana caramelizada con escalopa de foie gras.', 'Foie Gras Fresco, Manzana Golden, Mantequilla, Azúcar, Hojaldre, Vinagre de Módena', 'Caramelizar las manzanas. Cubrir con hojaldre y hornear. Voltear y coronar con el foie marcado a la plancha.', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000&auto=format&fit=crop', TRUE, 38.00),
('Esfera de Chocolate (Premium)', 'Dessert', 'Esfera de chocolate negro que se derrite con salsa caliente revelando su interior.', 'Chocolate Valrhona, Mousse de Avellana, Praliné, Caramelo Salado, Oro Comestible', 'Moldear las esferas de chocolate. Rellenar con mousse y praliné. Decorar con oro. Servir con salsa caliente en la mesa.', 'https://images.pexels.com/photos/6036361/pexels-photo-6036361.jpeg', TRUE, 22.00),
('Croquembouche (Premium)', 'Dessert', 'Torre de profiteroles rellenos de crema diplomática con caramelo hilado.', 'Pasta Choux, Crema Pastelera, Nata, Azúcar, Almendras, Caramelo', 'Hornear los choux. Rellenar con crema diplomática. Bañar en caramelo y montar en torre. Decorar con caramelo hilado.', 'https://images.pexels.com/photos/14800884/pexels-photo-14800884.jpeg', TRUE, 35.00);
