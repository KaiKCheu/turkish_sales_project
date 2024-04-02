CREATE table retail.locations (
	shopping_mall VARCHAR(50),
    latitude DECIMAL(7,5),
    longitude DECIMAL(7, 5),
    address VARCHAR(250),
    City VARCHAR(250),
    Country VARCHAR(20)
);

DROP TABLE retail.locations;

INSERT INTO retail.locations (shopping_mall, latitude, longitude, address, city, country)
VALUES ('Kanyon', 41.07828, 29.01069, 'Levent, Büyükdere Cd. No:185', 'Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Forum Istanbul', 41.04767, 28.89688, 'Kocatepe, Paşa Cd, 34045',  'Bayrampasa/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Metrocity', 41.07635, 29.01353, 'Levent, Büyükdere Cd. No:171, 34330', 'Besiktas/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Emaar Square Mall', 41.00366, 29.07134, 'Unalan, Libadiye Cd. No:88, 34700', 'Uskudar/İstanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Metropol AVM', 40.99586, 28.86267, 'Bahçelievler Merkez, D-100 Yanyolu, 34180',  'Bahcelievler/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Mall of Istanbul', 41.06263, 28.80780, 'Ziya Gökalp, Süleyman Demirel Blv No:7, 34490', 'Ikitelli Osb/Basaksehir/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Istinye Park', 41.11052, 29.03321, 'Pınar, Katar Cd No:11, 34460',  'Sariyer/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Cevahir AVM', 41.06324, 28.99245, '19 Mayıs, Büyükdere Cd. No:22, 34360', 'Sisli/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Viaport Outlet', 40.93834, 29.32353, 'Yenişehir, Dedepaşa Cd No:19, 34912', 'Pendik/Istanbul', 'Turkiye');

INSERT INTO retail.locations (shopping_mall,  latitude, longitude, address, city, country)
VALUES ('Zorlu Center', 41.06712, 29.01553, 'Levazım, Vadi Caddesi Zorlu Center No:2, 34340' , 'Besiktas/Istanbul', 'Turkiye');

SELECT * FROM retail.locations;

SELECT c.shopping_mall, c.invoice_no, c.customer_id, c.gender, c.age, c.category, c.price, c.payment_method, c.invoice_date, c.shopping_mall, l.latitude, l.longitude, l.address, l.City, l.Country FROM retail.customer_shopping_data c
LEFT JOIN retail.locations l
ON c.shopping_mall = l.shopping_mall;


