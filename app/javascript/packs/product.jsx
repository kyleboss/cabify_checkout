import Checkout from '../components/Checkout/Checkout';
import * as React from "react";
import ReactDOM from 'react-dom'
import Product from "../components/Product/Product";


document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('product_data');
    const data = JSON.parse(node.getAttribute('data'));
    data.allProducts.forEach((product) => {
        let bulk_price = product.bulk_price;
        product.numToBuy = product.num_to_buy || 2;
        product.numWillGet = product.num_will_get || 1;
        product.basePrice = parseFloat(product.base_price).toFixed(2);
        product.baseCurrency = product.base_currency;
        product.bulkPrice = (!bulk_price || isNaN(bulk_price)) ? product.basePrice : parseFloat(bulk_price).toFixed(2);
        product.bulkThreshold = product.bulk_threshold || 10;
        product.num_will_get = undefined;
        product.base_price = undefined;
        product.num_to_buy = undefined;
        product.bulk_price = undefined;
        product.bulk_threshold = undefined;
    });
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