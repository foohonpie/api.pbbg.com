import Vue from 'vue'
import Vuex from 'vuex'
import VuexORM from '@vuex-orm/core'
import ormDatabase from './ormDatabase'
import { api } from '../api'
import { CONFIRM_PASSWORD, EMAIL, NAME, PASSWORD } from '@/formDescriptors'

Vue.use(Vuex)

export const SUBMITTED_USER_REGISTER_ACTION = 'SUBMITTED_USER_REGISTER_ACTION'
export const SUBMITTED_USER_LOGIN_ACTION = 'SUBMITTED_USER_LOGIN_ACTION'
// const UPDATE_USER_MUTATION = 'UPDATE_USER_MUTATION'

const store = new Vuex.Store({
  plugins: [VuexORM.install(ormDatabase)],
  state: {
    user: null,
    token: null,
  },
  actions: {
    async [SUBMITTED_USER_LOGIN_ACTION]({ commit }, formData) {
      await api.post('/auth/login', JSON.stringify({
        email: formData[EMAIL],
        password: formData[PASSWORD],
      })).then(({ data }) => {
        commit('SET_ACCESS_TOKEN', data.access_token)
      })
      // commit(UPDATE_USER_MUTATION, )
    },
    async [SUBMITTED_USER_REGISTER_ACTION](context, formData) {
      await api.post('/auth/register', JSON.stringify({
        name: formData[NAME],
        email: formData[EMAIL],
        password: formData[PASSWORD],
        password_confirmation: formData[CONFIRM_PASSWORD],
      }))
    },
  },
  mutations: {
    SET_ACCESS_TOKEN(state, token) {
      state.token = token
    },
  },
})

export default store
