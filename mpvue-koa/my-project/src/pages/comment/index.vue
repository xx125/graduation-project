<template>
  <div class="feedback">
    <div class="title">
      <span>———</span>
      <span>评论</span>
      <span>———</span>
    </div>
    <input class="text" placeholder="请填写评论" v-model="content" />
    <div class="tag" @click="addDate">
      <div @click="good(index)" :class="{choose:type=='推荐'}">推荐</div>
      <div @click="bad(index)" :class="{choose:type=='吐槽'}">吐槽</div>
    </div>
    <div>
      <div class="word">请添加图片：</div>
      <div v-if="image==''">
        <img class="add" src="../../../static/images/add_image.png" @click="chooseImage()">
      </div>
      <div v-else>
        <img class="img" :src="image[0]">
      </div>
    </div>
    <button :class="[content !== '' ? 'submit' : 'hide']" @click="submit">提交</button>
  </div>
</template>

<script>
import { get, post, getStorageOpenid, getStoragenickName, getStorageavatarUrl } from '../../utils'

export default {
  data () {
    return {
      openId: '',
      type: '',
      id: '',
      content: '',
      username: '',
      useravatar: '',
      image: [],
      nowdate: '',
      rateTime: ''
    }
  },
  mounted () {
    Object.assign(this.$data, this.$options.data())
    this.openId = getStorageOpenid()
    this.username = getStoragenickName()
    this.useravatar = getStorageavatarUrl()
    // console.log(this.username)
    // console.log(this.useravatar)
  },
  methods: {
    good (index) {
      this.type = '推荐'
    },
    bad (index) {
      this.type = '吐槽'
    },
    async submit () {
      this.id = this.$root.$mp.query.id
      const data = await post('/comment/addComment', {
        foodId: this.id,
        username: this.username,
        useravatar: this.useravatar,
        content: this.content,
        rateType: this.type,
        commImg: this.image[0],
        rateTime: this.nowdate
      })
      console.log(data)
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
    },
    chooseImage (e) {
      var that = this
      wx.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'],
        sourceType: ['album', 'camera'],
        success (res) {
          // tempFilePath可以作为img标签的src属性显示图片
          const tempFilePaths = res.tempFilePaths
          that.image = tempFilePaths
          console.log(tempFilePaths)
        }
      })
    },
    addDate() {
      var date = new Date();
      var seperator1 = "-";
      var year = date.getFullYear();
      var month = date.getMonth() + 1;
      var strDate = date.getDate();
      if (month >= 1 && month <= 9) {
        month = "0" + month;
      }
      if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
      }
      var currentdate = year + seperator1 + month + seperator1 + strDate;
      this.nowdate = currentdate
      console.log(this.nowdate)
    }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>