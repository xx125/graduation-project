const { mysql } = require('../../mysql')


async function addComment (ctx) {
  const { username, useravatar, content, rateType, foodId, commImg, rateTime } = ctx.request.body

  // 添加评论
  const data = await mysql('comments').insert({
    foodId: foodId,
    username: username,
    useravatar: useravatar,
    rateType: rateType,
    text: content,
    commImg: commImg,
    rateTime: rateTime
  })
  if (data) {
    ctx.body = {
      data: true
    }
  } else {
    ctx.body = {
      data: false
    }
  }
}

module.exports = {
  addComment
}