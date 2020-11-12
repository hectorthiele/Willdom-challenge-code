import React, { Component } from 'react';
import { Row, Col, Card, CardBody } from 'reactstrap';

import SearchBar from './SearchBar';
import SearchResults from './SearchResults';

class SearchView extends Component {

  render() {

    return (
      <Card>
        <CardBody>
          <Row>
            <Col xl="12" className='title'>
              <h2>WILLDOM Search</h2>
            </Col>
            <SearchBar />
          </Row>
          <SearchResults />
        </CardBody>
      </Card>
    );
  }
};

export default SearchView;