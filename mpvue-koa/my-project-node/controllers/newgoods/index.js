const { mysql } = require('../../mysql')

// 获取新品首发列表
async function detailAction (ctx) {
  const openId = ctx.query.openId

  const newgoods = await mysql('food').where({
    'isNew': 1
  }).select()

  ctx.body = {
    'newgoods': newgoods
  }
}

module.exports = {
  detailAction
}