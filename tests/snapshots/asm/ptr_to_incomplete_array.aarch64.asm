
ptr_to_incomplete_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	x8, [x9, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	lsl	x0, x6, #4
               	add	x0, x8, x0
               	ldr	x0, [x0, #0x8]
               	mov	x2, x3
               	ldrb	w1, [x0]
               	cbz	x1, <addr>
               	ldrb	w1, [x0]
               	ldrb	w4, [x2]
               	cmp	x1, x4
               	cset	x1, eq
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x2]
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x5, x6, #0x1
               	sxtw	x6, w5
               	cmp	x6, #0x2
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	lsl	x0, x6, #4
               	add	x0, x7, x0
               	ldr	x0, [x0, #0x8]
               	mov	x2, x3
               	ldrb	w1, [x0]
               	cbz	x1, <addr>
               	ldrb	w1, [x0]
               	ldrb	w4, [x2]
               	cmp	x1, x4
               	cset	x1, eq
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x2]
               	cmp	x0, x1
               	b.eq	<addr>
               	add	x5, x6, #0x1
               	sxtw	x6, w5
               	cmp	x6, #0x2
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x0, [x9, #0x8]
               	cmp	x0, x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	lsl	x0, x6, #4
               	add	x0, x7, x0
               	ldrsw	x0, [x0]
               	b	<addr>
               	lsl	x0, x6, #4
               	add	x0, x8, x0
               	ldrsw	x0, [x0]
               	b	<addr>
