const { mysql } = require('../../mysql')

async function orderDown (ctx) {
  const { openId } = ctx.request.body
  let goodsId = ctx.request.body.goodsId
  let allPrice = ctx.request.body.allPrice

  await mysql('cart').where({
    'user_id': openId
  }).del()

  // const goods = await mysql('food').where({
  //   'id': goodsId
  // }).select()
  // const { price, name, image } = goods[0]
  const data = await mysql('order').insert({
    user_id: openId,
    goods_id: goodsId,
    allPrice: allPrice
    // number: number
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
    address: addressList[0] || {}
  }
}

module.exports = {
  orderDown,
  detailAction
}