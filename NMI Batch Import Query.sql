/* NMI Gateway Upload Schema for CMax3 Export */
SELECT DISTINCT
    p.payorname AS 'Cardholder',
    p.cardnumber AS 'Credit Card Number',
    CONCAT(p.cardexpirationmonth,
            (p.cardexpirationyear - 2000)) AS 'Credit Card Expiration',
    p.paymentamount AS 'Total Amount',
    p.cardaddress AS 'Billing Address 1',
    p.cardzipcode AS 'Postal Billing Code',
    REPLACE(p.threedigitnumber, '000', '') AS 'Card Security Code',
    p.filenumber AS 'Order ID',
    d.emailaddress AS 'Billing Email',
    CONCAT(d.originalcreditor, ' ', d.typeofdebt) AS 'Descriptor',
    d.firstname AS 'Billing First Name',
    d.lastname AS 'Billing Last Name',
    d.city AS 'Billing City',
    d.state AS 'Billing State',
    d.statusname AS 'Order Description',
    d.filenumber AS 'Invoice ID',
    d.id AS 'Partial Payment Id',
    'False' AS 'Partial Payments'
FROM
    collectionsmax.payments p
        JOIN
    collectionsmax.dbase d ON d.id = p.maindatabaseid
WHERE
    p.paymentdate BETWEEN (CURDATE() - 1) AND CURDATE()
        AND CONCAT(p.cardexpirationmonth,
            (p.cardexpirationyear - 2000)) NOT LIKE '%x%'
ORDER BY p.id DESC
