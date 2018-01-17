import React from "react";

export default class Summary extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div className='summary'>
                <div className='summary__product summary_section'>
                    <div className='summary__product-label'>
                        Voucher <span className='summary__product-quantity'>(3)</span>
                    </div>
                    <div className='summary__product-value'>$3.00</div>
                </div>
                <div className='summary__product summary__product-discount summary_section'>
                    <div className='summary__product-label'>
                        Buy 1 Get 1 Voucher Discounts <span className='summary__product-quantity'>(3)</span>
                    </div>
                    <div className='summary__product-value'>-$3.00</div>
                </div>
                <div className='summary__total summary_section'>
                    <div className='summary__product-label'>Total:</div>
                    <div className='summary__product-value'>$9.00</div>
                </div>
                <button className='summary__checkout-button'>Checkout</button>
            </div>
        );
    };
};