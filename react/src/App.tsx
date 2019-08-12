import * as React from 'react'
import { BrowserRouter as Router, Route, Link, Switch } from 'react-router-dom'
import Amplify, { Auth } from 'aws-amplify'
import { withAuthenticator } from 'aws-amplify-react'

import {Home, Foo, Bar} from './Pages'

Amplify.configure({
  Auth: {
    region: 'ap-northeast-1',
    userPoolId: 'ap-northeast-1_TAR5FgQvy',
    userPoolWebClientId: 'ktnvum1chnsptn7ej9dl9kshk',
  }
})

const signUpConfig = {
  header: 'ユーザー登録',
  hideAllDefaults: true,
  defaultCountryCode: '81',
  signUpFields: [
    {
      label: 'E-mail',
      key: 'username',
      required: true,
      displayOrder: 1,
      type: 'string'
    },
    {
      label: 'Password',
      key: 'password',
      required: true,
      displayOrder: 2,
      type: 'password'
    }
  ]
}

class App extends React.Component {
  render() {
    return (
      <Router>
        <div>
          <nav>
            <Link to="/">Home</Link>
            <Link to="/foo">Foo</Link>
            <Link to="/bar">Bar</Link>
          </nav>
          <Switch>
            <Route exact path="/" component={Home} />
            <Route exact path="/foo" component={Foo} />
            <Route exact path="/bar" component={Bar} />
          </Switch>
        </div>
      </Router>
    )
  }
}

// export { App }
export default withAuthenticator(App, { signUpConfig })
