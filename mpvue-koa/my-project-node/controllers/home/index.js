const { mysql } = require('../../mysql')

module.exports = async (ctx) => {
  // 轮播图数据
  const banner = await mysql('swiper_ad').where({
    adType: 1
  }).select()

  // 推荐
  const recommend = await mysql('recommend').orderBy('id', 'asc').limit(4).select()

  // 新品首发
  const newGoods = await mysql('food').where({
    isNew: 1
  }).orderBy('id', 'asc').limit(4).select()

  ctx.body = {
    'banner': banner,
    'recommend': recommend,
    'newGoods': newGoods
  }
}
