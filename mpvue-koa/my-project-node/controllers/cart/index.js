const { mysql } = require('../../mysql')

async function addCart (ctx) {
  const { openId, goodsId, number } = ctx.request.body

  // 判断购物车是否已含有该商品
  const haveGoods = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).select()

  if (haveGoods.length === 0) {
    const goods = await mysql('food').where({
      'id': goodsId
    }).select()
    // console.log(goods)
    // 如果不存在
    const { price, name, image } = goods[0]
    await mysql('cart').insert({
      'user_id': openId,
      'goods_id': goodsId,
      'goods_name':name,
      number,
      price,
      image
    })
  } else {
    const oldNumber = await mysql('cart').where({
      'user_id': openId,
      'goods_id': goodsId
    }).column('number').select()
    await mysql('cart').where({
      'user_id': openId,
      'goods_id': goodsId
    }).update({
      'number': oldNumber[0].number + 1
    })
  }
  ctx.body = {
    data: 'add'
  }
}

async function reduceCart (ctx) {
  const { openId, goodsId, number } = ctx.request.body
  const oldNumber = await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).column('number').select()
  await mysql('cart').where({
    'user_id': openId,
    'goods_id': goodsId
  }).update({
    'number': oldNumber[0].number - 1
  })
  ctx.body = {
    data: 'reduce'
  }
}

async function detailAction (ctx) {
  const openId = ctx.query.openId

  const carts = await mysql('cart').where({
    'user_id': openId
  }).select()
  ctx.body = {
    'carts': carts
  }
}

module.exports = {
  addCart,
  reduceCart,
  detailAction
}