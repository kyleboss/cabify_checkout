import React from "react";

export default class ProductCard extends React.Component {
    render() {
        return(
            <div className='product-card'>
                <img className='product-card__image' src={this.props.product.image_url} />
                <div className='product-card__title'>{this.props.product.title}</div>
                <div className='product-card__quantity-container'>
                    Quantity:
                    <input
                        type='number'
                        onChange={(e) => this.props.updateProductQuantity(this.props.product.scan_id, e.target.value)}
                        value={this.props.product.quantity}
                        className='product-card__quantity'
                    />
                </div>
                <button
                    onClick={(e) => this.props.removeProduct(this.props.product.scan_id)}
                    className='product-card__remove-button'
                >
                    Remove
                </button>
            </div>
        );
    };
};