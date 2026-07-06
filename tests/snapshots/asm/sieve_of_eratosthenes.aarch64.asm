
sieve_of_eratosthenes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x2                // =2
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, x0
               	ldrb	w2, [x2]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mul	x2, x1, x1
               	sxtw	x3, w2
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x2, x4, x2
               	mov	x4, #0x1                // =1
               	strb	w4, [x2]
               	add	x3, x3, x1
               	sxtw	x2, w3
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x2, x17
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	mul	x2, x0, x0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x2, x17
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, #0x2                // =2
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, x0
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	sxtw	x0, w2
               	mov	x17, #0x2578            // =9592
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
