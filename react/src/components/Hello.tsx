import * as React from 'react'

/*
//use function components
export interface HelloProps { compiler: string, framework: string }

export const Hello = (props: HelloProps) => <h1>Hello from {props.compiler} and {props.framework}!</h1>
*/

// classier 
export interface HelloProps { compiler: string, framework: string }

export class Hello extends React.Component<HelloProps, {}> {
    render() {
        return <h1>Hello from {this.props.compiler} and {this.props.framework}!</h1>
    }
}