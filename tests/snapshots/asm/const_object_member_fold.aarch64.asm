
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
               	ldrsw	x1, [x1, #0x18]
               	cmp	w1, #0x14
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	mov	x17, #0x30ae            // =12462
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x28]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x6
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1e
               	b.eq	<addr>
               	orr	x0, x0, #0x4
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x40]
               	cmp	w1, #0xc8
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x48]
               	mov	x17, #-0x5              // =-5
               	cmp	w1, w17
               	b.eq	<addr>
               	orr	x0, x0, #0x8
               	adrp	x1, <page>
               	fmov	d0, #3.75000000
               	orr	x2, x0, #0x10
               	ldr	d1, [x1, #0x50]
               	fcmp	d1, d0
               	csel	x0, x2, x0, ne
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x58]
               	mov	x17, #0x304             // =772
               	movk	x17, #0x102, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x60]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	orr	x0, x0, #0x20
               	adrp	x1, <page>
               	orr	x2, x0, #0x40
               	ldrsw	x1, [x1, #0x68]
               	cmp	w1, #0x1e
               	csel	x0, x2, x0, ne
               	ret
