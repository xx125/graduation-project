<template>
  <div class="mappage">
    <div class="section">
      <input type="text" placeholder="搜索" focus="true" v-model="keywords" @input="bindInput" />
    </div>
    <scroll-view :scroll-y="true" class="addcont" style="height: 500rpx;">
      <div class="result" @touchstart="bindSearch(item.name)" v-for="(item, index) in tips" :key="index">
        {{item.name}}
      </div>
    </scroll-view>

    <div class="map_container">
      <div class="title">显示当前位置：</div>
      <map class="map" id="map" scale="16" :longitude="longitude" :latitude="latitude" :markers="markers"></map>
    </div>
  </div>
</template>

<script>
import amapFile from '../../utils/amap-wx'
import { mapMutations } from 'vuex'
export default {
  data() {
    return {
      tips: [],
      longitude: 0,
      latitude: 0,
      markers: [],
      keywords: ''
    }
  },
  mounted () {
    this.getMapaddress()
  },
  methods: {
    ...mapMutations(['update']),
    getMapaddress () {
      let _this = this
      var myAmapFun = new amapFile.AMapWX({
        key: 'a263c1a01cfeb3e63cd6af2f35901ae4'
      })
      myAmapFun.getRegeo({
        iconPath: "/static/images/marker.png",
        iconWidth: 22,
        iconHeight: 32,
        success: function (data) {
          console.log(data)
          let marker = [
            {
              id: data[0].id,
              latitude: data[0].latitude,
              longitude: data[0].longitude,
              width: data[0].width,
              height: data[0].height
            }
          ]
          _this.markers = marker
          _this.longitude = data[0].longitude
          _this.latitude = data[0].latitude
        },
        fail (info) {
          console.log(info)
        }
      })
    },
    bindInput (e) {
      let _this = this
      let keywords = _this.keywords
      var myAmapFun = new amapFile.AMapWX({
        key: 'a263c1a01cfeb3e63cd6af2f35901ae4'
      })
      myAmapFun.getInputtips({    /* 搜索补全 */
        keywords: keywords,
        location: '',
        success: function (data) {
          // console.log(data)
          if (data && data.tips) {
            _this.tips = data.tips
          }
        }
      })
    },
    bindSearch (cityName) {
      // 非父子组件通信，通过vuex做数据存储
      this.update({cityName: cityName})
      wx.navigateBack({
        delta: 1    /* 1代表回上1个页面 */
      })
    }
  }
}
</script>

<style lang="less" scoped>
@import "./style.less";
</style>