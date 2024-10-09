const cds = require("@sap/cds");
const { Products } = cds.entities;

module.exports = (srv) => {
  srv.on("getProducts", async (req) => {
    const products = await SELECT.from(Products);

    const csvHeader = "productID,name,description,price,stock\n";
    const csvRows = products
      .map((product) => {
        return [
          product.productID,
          product.name,
          product.description,
          product.price + " " + product.currency_code,
          product.stock,
        ].join(",");
      })
      .join("\n");

    req.res.set("Content-Type", "text/csv");
    return csvHeader + csvRows;
  });
};
