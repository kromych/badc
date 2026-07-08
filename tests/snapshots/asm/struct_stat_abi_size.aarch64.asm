
struct_stat_abi_size.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x510              // =1296
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x110]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	sub	x20, x29, #0x40
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	mov	x1, #0x242              // =578
               	mov	x2, #0x1a4              // =420
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sxtw	x0, w20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x0, x29, #0xc8
               	mov	x1, #0x0                // =0
               	mov	x2, #0x80               // =128
               	bl	<addr>
               	sxtw	x0, w20
               	sub	x1, x29, #0xc8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x0, x29, #0xc8
               	ldr	x0, [x0, #0x30]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x0, x29, #0xc8
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #0xf000            // =61440
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.eq	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
