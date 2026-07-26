
forward_fn_ptr_in_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x2
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<times_three>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<minus_seven>:
               	sub	x0, x0, #0x7
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0xa                // =10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	add	x0, x20, #0x0
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x5                // =5
               	ldr	x0, [x20, #0x8]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, #0x64               // =100
               	ldr	x0, [x20, #0x10]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x5d
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
