
ptr_to_incomplete_array.aarch64:	file format elf64-littleaarch64

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
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x5, #0x0                // =0
               	cmp	w5, #0x2
               	b.ge	<addr>
               	sxtw	x8, w5
               	lsl	x0, x8, #4
               	add	x0, x7, x0
               	ldr	x0, [x0, #0x8]
               	mov	x1, x2
               	ldrb	w3, [x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x2
               	b.lt	<addr>
               	mov	x0, #-0x1               // =-1
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x5, #0x0                // =0
               	cmp	w5, #0x2
               	b.ge	<addr>
               	sxtw	x7, w5
               	lsl	x0, x7, #4
               	add	x0, x6, x0
               	ldr	x0, [x0, #0x8]
               	mov	x1, x2
               	ldrb	w3, [x0]
               	cbz	x3, <addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x2
               	b.lt	<addr>
               	mov	x0, #-0x1               // =-1
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	lsl	x0, x7, #4
               	add	x0, x6, x0
               	ldrsw	x0, [x0]
               	b	<addr>
               	lsl	x0, x8, #4
               	add	x0, x7, x0
               	ldrsw	x0, [x0]
               	b	<addr>
