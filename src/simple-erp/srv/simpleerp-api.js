const cds = require("@sap/cds");
const { Orders, Products } = cds.entities;

module.exports = (srv) => {
  srv.on("getProducts", async (req) => {
    const products = await SELECT.from(Products);

    const header = "productID,name,description,price,stock\n";
    const rows = products
      .map(({ productID, name, description, price, currency_code, stock }) =>
        [productID, name, description, `${price} ${currency_code}`, stock].join(
          ","
        )
      )
      .join("\n");

    req.res.set("Content-Type", "text/csv");
    return header + rows;
  });

  srv.on("products", async (req) => {
    const products = await SELECT.from(Products);
    req.res.set("Content-Type", "application/json");
    return JSON.stringify(products);
  });

  srv.on("orders", async (req) => {
    const orders = await SELECT.from(Orders);
    req.res.set("Content-Type", "application/json");
    return JSON.stringify(orders);
  });

  srv.on("createOrder", async (req) => {
    const erpSrv = await cds.connect.to("SimpleERPService");
    const { Orders } = erpSrv.entities;
    let orderData = req.data.order;
    let order = {};

    order.customer_ID = orderData.customer;
    order.orderDate = orderData.orderDate;
    order.orderAmount = orderData.orderAmount;
    order.currency_code = orderData.currency;
    order.items = orderData.items.map((item) => ({
      product_ID: item.productID,
      quantity: item.quantity,
      itemAmount: item.itemAmount,
      currency_code: item.currencyCode,
    }));
    await erpSrv.run(INSERT(order).into(Orders));
  });
};
