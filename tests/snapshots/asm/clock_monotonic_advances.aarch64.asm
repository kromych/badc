
clock_monotonic_advances.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x380              // =896
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	sub	x1, x29, #0x10
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1]
               	sub	x1, x29, #0x10
               	str	x0, [x1, #0x8]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, lt
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	b	<addr>
               	ldursw	x1, [x29, #-0x28]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x28]
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x2, x17
               	b.lt	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x0
               	cset	x0, lt
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
