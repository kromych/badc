
const_object_member_fold.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x14
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x17, #0x30ae            // =12462
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	orr	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0xc8
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	mov	x17, #-0x5              // =-5
               	cmp	w1, w17
               	b.eq	<addr>
               	orr	x0, x0, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fmov	d1, #3.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	orr	x0, x0, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	mov	x17, #0x304             // =772
               	movk	x17, #0x102, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	orr	x0, x0, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1e
               	b.ne	<addr>
               	ret
               	orr	x0, x0, #0x40
               	b	<addr>
