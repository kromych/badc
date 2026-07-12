
sieve_of_eratosthenes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x2                // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x4
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mul	x0, x1, x1
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x2, x3, x2
               	mov	x3, #0x1                // =1
               	strb	w3, [x2]
               	add	x0, x0, x1
               	sxtw	x2, w0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x2, x17
               	b.lt	<addr>
               	add	x1, x4, #0x1
               	sxtw	x4, w1
               	mul	x0, x4, x4
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	b	<addr>
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	x2, x17
               	b.lt	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x2578            // =9592
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>
