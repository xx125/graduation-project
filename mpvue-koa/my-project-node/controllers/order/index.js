const { mysql } = require('../../mysql')

async function orderDown (ctx) {
  const { openId } = ctx.request.body
  let goodsId = ctx.request.body.goodsId
  let allPrice = ctx.request.body.allPrice
  let number = ctx.request.body.number

  await mysql('cart').where({
    'user_id': openId
  }).del()

  // var goodsid = goodsId[0].goods_id.split(',')
  // const goods = await mysql('food').where({
  //   'id': goodsid
  // }).select()
  // const { price, name, image } = goods[0]
  const data = await mysql('order').insert({
    user_id: openId,
    goods_id: goodsId,
    allPrice: allPrice,
    number: number
    // price,
    // name,
    // image
  })
  ctx.body = {
    data: '提交成功'
  }
}

async function detailAction (ctx) {
  const openId = ctx.query.openId
  const addressId = ctx.query.addressId || ''

  const orders = await mysql('order').where({
    'user_id': openId
  }).select()

  // var goodId = orderDetail[0].goods_id.split(',')
  // const orders = await mysql('order').andWhere({
  //   'user_id': openId
  // }).whereIn('goods_id', goodId).select()

  // console.log(orders)
  
  // 收货地址
  var addressList;
  if (addressList) {
    addressList = await mysql('address').where({
      'user_id': openId,
      'id': addressId
    }).orderBy('is_default', 'desc').select()
  } else {
    addressList = await mysql('address').where({
      'user_id': openId
    }).orderBy('is_default', 'desc').select()
  }

  ctx.body = {
    address: addressList[0] || {},
    'orders': orders
  }
}

module.exports = {
  orderDown,
  detailAction
}