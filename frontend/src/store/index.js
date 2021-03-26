import Vue from 'vue'
import Vuex from 'vuex'
import VuexORM from '@vuex-orm/core'
import ormDatabase from './ormDatabase'
import { api } from '../api'

Vue.use(Vuex)

export const SUBMITTED_USER_LOGIN_ACTION = 'SUBMITTED_USER_LOGIN_ACTION'
// const UPDATE_USER_MUTATION = 'UPDATE_USER_MUTATION'

const store = new Vuex.Store({
  plugins: [VuexORM.install(ormDatabase)],
  state: {
    user: null,
  },
  actions: {
    async [SUBMITTED_USER_LOGIN_ACTION](context, formData) {
      await api.post('/login', formData)
      // commit(UPDATE_USER_MUTATION, )
    },
  },
  mutations: {},
})

export default store
