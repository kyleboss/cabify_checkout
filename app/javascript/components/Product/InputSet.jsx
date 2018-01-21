import React from "react";

export default class InputSet extends React.Component {

    render() {
        return(
            <div className='product-card__input-container'>
                <div className='product-card__input-label'>{this.props.label}</div>
                <input
                    className={`product-card__input product-card__${this.props.inputClass}`}
                    placeholder={this.props.placeholder}
                    onChange={(e) => this.updateProductProperty(e, this.props.propertyName)}
                    value={this.props.value}
                />
            </div>
        );
    };
};