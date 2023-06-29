const express = require('express');
const mysql = require('mysql2');
const Joi = require('joi');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const { authenticate } = require('./middleware');
require('dotenv').config();

const server = express();
server.use(express.json());
server.use(cors());

const mysqlConfig = {
  host: 'localhost',
  user: 'root',
  password: process.env.DB_PASS,
  database: 'expenses',
};

const userSchema = Joi.object({
  full_name: Joi.string().trim(),
  email: Joi.string().email().trim().lowercase().required(),
  password: Joi.string().required(),
});

const dbPool = mysql.createPool(mysqlConfig).promise();

server.get('/', authenticate, (req, res) => {
  console.log(req.user);
  res.status(200).send({ message: 'Authorized' });
});

server.post('/login', async (req, res) => {
  let payload = req.body;

  try {
    payload = await userSchema.validateAsync(payload);
  } catch (error) {
    console.error(error);

    return res.status(400).send({ error: 'All fields are required' });
  }

  try {
    const [data] = await dbPool.execute(
      `
        SELECT * FROM users
        WHERE email = ?
    `,
      [payload.email]
    );

    if (!data.length) {
      return res.status(400).send({ error: 'Email or password did not match' });
    }

    const isPasswordMatching = await bcrypt.compare(
      payload.password,
      data[0].password
    );

    if (isPasswordMatching) {
      const token = jwt.sign(
        {
          email: data[0].email,
          id: data[0].id,
        },
        process.env.JWT_SECRET
      );
      return res.status(200).send({ token });
    }

    return res.status(400).send({ error: 'Email or password did not match' });
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});

server.post('/register', async (req, res) => {
  let payload = req.body;

  try {
    payload = await userSchema.validateAsync(payload);
  } catch (error) {
    console.error(error);

    return res.status(400).send({ error: 'All fields are required' });
  }

  try {
    const encryptedPassword = await bcrypt.hash(payload.password, 10);
    const [response] = await dbPool.execute(
      `
            INSERT INTO users (full_name, email, password)
            VALUES (?, ?, ?)
        `,
      [payload.full_name, payload.email, encryptedPassword]
    );
    const token = jwt.sign(
      {
        email: payload.email,
        id: response.insertId,
        full_name: payload.full_name,
      },
      process.env.JWT_SECRET
    );
    return res.status(201).json({ token });
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});
server.get('/groups', async (req, res) => {
  try {
    const [data] = await dbPool.execute(
      `
          SELECT * FROM expenses.groups;
        `
    );

    return res.status(200).send(data);
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});
server.post('/groups', authenticate, async (req, res) => {
  try {
    const { name } = req.body;

    const [response] = await dbPool.execute(
      `
          INSERT INTO expenses.groups (name)
          VALUES (?)
        `,
      [name]
    );

    return res.status(201).end();
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});

server.post('/accounts', authenticate, async (req, res) => {
  try {
    const { groups_id } = req.body;
    const users_id = req.user.id;

    const [duplicateAccount] = await dbPool.execute(
      `
          SELECT * FROM expenses.accounts
          WHERE users_id = ? AND groups_id = ?
        `,
      [users_id, groups_id]
    );

    if (duplicateAccount.length > 0) {
      return res.status(409).send({ error: 'Account already exists' });
    }

    const [response] = await dbPool.execute(
      `
          INSERT INTO expenses.accounts (users_id, groups_id)
          VALUES (?, ?)
        `,
      [users_id, groups_id]
    );

    return res.status(201).end();
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});

server.get('/accounts', authenticate, async (req, res) => {
  try {
    const userId = req.user.id;

    const [data] = await dbPool.execute(
      `
          SELECT * FROM expenses.groups
          INNER JOIN expenses.accounts ON expenses.accounts.groups_id = groups.id
          WHERE expenses.accounts.users_id = ?
        `,
      [userId]
    );

    return res.status(200).send(data);
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});

server.get('/bills/:groups_id', async (req, res) => {
  try {
    const groupId = req.params.groups_id;

    const [data] = await dbPool.execute(
      `
      SELECT * FROM expenses.bills
      WHERE groups_id = ?
      `,
      [groupId]
    );

    return res.status(200).json(data);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
});

server.post('/bills', authenticate, async (req, res) => {
  try {
    const { amount, description, groups_id } = req.body;

    const [response] = await dbPool.execute(
      `
          INSERT INTO expenses.bills (amount, description, groups_id)
          VALUES (?, ?, ?)
        `,
      [amount, description, groups_id]
    );

    return res.status(201).end();
  } catch (error) {
    console.error(error);
    return res.status(500).end();
  }
});

server.listen(process.env.PORT, () =>
  console.log(`Server is listening to ${process.env.PORT} port`)
);
