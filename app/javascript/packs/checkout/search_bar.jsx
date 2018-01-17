import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

export default function SearchBar(props) {
    return(
        <div className='search-bar'>
            <input className='search-bar__query' placeholder='Cabify TShirt...' />
            <input className='search-bar__quantity' defaultValue='1' type='number' />
            <button className='search-bar__submit'>ADD</button>
        </div>
    );
};