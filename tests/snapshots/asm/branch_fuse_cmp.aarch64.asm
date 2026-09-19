
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

<relational>:
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x4, [x2]
               	cmp	x3, x4
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	cmp	x3, x4
               	b.le	<addr>
               	add	x0, x0, #0x64
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	ldr	x3, [x1]
               	ldr	x4, [x2]
               	cmp	x3, x4
               	b.lt	<addr>
               	add	x0, x0, #0x64
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x5, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x6, [x4]
               	cmp	x5, x6
               	b.hs	<addr>
               	add	x0, x0, #0x1
               	ldr	x5, [x3]
               	ldr	x6, [x4]
               	cmp	x5, x6
               	b.ls	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x1]
               	cmp	x1, #0x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldr	x1, [x2]
               	cmp	x1, #0x9
               	b.eq	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x3]
               	cmp	x1, #0x4
               	b.hi	<addr>
               	add	x0, x0, #0x64
               	ldr	x1, [x4]
               	cmp	x1, #0x9
               	b.lo	<addr>
               	add	x0, x0, #0x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	cbz	x2, <addr>
               	mov	x0, #0x64               // =100
               	ldr	x2, [x1]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	ldr	x3, [x2]
               	cbnz	x3, <addr>
               	add	x0, x0, #0x64
               	ldr	x2, [x2]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldr	x1, [x1]
               	cbnz	x1, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1]
               	cmp	x2, x3
               	cset	x2, lt
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	w2, [x3]
               	cbz	x2, <addr>
               	ldrsw	x2, [x3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	ldr	x3, [x1]
               	cmp	x2, x3
               	ldr	x0, [x0]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	b.ge	<addr>
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	b	<addr>
               	mov	x2, #0x64               // =100
               	b	<addr>
