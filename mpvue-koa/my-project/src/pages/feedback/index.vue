<template>
  <div class="feedback">
    <div class="title">
      <span>———</span>
      <span>意见与反馈</span>
      <span>———</span>
    </div>
    <textarea class="text" cols="30" rows="10" placeholder="请填写你的意见和反馈" v-model="content"></textarea>
    <div class="connect">
      联系方式：<input type="text" placeholder="邮箱/手机号/微信号" class="number" v-model="number">
    </div>
    <button :class="[content !== '' && number !== '' ? 'submit' : 'hide']" @click="submit">提交</button>
  </div>
</template>

<script>
export default {
  data () {
    return {
      content: '',
      number: ''
    }
  },
  methods: {
    submit () {
      wx.showToast({
        title: '提交成功',
        icon: 'success',
        duration: 1500,
        success: (result) => {
          setTimeout(() => {
            wx.navigateBack({
              delta: 1
            }) 
          }, 1000)
        }
      })
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>