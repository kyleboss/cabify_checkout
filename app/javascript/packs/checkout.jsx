import Checkout from '../components/Checkout/Checkout';
import * as React from "react";
import ReactDOM from 'react-dom'


document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('checkout_data');
    const data = JSON.parse(node.getAttribute('data'));
    ReactDOM.render(
        <Checkout
            allProducts={data.allProducts}
            baseUrl={data.baseUrl}
            authenticityToken={data.authenticityToken}
            allCurrencies={data.allCurrencies}
        />,
        document.body.appendChild(document.createElement('div')),
    )
});