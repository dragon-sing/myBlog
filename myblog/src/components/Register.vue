<template>
  <el-form :rules="rules" class="login-container" label-position="left"
           label-width="0px" v-loading="loading" :model="RegisterForm">
    <h3 class="login_title">博客注册</h3>
    <el-form-item prop="username">
      <el-input type="text" v-model="RegisterForm.username" auto-complete="off" placeholder="账号"></el-input>
    </el-form-item>

    <el-form-item  prop="password">
      <el-input type="password" v-model="RegisterForm.password" auto-complete="off" placeholder="密码"></el-input>
    </el-form-item>
    <el-form-item  prop="checkPass">
      <el-input type="password" v-model="RegisterForm.checkPass" auto-complete="off" placeholder="确认密码"></el-input>
    </el-form-item>
    <el-form-item prop="email">
      <el-input type="email" v-model="RegisterForm.email" auto-complete="off" placeholder="请输入你的邮箱"></el-input>
    </el-form-item>

    <el-button @click.native.prevent="submitClick" style="width: 100%">注册</el-button>
  </el-form>
</template>

<script>

    import {putRequest} from '../utils/api'


    export default{
      data(){
          let validatePass = (rule, value, callback) => {
            if (value === '') {
              callback(new Error('请输入密码'));
            } else {
              if (this.RegisterForm.checkPass !== '') {
                this.$refs.RegisterForm.validateField('checkPass');
              }
              callback();
            }
          };
          let validatePass2 = (rule, value, callback) => {
            if (value === '') {
              callback(new Error('请再次输入密码'));
            } else if (value !== this.RegisterForm.password) {
              callback(new Error('两次输入密码不一致!'));
            } else {
              callback();
            }
          };
          let validateEmail = (rule,value,callback) => {
            const regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+\.[a-zA-Z0-9_-]+/
            if (value === ''){
              callback(new Error('请输入你的邮箱'));
            } else if (regEmail.test(value)){
              callback();
            }
            else{
              callback("请输入合法的邮箱");
            }
          }
          return {
          rules: {
            username: [{required: true, message: '请输入用户名', trigger: ['blur','change']}],
            password: [
              { validator: validatePass, trigger: ['blur','change']}
            ],
            checkPass: [
              { validator: validatePass2, trigger: ['blur','change'] }
            ],
            email:[{ validator: validateEmail, trigger: ['blur','change']}]
          },
          checked: true,
          RegisterForm: {
            username: '',
            password: '',
            checkPass:'',
            email:'',

          },
          loading: false
        }
      },
      methods: {
        submitClick: function () {
          var _this = this;
          this.loading = true;
          putRequest('/reg', {
            username: this.RegisterForm.username,
            nickname: this.RegisterForm.username,
            password: this.RegisterForm.password,
            email: this.RegisterForm.email
          }).then(resp=> {
            _this.loading = false;
            if (resp.status == 200) {
              //成功
              var json = resp.data;
              if (json.status == 'success') {
                _this.$router.replace({path: '/'});
              } else {
                _this.$alert('注册失败!', '失败!');
              }
            } else {
              //失败
              _this.$alert('注册失败!', '失败!');
            }
          }, resp=> {
            _this.loading = false;
            _this.$alert('找不到服务器⊙﹏⊙∥!', '失败!');
          });
        }
      }
    }
</script>
<style scoped>
</style>
