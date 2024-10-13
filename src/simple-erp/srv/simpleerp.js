const cds = require("@sap/cds");

function calculateItemAmount(req, product, quantity) {
  req.data.itemAmount = product.price * quantity;
  req.data.currency_code = product.currency_code;
}

function checkProductStock(req, product, quantity) {
  if (product.stock < quantity) {
    req.error(
      409,
      `${quantity} exceeds stock for product #${product.productID}`,
      "quantity"
    );
  }
}

async function calculateOrderID(req) {
  const { Orders } = cds.entities;
  const { maxID } = await SELECT.one`max(orderID) as maxID`.from(Orders);
  req.data.orderID = maxID + 1;
}

async function calculateItemID(req, itemDraft) {
  if (!itemDraft.itemID) {
    const { maxID } = await SELECT.one("max(itemID) as maxID")
      .from(req.query.target)
      .where({ order_ID: itemDraft.order_ID });
    req.data.itemID = maxID + 10;
  }
}

function calculateButtonAvailability(res, req, draft = false) {
  const status = res.orderStatus_status;
  res.pickEnabled = draft ? false : status === 10;
  res.shipEnabled = draft ? false : status === 20;
  res.completeEnabled = draft ? false : status === 30;
  res.cancelEnabled = draft ? false : status === 10;
}

async function updateOrderAmount(req, orderToUpdate = "") {
  if (!orderToUpdate) {
    const { order_ID } = await SELECT.one("order_ID")
      .from(req.query.target)
      .where({ ID: req.data.ID });
    orderToUpdate = order_ID;
  }
  const items = await SELECT.from(req.query.target).where({
    order_ID: orderToUpdate,
  });

  let orderAmount = 0;
  let currency_code;
  items.forEach((item) => {
    if (item.itemAmount) {
      orderAmount += item.itemAmount;
      currency_code = item.currency_code;
    }
  });
  return UPDATE("SimpleERPUIService.Orders.drafts", orderToUpdate).with({
    orderAmount,
    currency_code,
  });
}

async function updateProductStock(items) {
  const { Products } = cds.entities;
  if (items) {
    for (let { product_ID, quantity } of items) {
      let product = await SELECT.from(Products, product_ID, (p) => {
        p.productID, p.stock;
      });
      if (product.stock > quantity)
        await UPDATE(Products, product_ID).with({
          stock: (product.stock -= quantity),
        });
      else
        req.error(
          409,
          `${quantity} exceeds stock for product #${product.productID}`,
          "quantity"
        );
    }
  }
}

async function updateOrderStatus(req, newStatus) {
  const currentStatus = await SELECT.one(`orderStatus_status`)
    .from(req.subject)
    .where({ ID: req.data.ID });
  if (currentStatus !== 10 && newStatus === -10) {
    req.error(
      422,
      "Cannot cancel an order that is not in new state.",
      "orderStatus_status"
    );
  } else {
    UPDATE(req.subject).with({ orderStatus_status: newStatus });
  }
}

module.exports = {
  calculateItemAmount,
  checkProductStock,
  calculateItemID,
  calculateOrderID,
  calculateButtonAvailability,
  updateOrderAmount,
  updateProductStock,
  updateOrderStatus,
};
