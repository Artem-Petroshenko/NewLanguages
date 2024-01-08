package main

import (
	"fmt"
	"sync"
	"time"
)

type Order struct {
	ID             int
	AcceptanceTime time.Duration
	ExecutionTime  time.Duration
}

func waiter(orders chan Order, wg *sync.WaitGroup) {
	defer wg.Done()

	for i := 1; i <= 5; i++ { 
		order := Order{
			ID:             i,
			AcceptanceTime: time.Duration(i) * time.Second,  
			ExecutionTime:  time.Duration(i) * time.Second,
		}

		fmt.Printf("Waiter: Starts accepting Order %d\n", order.ID)

		time.Sleep(order.AcceptanceTime)

		fmt.Printf("Waiter: Finished accepting Order %d\n", order.ID)

		orders <- order
	}

	close(orders) 
}

func cook(orders chan Order, wg *sync.WaitGroup) {
	defer wg.Done()

	for order := range orders {
		fmt.Printf("Cook: Start preparing Order %d\n", order.ID)
		time.Sleep(order.ExecutionTime)
		fmt.Printf("Cook: Finished preparing Order %d\n", order.ID)
	}
}

func main() {
	var wg sync.WaitGroup

	orders := make(chan Order, 5)

	wg.Add(1)
	go waiter(orders, &wg)

	wg.Add(1)
	go cook(orders, &wg)

	wg.Wait()
}
