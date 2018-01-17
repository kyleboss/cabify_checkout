import React from "react";

export default class ProductCard extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div className='product-card'>
                <img className='product-card__image' src='https://rlv.zcache.com/life_classic_logo_t_shirt-re0a4c4efff6a4454a7d86b1fb37d9656_k2gr0_324.jpg?square_it=true' />
                <div className='product-card__title'>Voucher</div>
                <div className='product-card__quantity-container'>
                    Quantity: <input type='number' defaultValue='2' className='product-card__quantity' />
                </div>
                <button className='product-card__remove-button'>Remove</button>
            </div>
        );
    };
};