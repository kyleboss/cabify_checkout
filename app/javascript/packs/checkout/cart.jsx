import React from "react";
import ProductCard from "./product_card";
import Summary from "./summary";

export default class Cart extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div className='cart'>
                <div className='product-cards'>
                    <ProductCard/>
                    <ProductCard/>
                    <ProductCard/>
                    <ProductCard/>
                </div>
                <Summary/>
            </div>
        );
    };
};