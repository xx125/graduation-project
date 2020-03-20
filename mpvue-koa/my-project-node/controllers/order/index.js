const { mysql } = require('../../mysql')

async function submitAction (ctx) {
  const { openId } = ctx.request.body
  let goodsId = ctx.request.body
  let allPrice = ctx.request.allPrice

  // 是否存在订单
  const isOrder = await mysql('cart').where({
    'user_id': openId
  }).select
  if (isOrder.length > 0) {
    const data = await mysql('cart').where({
      'user_id': openId
    }).update({
    user_id: openId,
    goods_id:goodsId,
    price: allPrice
    })
  }
}

module.exports = {
  submitAction
}