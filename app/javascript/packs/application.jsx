import * as React from "react";
import ReactDOM from 'react-dom'
import Product from "../components/Product/Product";
import Checkout from "../components/Checkout/Checkout";


document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('data');
    const data = JSON.parse(node.getAttribute('data'));
    const componentType = node.getAttribute('type');
    let component = undefined;
    if (componentType === 'product') {
        component = <Product {...data} />;
    } else if (componentType === 'checkout') {
        component = <Checkout {...data} />;
    }

    ReactDOM.render(
        component,
        document.body.appendChild(document.createElement('div')),
    )
});