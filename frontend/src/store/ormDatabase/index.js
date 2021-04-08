import { Database } from '@vuex-orm/core'
import User from './models/User'

const ormDatabase = new Database()

ormDatabase.register(User)

export default ormDatabase
