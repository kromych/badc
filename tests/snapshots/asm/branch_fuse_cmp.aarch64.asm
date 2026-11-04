
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
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	adrp	x2, <page>
               	ldr	x4, [x2, #0x20]
               	cmp	x3, x4
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x3, [x1, #0x18]
               	ldr	x4, [x2, #0x20]
               	cmp	x3, x4
               	b.le	<addr>
               	add	x0, x0, #0x64
               	ldr	x3, [x1, #0x18]
               	ldr	x4, [x2, #0x20]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	ldr	x3, [x1, #0x18]
               	ldr	x4, [x2, #0x20]
               	cmp	x3, x4
               	b.lt	<addr>
               	add	x0, x0, #0x64
               	adrp	x3, <page>
               	ldr	x5, [x3, #0x28]
               	adrp	x4, <page>
               	ldr	x6, [x4, #0x30]
               	cmp	x5, x6
               	b.hs	<addr>
               	add	x0, x0, #0x1
               	ldr	x5, [x3, #0x28]
               	ldr	x6, [x4, #0x30]
               	cmp	x5, x6
               	b.ls	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x1, #0x18]
               	cmp	x1, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldr	x1, [x2, #0x20]
               	cmp	x1, #0x9
               	b.eq	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x3, #0x28]
               	cmp	x1, #0x4
               	b.hi	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x4, #0x30]
               	cmp	x1, #0x9
               	b.lo	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x50]
               	cbz	x2, <addr>
               	mov	x0, #0x64               // =100
               	ldr	x2, [x1, #0x50]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	adrp	x2, <page>
               	ldr	x3, [x2, #0x38]
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	ldr	x3, [x2, #0x38]
               	cbnz	x3, <addr>
               	add	x0, x0, #0x64
               	ldr	x2, [x2, #0x38]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldr	x1, [x1, #0x50]
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
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
