import React from "react";

export default class Summary extends React.Component {
    constructor(props) {
        super(props);
    }

    scannedProductSections = this.props.scannedProducts.map((product) =>
        <div className='summary__product summary_section'>
            <div className='summary__product-label'>
                {product.title} <span className='summary__product-quantity'>({product.quantity})</span>
            </div>
            <div className='summary__product-value'>{this.props.currencySymbol}{product.amount}</div>
        </div>
    );

    discountSections = this.props.discounts.map((discount) =>
        <div className='summary__product summary__product-discount summary_section'>
            <div className='summary__product-label'>
                {discount.title} <span className='summary__product-quantity'>({discount.quantity})</span>
            </div>
            <div className='summary__product-value'>-{this.props.currencySymbol}{discount.amount}</div>
        </div>
    );

    render() {
        return(
            <div className='summary'>
                {scannedProductSections}
                {discountSections}
                <div className='summary__total summary_section'>
                    <div className='summary__product-label'>Total:</div>
                    <div className='summary__product-value'>{this.props.currencySymbol}{this.props.total}</div>
                </div>
                <button className='summary__checkout-button'>Checkout</button>
            </div>
        );
    };
};