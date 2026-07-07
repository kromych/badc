
struct_fn_ptr_field_deref_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	ret

<adder7>:
               	add	x0, x0, #0x7
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x20]
               	mov	x1, #0x0                // =0
               	str	w1, [x20, #0x8]
               	mov	x1, #0xa                // =10
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x21, w0
               	ldr	x0, [x20]
               	mov	x1, #0x14               // =20
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x21, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x20]
               	mov	x1, #0x64               // =100
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x21, w0
               	ldr	x0, [x20]
               	mov	x1, #0xc8               // =200
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x0, w0
               	cmp	x21, #0x6b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	x0, #0xcf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
