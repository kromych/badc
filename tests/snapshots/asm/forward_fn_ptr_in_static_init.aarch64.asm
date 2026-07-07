
forward_fn_ptr_in_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<times_three>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ret

<minus_seven>:
               	sub	x0, x0, #0x7
               	sxtw	x0, w0
               	ret

<call_via_table>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, x1
               	sxtw	x0, w0
               	sxtw	x2, w2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, x0, lsl #3]
               	mov	x9, x0
               	mov	x0, x2
               	blr	x9
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x1, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	cmp	x0, #0x5d
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
