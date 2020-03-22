const { mysql } = require('../../mysql')

async function foodDetail (ctx) {
  const goodsId = ctx.query.goodsId
  const openId = ctx.query.openId

  const list = await mysql('list').orderBy('id', 'asc').select()
  const goods = await mysql('food').select()

  // 判断是否在购物车里
  // const iscart = await mysql('cart').where({
  //   'user_id': openId,
  //   'goods_id': goodsId
  // }).select()
  // let showdom = false
  // if (iscart.length > 0) {
  //   showdom = true
  // }

  ctx.body = {
    list,
    goods,
    // 'showdom': showdom
  }
}


module.exports = {
  foodDetail
}