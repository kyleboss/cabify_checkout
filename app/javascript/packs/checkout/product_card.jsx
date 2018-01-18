import React from "react";

export default class ProductCard extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div className='product-card'>
                <img className='product-card__image' src={this.props.scannedProduct.imageUrl} />
                <div className='product-card__title'>{this.props.scannedProduct.title}</div>
                <div className='product-card__quantity-container'>
                    Quantity:
                    <input
                        type='number'
                        defaultValue={this.props.scannedProduct.quantity}
                        className='product-card__quantity'
                    />
                </div>
                <button className='product-card__remove-button'>Remove</button>
            </div>
        );
    };
};