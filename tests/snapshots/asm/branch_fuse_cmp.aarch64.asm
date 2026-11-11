
branch_fuse_cmp.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x18]
               	adrp	x1, <page>
               	ldr	x4, [x1, #0x20]
               	mov	x5, #0x1                // =1
               	cmp	x3, x4
               	csel	x2, x5, x2, lt
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x1, #0x20]
               	add	x5, x2, #0x64
               	cmp	x3, x4
               	csel	x2, x5, x2, gt
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x1, #0x20]
               	cmp	x3, x4
               	cinc	x2, x2, le
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x1, #0x20]
               	add	x5, x2, #0x64
               	cmp	x3, x4
               	csel	x4, x5, x2, ge
               	adrp	x2, <page>
               	ldr	x5, [x2, #0x28]
               	adrp	x3, <page>
               	ldr	x6, [x3, #0x30]
               	cmp	x5, x6
               	cinc	x4, x4, lo
               	ldr	x5, [x2, #0x28]
               	ldr	x6, [x3, #0x30]
               	add	x7, x4, #0x64
               	cmp	x5, x6
               	csel	x4, x7, x4, hi
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x5
               	cinc	x0, x4, eq
               	ldr	x1, [x1, #0x20]
               	add	x4, x0, #0x64
               	cmp	x1, #0x9
               	csel	x0, x4, x0, ne
               	ldr	x1, [x2, #0x28]
               	add	x2, x0, #0x64
               	cmp	x1, #0x4
               	csel	x0, x2, x0, ls
               	ldr	x1, [x3, #0x30]
               	cmp	x1, #0x9
               	cinc	x0, x0, hs
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x50]
               	mov	x3, #0x64               // =100
               	cmp	x2, #0x0
               	csel	x1, x3, x1, ne
               	ldr	x2, [x0, #0x50]
               	cmp	x2, #0x0
               	cinc	x2, x1, eq
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x38]
               	cmp	x3, #0x0
               	cinc	x2, x2, ne
               	ldr	x3, [x1, #0x38]
               	add	x4, x2, #0x64
               	cmp	x3, #0x0
               	csel	x2, x4, x2, eq
               	ldr	x1, [x1, #0x38]
               	cmp	x1, #0x0
               	cinc	x1, x2, ne
               	ldr	x0, [x0, #0x50]
               	cmp	x0, #0x0
               	cinc	x0, x1, eq
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x20]
               	cmp	x2, x3
               	cset	x2, lt
               	adrp	x3, <page>
               	str	w2, [x3, #0x58]
               	cbz	x2, <addr>
               	ldrsw	x2, [x3, #0x58]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0, #0x18]
               	ldr	x3, [x1, #0x20]
               	cmp	x2, x3
               	ldr	x0, [x0, #0x18]
               	ldr	x1, [x1, #0x20]
               	add	x0, x0, x1
               	b.ge	<addr>
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
