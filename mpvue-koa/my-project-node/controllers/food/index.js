const { mysql } = require('../../mysql')

async function foodDetail (ctx) {
  const goodsId = ctx.query.goodsId
  const openId = ctx.query.openId

  const list = await mysql('list').orderBy('id', 'asc').select()

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
    // goods
    // 'showdom': showdom
  }
}

async function currentAction(ctx) {
  const { name: name } = ctx.query

  // const data =  {}
  // const currentOne = await mysql('list').where({
  //   'id': categoryId
  // }).select()
  // const subList = await mysql('list').where({
  //   'id': currentOne[0].id
  // }).select()
  // data.currentOne = currentOne[0]
  // data.currentOne.subList = subList

  const goods = await mysql('food').where({
    'foodType': name
  }).select()

  ctx.body = {
    'goods': goods
  }
}

module.exports = {
  foodDetail,
  currentAction
}