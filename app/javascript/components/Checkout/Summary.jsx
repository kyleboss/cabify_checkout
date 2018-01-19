import React from "react";

export default class Summary extends React.Component {
    constructor(props) {
        super(props);
    }

    scannedProductSections = function() {
        return(this.props.cartSummary.charges.map((product) =>
            <div key={product.title} className='summary__product summary_section'>
                <div className='summary__product-label'>
                    {product.title} <span className='summary__product-quantity'>({product.quantity})</span>
                </div>
                <div className='summary__product-value'>{product.amount} {this.props.currencySymbol}</div>
            </div>
        )
        );
    };

    discountSections = function() {
        return(this.props.cartSummary.discounts.map((discount) =>
            <div key={discount.title} className='summary__product summary__product-discount summary_section'>
                <div className='summary__product-label'>{discount.title} Discount</div>
                <div className='summary__product-value'>-{discount.amount} {this.props.currencySymbol}</div>
            </div>
        ));
    };

    render() {
        return(
            <div className='summary'>
                {this.scannedProductSections()}
                {this.discountSections()}
                <div className='summary__total summary_section'>
                    <div className='summary__product-label'>Total:</div>
                    <div className='summary__product-value'>
                        {this.props.cartSummary.total} {this.props.currencySymbol}
                    </div>
                </div>
                <button className='summary__checkout-button'>Checkout</button>
            </div>
        );
    };
};