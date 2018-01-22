import Checkout from '../components/Checkout/Checkout';
import * as React from "react";
import ReactDOM from 'react-dom'
import Product from "../components/Product/Product";


document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('product_data');
    const data = JSON.parse(node.getAttribute('data'));
    ReactDOM.render(
        <Product
            allProducts={data.allProducts}
            baseUrl={data.baseUrl}
            allCurrencies={data.allCurrencies}
            authenticityToken={data.authenticityToken}
        />,
        document.body.appendChild(document.createElement('div')),
    )
});