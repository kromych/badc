
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w1
               	add	x0, x0, x2
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mul	x0, x1, x1
               	sxtw	x2, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x3, w2
               	add	x0, x0, x3
               	mov	x3, #0x1                // =1
               	strb	w3, [x0]
               	add	x2, x2, x1
               	sxtw	x0, w2
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	mul	x0, x0, x0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	mov	x1, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x3, w1
               	add	x0, x0, x3
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
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
