import React from "react";

export default class ProductCard extends React.Component {
    quantities = function() {
        return(Array.from(Array(Math.max(11, this.props.product.quantity+11)).keys()).map((quantity) =>
            <option key={quantity} value={quantity} selected={this.props.product.quantity === quantity}>
                {quantity}
            </option>
        ));
    };
    render() {
        return(
            <div className='product-card'>
                <img className='product-card__image' src={this.props.product.image_url} />
                <div className='product-card__title'>{this.props.product.title}</div>
                <div className='product-card__quantity-container'>
                    Quantity:
                    <select
                        onChange={(e) => this.props.updateProductQuantity(this.props.product.scan_id, e.target.value)}
                        className='product-card__quantity'
                    >
                        {this.quantities()}
                    </select>
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