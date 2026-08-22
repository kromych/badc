
init_subdesignator_multi_dim.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w3, [x0, #0xa]
               	ldr	w4, [x0, #0x24]
               	ldr	w5, [x0, #0x2c]
               	ldr	w6, [x0, #0x98]
               	mov	x17, #0xffff            // =65535
               	and	x7, x1, x17
               	mov	x17, #0xffff            // =65535
               	and	x8, x2, x17
               	mov	x17, #0xffff            // =65535
               	and	x9, x3, x17
               	sxtw	x3, w4
               	sxtw	x4, w5
               	sxtw	x5, w6
               	mov	x1, #0x0                // =0
               	ldrh	w2, [x0]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbnz	x2, <addr>
               	ldrh	w1, [x0, #0x2]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrh	w1, [x0, #0xa]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x24]
               	cmp	x1, #0x5
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrsw	x1, [x0, #0x2c]
               	cmp	x1, #0x6
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x98]
               	cmp	x1, #0x9
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrh	w1, [x0, #0x6]
               	cmp	x1, #0x0
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0x18]
               	cmp	x1, #0x0
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrsw	x0, [x0, #0x3c]
               	cmp	x0, #0x0
               	cset	x2, eq
               	sxtw	x0, w2
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	and	x1, x7, x17
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x8, x17
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x9, x17
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	cmp	x3, #0x5
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	cmp	x4, #0x6
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	cmp	x5, #0x9
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	ldrsw	x0, [x0, #0x54]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x6c]
               	cmp	x0, #0x3
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w0, [x0, #0x8]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x98]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
