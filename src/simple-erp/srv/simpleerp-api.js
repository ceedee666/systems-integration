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
    const orders = await SELECT.from(Orders).columns((c) => {
      c.orderID,
        c.customer_ID`as customer`,
        c.orderDate,
        c.orderAmount,
        c.currency_code`as currency`,
        c.orderStatus_status`as orderStatus`
        c.items((i) => {
          i.itemID,
          i.product_ID`as product`,
          i.quantity,
          i.itemAmount,
          i.currency_code`as currency`;
        });
    });
    req.res.set("Content-Type", "application/json");
    return orders;
  });

  srv.on("createOrder", async (req) => {
    const erpSrv = await cds.connect.to("SimpleERPService");
    const { Orders } = erpSrv.entities;
    const orderReq = req.data.order;
    const newOrder = {};

    newOrder.customer_ID = orderReq.customer;
    newOrder.orderDate = orderReq.orderDate;
    newOrder.orderAmount = orderReq.orderAmount;
    newOrder.currency_code = orderReq.currency;
    newOrder.items = orderReq.items.map((item) => ({
      product_ID: item.product,
      quantity: item.quantity,
      itemAmount: item.itemAmount,
      currency_code: item.currency,
    }));
    await erpSrv.run(INSERT(newOrder).into(Orders));
  });
};
