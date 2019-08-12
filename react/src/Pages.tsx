import * as React from 'react'
import { Auth } from 'aws-amplify'

export const Home = () => <h1>Home Page</h1>
export const Foo = () => <h1>Foo Page</h1>
export const Bar = () => {
    const handleClick = async (e: React.MouseEvent) => {
        e.preventDefault()
        await Auth.signOut()
    }
    return (
        <a href='#' onClick={handleClick}>
            Click
        </a>
    )
}