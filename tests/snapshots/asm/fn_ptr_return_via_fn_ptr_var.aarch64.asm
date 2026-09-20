
fn_ptr_return_via_fn_ptr_var.aarch64:	file format elf64-littleaarch64

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

<g>:
               	add	x0, x0, #0x64
               	sxtw	x0, w0
               	ret

<h>:
               	add	x0, x0, #0xc8
               	sxtw	x0, w0
               	ret

<f>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	b	<addr>

<via_param>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, #0x1                // =1
               	blr	x20
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	blr	x20
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	add	x0, x21, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	ldur	x1, [x29, #-0x8]
               	mov	x0, #0x3                // =3
               	blr	x1
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x1, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	w0, #0xcb
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	w0, #0x132
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
