/* eslint-disable no-undef */
const API_BASE = 'http://localhost:8080';

const getGroups = async () => {
  try {
    const response = await fetch(`${API_BASE}/accounts`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${Cookies.get('token')}`,
      },
    });

    if (response.ok) {
      return await response.json();
    } else {
      alert('Can not get groups');
      return [];
    }
  } catch (err) {
    console.log(err);
    return [];
  }
};

const addGroup = async (groupId) => {
  try {
    const response = await fetch(`${API_BASE}/accounts`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${Cookies.get('token')}`,
      },
      body: JSON.stringify({ groups_id: groupId }),
    });

    if (response.ok) {
      location.reload();
    } else {
      alert('Group is added already');
    }
  } catch (err) {
    console.log(err);
  }
};

const createGroupElement = (groupData) => {
  const groupDiv = document.createElement('div');
  groupDiv.classList.add('group');
  groupDiv.innerHTML = `<div>Name: ${groupData.name}</div><div>ID: ${groupData.groups_id}</div>`;

  groupDiv.addEventListener('click', async () => {
    try {
      const response = await fetch(`${API_BASE}/bills/${groupData.groups_id}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${Cookies.get('token')}`,
        },
      });

      if (response.ok) {
        const data = await response.json();

        const billsContainer = document.getElementById('bills-container');
        billsContainer.innerHTML = '';

        data.forEach((bill) => {
          const billDiv = document.createElement('div');
          billDiv.classList.add('bill');
          billDiv.textContent = `ID: ${bill.id}  Amount: ${bill.amount} Eur Description: ${bill.description}`;
          billsContainer.appendChild(billDiv);
        });

        const createBillForm = document.getElementById('create-bill-form');
        createBillForm.style.display = 'block';
        createBillForm.dataset.groupId = groupData.groups_id;
      } else {
        alert('Failed to get bills');
      }
    } catch (err) {
      console.log(err);
    }
  });

  return groupDiv;
};

window.addEventListener('DOMContentLoaded', async () => {
  const addGroupForm = document.getElementById('add-group-form');
  addGroupForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    const groupIdInput = document.getElementById('group-id-input');
    const groupId = groupIdInput.value;
    await addGroup(groupId);
    groupIdInput.value = '';
  });

  const groups = await getGroups();
  const groupList = document.getElementById('group-list');

  groups.forEach((groupData) => {
    const groupElement = createGroupElement(groupData);
    groupList.appendChild(groupElement);
  });

  const createBillForm = document.getElementById('create-bill-form');
  createBillForm.style.display = 'none';

  createBillForm.addEventListener('submit', async (event) => {
    event.preventDefault();

    const amountInput = document.getElementById('amount-input');
    const descriptionInput = document.getElementById('description-input');
    const groupId = createBillForm.dataset.groupId;

    try {
      const response = await fetch(`${API_BASE}/bills`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${Cookies.get('token')}`,
        },
        body: JSON.stringify({
          groups_id: groupId,
          amount: amountInput.value,
          description: descriptionInput.value,
        }),
      });

      if (response.ok) {
        amountInput.value = '';
        descriptionInput.value = '';
        const billsContainer = document.getElementById('bills-container');
        billsContainer.innerHTML = '';

        const allBills = await fetch(`${API_BASE}/bills/${groupId}`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${Cookies.get('token')}`,
          },
        });

        if (allBills.ok) {
          const updatedData = await allBills.json();

          updatedData.forEach((bill) => {
            const billDiv = document.createElement('div');
            billDiv.classList.add('bill');
            billDiv.textContent = `ID: ${bill.id} Amount: ${bill.amount} Description: ${bill.description}`;
            billsContainer.appendChild(billDiv);
          });
        } else {
          alert('Could not get new bills');
        }
      } else {
        alert('Can not create bill');
      }
    } catch (err) {
      console.log(err);
    }
  });
  document.addEventListener('click', (event) => {
    const selectedGroup = document.querySelector('.group.selected');
    const billsContainer = document.getElementById('bills-container');
    const createBillForm = document.getElementById('create-bill-form');

    if (event.target.classList.contains('group')) {
      if (selectedGroup) {
        selectedGroup.classList.remove('selected');
        billsContainer.innerHTML = '';
        createBillForm.style.display = 'none';
      }

      event.target.classList.add('selected');
    } else if (!event.target.closest('.bills-container') && selectedGroup) {
      selectedGroup.classList.remove('selected');
      billsContainer.innerHTML = '';
      createBillForm.style.display = 'none';
    }
  });
});
