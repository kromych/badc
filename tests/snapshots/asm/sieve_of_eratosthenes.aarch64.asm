
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
               	mov	x2, #0x86a0             // =34464
               	movk	x2, #0x1, lsl #16
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	add	x0, x3, x6
               	ldrb	w0, [x0]
               	cbnz	x0, <addr>
               	mul	x0, x1, x1
               	sxtw	x0, w0
               	b	<addr>
               	sxtw	x4, w0
               	add	x4, x3, x4
               	mov	x5, #0x1                // =1
               	strb	w5, [x4]
               	add	x0, x0, x1
               	cmp	x0, x2
               	b.lt	<addr>
               	add	x1, x6, #0x1
               	sxtw	x6, w1
               	mul	x0, x6, x6
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x4, #0x86a0             // =34464
               	movk	x4, #0x1, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	sxtw	x2, w0
               	add	x3, x5, x2
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	x0, x4
               	b.lt	<addr>
               	mov	x17, #0x2578            // =9592
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
