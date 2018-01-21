import React from "react";

export default class InputSet extends React.Component {

    render() {
        return(
            <div className={this.props.containerClass}>
                <div className={this.props.labelClass}>{this.props.label}</div>
                <input
                    className={`product-card__input product-card__${this.props.inputClass}`}
                    placeholder={this.props.placeholder}
                    onChange={(e) => this.updateProductProperty(e, this.props.propertyName)}
                    value={this.props.value}
                    type={this.props.type || 'text'}
                />
            </div>
        );
    };
};