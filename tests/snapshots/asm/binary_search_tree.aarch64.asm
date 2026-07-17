
binary_search_tree.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	str	x21, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x20]
               	cmp	x21, x0
               	b.ge	<addr>
               	ldr	x0, [x20, #0x8]
               	mov	x1, x21
               	bl	<addr>
               	str	x0, [x20, #0x8]
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x10]
               	mov	x1, x21
               	bl	<addr>
               	str	x0, [x20, #0x10]
               	b	<addr>

<search>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	cmp	x2, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x0]
               	cmp	x1, x2
               	b.ge	<addr>
               	ldr	x0, [x0, #0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x32               // =50
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x1e               // =30
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x46               // =70
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, #0x14              // =20
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x1, #0x28               // =40
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #0x28               // =40
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x1, #0x63               // =99
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
