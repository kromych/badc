
bst_free.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	ldr	x0, [x20, #0x8]
               	bl	<addr>
               	ldr	x0, [x20, #0x10]
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret

<insert>:
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

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x21, #0x0               // =0
               	mov	x1, #0x32               // =50
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x1e               // =30
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, #0x46               // =70
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
