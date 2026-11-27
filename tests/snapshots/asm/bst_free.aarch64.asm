
bst_free.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<free_tree>:
               	cbz	x0, <addr>
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	ldr	x21, [x20, #0x8]
               	cbnz	x21, <addr>
               	ldr	x21, [x20, #0x10]
               	cbnz	x21, <addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	b	<addr>
               	ldr	x0, [x21, #0x8]
               	bl	<addr>
               	ldr	x0, [x21, #0x10]
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x21, #0x8]
               	bl	<addr>
               	ldr	x0, [x21, #0x10]
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	b	<addr>
               	ret

<insert>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x1
               	cbnz	x20, <addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	str	x22, [x0]
               	str	xzr, [x0, #0x8]
               	str	xzr, [x0, #0x10]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x20]
               	cmp	x22, x0
               	b.ge	<addr>
               	ldr	x21, [x20, #0x8]
               	cbnz	x21, <addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	mov	x21, x0
               	str	x22, [x21]
               	str	xzr, [x21, #0x8]
               	str	xzr, [x21, #0x10]
               	str	x21, [x20, #0x8]
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	ldr	x0, [x21]
               	cmp	x22, x0
               	b.ge	<addr>
               	ldr	x0, [x21, #0x8]
               	mov	x1, x22
               	bl	<addr>
               	str	x0, [x21, #0x8]
               	b	<addr>
               	ldr	x0, [x21, #0x10]
               	mov	x1, x22
               	bl	<addr>
               	str	x0, [x21, #0x10]
               	b	<addr>
               	ldr	x21, [x20, #0x10]
               	cbnz	x21, <addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	mov	x21, x0
               	str	x22, [x21]
               	str	xzr, [x21, #0x8]
               	str	xzr, [x21, #0x10]
               	str	x21, [x20, #0x10]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x22, x0
               	b.ge	<addr>
               	ldr	x0, [x21, #0x8]
               	mov	x1, x22
               	bl	<addr>
               	str	x0, [x21, #0x8]
               	b	<addr>
               	ldr	x0, [x21, #0x10]
               	mov	x1, x22
               	bl	<addr>
               	str	x0, [x21, #0x10]
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x32               // =50
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, x20
               	mov	x1, #0x1e               // =30
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, #0x46               // =70
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
