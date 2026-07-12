
hex_case_range.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.ge	<addr>
               	cmp	x0, #0x30
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	cmp	x0, #0x40
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x20
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x4028000000000000 // =4622945017495814144
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x30               // =48
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x21               // =33
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	mov	x0, #0x4028000000000000 // =4622945017495814144
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
