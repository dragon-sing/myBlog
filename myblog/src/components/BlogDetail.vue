<template>
  <el-row v-loading="loading">
    <el-col :span="24">
      <div style="text-align: left;">
        <el-button type="text" icon="el-icon-back" @click="goBack" style="padding-bottom: 0px;">返回</el-button>
      </div>
    </el-col>
    <el-col :span="24">
      <div>
        <div><h1 style="margin-top: 0px;margin-bottom: 0px">{{article.title}}</h1></div>
        <div style="width: 100%;margin-top: 5px;display: flex;justify-content: flex-end;align-items: center">
          <div style="display: inline; color: #20a0ff;margin-left: 50px;margin-right:20px;font-size: 12px;">
            {{article.nickname}}
          </div>
          <span style="color: #20a0ff;margin-right:20px;font-size: 12px;">浏览 {{article.pageView==null?0:article.pageView}}</span>
          <span style="color: #20a0ff;margin-right:20px;font-size: 12px;"> {{article.editTime | formatDateTime}}</span>
          <el-tag type="success" v-for="(item,index) in article.tags" :key="index" size="small"
                  style="margin-left: 8px">{{item.tagName}}
          </el-tag>
          <span style="margin:0px 50px 0px 0px"></span>
        </div>
      </div>
    </el-col>
    <el-col>
      <div style="text-align: left" v-html="article.htmlContent">
      </div>
    </el-col>
    <h4>评论区</h4>
  <div class="container">
    <div class="comment" v-for="item in commentData">
      <div class="info">
        <div class="right">
          <div class="name">{{item.username}} : {{item.content}}</div>
          <div class="date" >{{item.publishDate | formatDate}}</div>
        </div>
      </div>


    </div>
    <transition name="fade">
      <div class="input-wrapper" >
        <el-input class="gray-bg-input"
                  v-model="inputComment"
                  type="textarea"
                  :rows="3"
                  autofocus
                  placeholder="写下你的评论">
        </el-input>
        <div class="btn-control">
          <span class="cancel" @click="">取消</span>
          <el-button class="btn" type="success" @click="commitComment">确定</el-button>
        </div>
      </div>
    </transition>
  </div>
  </el-row>

</template>
<script>
  import {getRequest, postRequest} from '../utils/api'
  import  Comment from '@/components/Comment'
  import {isNotNullORBlank} from "../utils/utils";

  export default{
    methods: {
      goBack(){
        this.$router.go(-1);
      },
      commitComment(){
        let _this = this;
        var aid = this.$route.query.aid;
        if (!(isNotNullORBlank(_this.inputComment, ))) {
          this.$message({type: 'error', message: '评论不能为空!'});
          return;
        }
        postRequest("/comment/", {
          aid: _this.article.id,
          content:_this.inputComment,
        }).then(resp=> {
          if (resp.status == 200 && resp.data.status == 'success') {
            location. reload();
            this.$router.go(0);
            }

        }, resp=> {
          _this.loading = false;
          _this.$message({type: 'error', message: '评论失败!'});
        })
      },
      }
    ,
    mounted: function () {
      var aid = this.$route.query.aid;
      this.activeName = this.$route.query.an
      var _this = this;
      this.loading = true;
      getRequest("/article/" + aid).then(resp=> {
        if (resp.status == 200) {
          _this.article = resp.data;
        }
        _this.loading = false;
      }, resp=> {
        _this.loading = false;
        _this.$message({type: 'error', message: '页面加载失败!'});
      });
      getRequest("/");
      getRequest("/comment/"+aid).then(resp=> {
        if(resp.status == 200){
          _this.commentData = resp.data;
        }}, resp=> {
          _this.$message({type: 'error', message: '页面加载失败!'})
        }
      );
    },
    data(){
      return {
        article: {},
        loading: false,
        activeName: '',
        commentData:[],
        inputComment:''
      }
    },
    components:{
       'comment':Comment
    }
  }
</script>
<style scoped lang="scss">
  $color-main: #409EFF;
  $color-success: #67C23A;
  $color-warning: #E6A23C;
  $color-danger: #F56C6C;
  $color-info: #909399;

  $text-main: #303133;
  $text-normal: #606266;
  $text-minor: #909399;  //次要文字
  $text-placeholder: #C0C4CC;
  $text-333: #333;

  $border-first: #DCDFE6;
  $border-second: #E4E7ED;
  $border-third: #EBEEF5;
  $border-fourth: #F2F6FC;

  $content-bg-color: #fff;
  .container {
    padding: 0 10px;
    box-sizing: border-box;
    .comment {
      display: flex;
      flex-direction: column;
      padding: 10px;
      border-bottom: 1px solid $border-fourth;
      .info {
        display: flex;
        /*align-items: center;*/
        .avatar {
          border-radius: 50%;
        }
        .right {
          display: flex;
          flex-direction: column;
          margin-left: 10px;
          .name {
            font-size: 16px;
            color: $text-main;
            margin-bottom: 5px;
            font-weight: 500;
          }
          .date {
            font-size: 12px;
            color: $text-minor;
          }
        }
      }
      .content {
        font-size: 16px;
        color: $text-main;
        line-height: 20px;
        /*padding: 10px 0;*/
      }
      .control {
        display: flex;
        align-items: center;
        font-size: 14px;
        color: $text-minor;
        .like {
          display: flex;
          align-items: center;
          margin-right: 20px;
          cursor: pointer;
          &.active, &:hover {
            color: $color-main;
          }
          .iconfont {
            font-size: 14px;
            margin-right: 5px;
          }
        }
        .comment-reply {
          display: flex;
          align-items: center;
          cursor: pointer;
          &:hover {
            color: $text-333;
          }
          .iconfont {
            font-size: 16px;
            margin-right: 5px;
          }
        }

      }
      .reply {
        margin: 10px 0;
        border-left: 2px solid $border-first;
        .item {
          margin: 0 10px;
          padding: 10px 0;
          border-bottom: 1px dashed $border-third;
          .reply-content {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: $text-main;
            .from-name {
              color: $color-main;
            }
            .to-name {
              color: $color-main;
              margin-left: 5px;
              margin-right: 5px;
            }
          }
          .reply-bottom {
            display: flex;
            align-items: center;
            margin-top: 6px;
            font-size: 12px;
            color: $text-minor;
            .reply-text {
              display: flex;
              align-items: center;
              margin-left: 10px;
              cursor: pointer;
              &:hover {
                color: $text-333;
              }
              .icon-comment {
                margin-right: 5px;
              }
            }
          }
        }
        .write-reply {
          display: flex;
          align-items: center;
          font-size: 14px;
          color: $text-minor;
          padding: 10px;
          cursor: pointer;
          &:hover {
            color: $text-main;
          }
          .el-icon-edit {
            margin-right: 5px;
          }
        }
        .fade-enter-active, fade-leave-active {
          transition: opacity 0.5s;
        }
        .fade-enter, .fade-leave-to {
          opacity: 0;
        }
        .input-wrapper {
          padding: 10px;
          .gray-bg-input, .el-input__inner {
            /*background-color: #67C23A;*/
          }
          .btn-control {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding-top: 10px;
            .cancel {
              font-size: 16px;
              color: $text-normal;
              margin-right: 20px;
              cursor: pointer;
              &:hover {
                color: $text-333;
              }
            }
            .confirm {
              font-size: 16px;
            }
          }
        }
      }
    }
  }


</style>
