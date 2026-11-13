
fcntl_lock_via_cast_fnptr.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xa0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	bl	<addr>
               	mov	x3, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x42               // =66
               	mov	x2, #0x1a4              // =420
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x2, x29, #0x60
               	stur	xzr, [x29, #-0x58]
               	stur	xzr, [x29, #-0x50]
               	stur	xzr, [x29, #-0x48]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x60]
               	mov	x1, #0x6                // =6
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x29, #0x60
               	mov	x0, #0x2                // =2
               	sturh	w0, [x29, #-0x60]
               	mov	x1, #0x6                // =6
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, x0
               	sub	x2, x29, #0x60
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x60]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x1, #0x6                // =6
               	mov	x0, x20
               	blr	x3
               	str	x0, [sp, #0x28]
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	cbnz	w21, <addr>
               	cbz	w22, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	ldr	x16, [sp, #0x28]
               	cmp	w16, #0x0
               	csel	x0, x1, x0, ne
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
