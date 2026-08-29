
crit_edge_split_label_addr.aarch64:	file format elf64-littleaarch64

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

<probe>:
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x0, [x29, #0x10]
               	stur	x1, [x29, #0x20]
               	stur	w2, [x29, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	b	<addr>
               	ldur	w0, [x29, #0x10]
               	ldur	w2, [x29, #0x20]
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	adr	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	ldursw	x1, [x29, #0x30]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #0x30]
               	ldur	w1, [x29, #0x10]
               	ldur	w2, [x29, #0x20]
               	b	<addr>
               	cbz	x0, <addr>
               	ldursw	x0, [x29, #0x30]
               	add	x0, x0, #0x2
               	stur	w0, [x29, #0x30]
               	ldursw	x0, [x29, #0x30]
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	mov	w0, w0
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w1, w0
               	mov	x0, #0x0                // =0
               	cbnz	x1, <addr>
               	mov	w1, w2
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	cmp	w1, #0x0
               	cset	x1, ne
               	sxtw	x1, w1
               	b	<addr>
               	mov	w1, w1
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	mov	w0, w2
               	mov	x17, #0x2               // =2
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x5               // =5
               	mov	x22, #0x3               // =3
               	mov	x20, #0xa               // =10
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x23, #0x2               // =2
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	mov	x22, #0xa               // =10
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x21, #0x5               // =5
               	mov	x1, #0x3                // =3
               	mov	x0, x21
               	mov	x2, x22
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	b	<addr>
