
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
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	sxtw	x6, w5
               	lsl	x0, x6, #4
               	add	x0, x8, x0
               	ldr	x0, [x0, #0x8]
               	mov	x1, x3
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x2
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
               	sxtw	x6, w5
               	lsl	x0, x6, #4
               	add	x0, x7, x0
               	ldr	x0, [x0, #0x8]
               	mov	x1, x3
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	b.eq	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x2
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
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
