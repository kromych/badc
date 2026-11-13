
sigsetjmp_restores_the_signal_mask.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x80
               	mov	x2, x0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x1, x0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x80
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x4                // =4
               	cmp	w20, #0x0
               	csel	x0, x0, x1, ne
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x20, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	brk	#0x1
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0xc                // =12
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x80
               	mov	x2, x0
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	brk	#0x1
