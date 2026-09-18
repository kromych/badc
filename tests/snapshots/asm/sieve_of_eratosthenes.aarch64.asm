
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
               	add	x0, x3, x0
               	ldrb	w0, [x0]
               	cbnz	x0, <addr>
               	mul	x0, x1, x1
               	b	<addr>
               	sxtw	x4, w0
               	add	x4, x3, x4
               	mov	x5, #0x1                // =1
               	strb	w5, [x4]
               	add	x0, x0, x1
               	cmp	w0, w2
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	sxtw	x0, w1
               	mul	x4, x0, x0
               	cmp	x4, x2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x2                // =2
               	mov	x3, #0x86a0             // =34464
               	movk	x3, #0x1, lsl #16
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	sxtw	x2, w0
               	add	x2, x4, x2
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	mov	x17, #0x2578            // =9592
               	cmp	w1, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
