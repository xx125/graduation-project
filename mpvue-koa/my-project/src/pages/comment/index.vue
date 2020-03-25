<template>
  <div class="feedback">
    <div class="title">
      <span>———</span>
      <span>评论</span>
      <span>———</span>
    </div>
    <input class="text" placeholder="请填写评论" v-model="content" />
    <div class="tag">
      <div @click="good(index)" :class="{choose:type=='推荐'}">推荐</div>
      <div @click="bad(index)" :class="{choose:type=='吐槽'}">吐槽</div>
    </div>
    <div>
      <div class="word">请添加图片：</div>
      <img class="add" src="../../../static/images/add_image.png" @click="chooseImage()">
      <!-- 联系方式：<input type="text" placeholder="邮箱/手机号/微信号" class="number" v-model="number"> -->
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
      useravatar: ''
    }
  },
  mounted () {
    this.openId = getStorageOpenid()
    this.username = getStoragenickName()
    this.useravatar = getStorageavatarUrl()
    console.log(this.username)
    console.log(this.useravatar)
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
        rateType: this.type
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
    // chooseImage (e) {
    //   wx.chooseImage({
    //     count: 1,
    //     success: async function(res) {
    //       try {
            
    //         // 将选择到的图片上传到自己的存储空间，假设获取得到的链接为 http://aaa.bbb.ccc/xxx.jpg

    //         const invokeRes = await wx.serviceMarket.invokeService({
    //           service: 'wx79ac3de8be320b71',
    //           api: 'OcrAllInOne',
    //           data: {
    //             img_url: 'http://aaa.bbb.ccc/xxx.jpg',
    //             data_type: 3,
    //             ocr_type: 1
    //           },
    //         })

    //         console.log('invokeService success', invokeRes)
    //         wx.showModal({
    //           title: 'success',
    //           content: JSON.stringify(invokeRes),
    //         })
    //       } catch (err) {
    //         console.error('invokeService fail', err)
    //         wx.showModal({
    //           title: 'fail',
    //           content: err,
    //         })
    //       }
    //     },
    //     fail: function(res) {},
    //     complete: function(res) {},
    //   })
    // }
    // chooseImage(e) {
    //   let i = 0;					// 多图上传时使用到的index
    //   let that = this;
    //   let max = 1;		//最大选择数
    //   let upLength;						//图片数组长度
    //   let imgFilePaths;				//图片的本地临时文件路径列表
    //   wx.chooseImage({
    //     count: max || 1,           //一次最多可以选择的图片张数
    //     sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
    //     sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
    //     success: function (res) {
    //       let len = that.tempFilePaths;
    //       imgFilePaths = res.tempFilePaths;
    //       // upLength = imgFilePaths.length;
    //       // if(len.length > max){
    //       //   that.$mptoast('图片最多只能选择' + max);
    //       //   return false;
    //       // }
    //       /**
    //        * 上传完成后把文件上传到服务器
    //        */
    //       wx.showLoading({
    //         title: '上传中...',
    //       })
    //       that.upLoad(imgFilePaths,i);			//上传操作
    //     },
    //     fail: function () {
    //       console.log('fail');
    //     },
    //     complete: function () {
    //       console.log('commplete');
    //     }
    //   })
    // },
    // upLoad(imgPath,i){
    //   let that = this;
    //   //上传文件
    //   wx.uploadFile({
    //     url: '上传接口',
    //     filePath: imgPath[i],
    //     name: 'img0',
    //     header: {
    //       "Content-Type": "multipart/form-data"
    //     },
    //     success: function (res) {
    //       console.log('上传成功' + i);
    //       // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
    //       that.files = that.files.imgPath;		//合并图片显示数组
    //       let imgData = JSON.parse(res.data);
    //       that.upImg.push(imgData.data);
    //       console.log(that.upImg);
    //     },
    //     fail: function (res) {
    //       console.log(res);
    //       wx.hideLoading();
    //       wx.showModal({
    //         title: '错误提示',
    //         content: '上传图片失败',
    //         showCancel: false,
    //         success: function (res) { }
    //       })
    //     },
    //     // complete: function(){
    //     //   i++;
    //     //   if(i == upLength){
    //     //     wx.hideLoading();    //上传结束，隐藏loading
    //     //   }else{
    //     //     that.upLoad(imgPath,i,upLength);
    //     //   }
    //     // }
    //   });
    // }
  }
}
</script>

<style lang="less" scoped>
@import './style.less';
</style>