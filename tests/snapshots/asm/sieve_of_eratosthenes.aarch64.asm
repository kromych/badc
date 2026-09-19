
sieve_of_eratosthenes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x1, #0x2                // =2
               	mov	x3, #0x86a0             // =34464
               	movk	x3, #0x1, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x0, w1
               	ldrb	w0, [x2, x0]
               	cbnz	x0, <addr>
               	mul	x0, x1, x1
               	cmp	w0, w3
               	b.ge	<addr>
               	mov	x4, #0x1                // =1
               	strb	w4, [x2, w0, sxtw]
               	add	x0, x0, x1
               	cmp	w0, w3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	sxtw	x0, w1
               	mul	x4, x0, x0
               	cmp	x4, x3
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x4, #0x86a0             // =34464
               	movk	x4, #0x1, lsl #16
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2, x0]
               	cbnz	x3, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	mov	x17, #0x2578            // =9592
               	cmp	w1, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
