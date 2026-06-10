
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x1]
               	str	w3, [x0]
               	str	w2, [x1]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x2
               	mov	x23, x1
               	sxtw	x23, w23
               	sxtw	x21, w21
               	ldrsw	x22, [x20, x21, lsl #2]
               	sub	x0, x23, #0x1
               	sxtw	x24, w0
               	b	<addr>
               	sxtw	x0, w23
               	cmp	x0, x21
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w23
               	add	x23, x0, #0x1
               	b	<addr>
               	sxtw	x0, w23
               	ldrsw	x0, [x20, x0, lsl #2]
               	cmp	x0, x22
               	b.gt	<addr>
               	b	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #2
               	add	x0, x20, x0
               	lsl	x1, x21, #2
               	add	x1, x20, x1
               	bl	<addr>
               	sxtw	x0, w24
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w24
               	add	x24, x0, #0x1
               	sxtw	x0, w24
               	lsl	x0, x0, #2
               	add	x0, x20, x0
               	sxtw	x1, w23
               	lsl	x1, x1, #2
               	add	x1, x20, x1
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x22, x2
               	mov	x21, x1
               	sxtw	x21, w21
               	sxtw	x22, w22
               	cmp	x21, x22
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	sxtw	x0, w23
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w23
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x0                // =0
               	mov	x0, #0xc                // =12
               	str	w0, [x20]
               	mov	x2, #0x4                // =4
               	mov	x0, #0x7                // =7
               	str	w0, [x20, #0x4]
               	mov	x0, #0xf                // =15
               	str	w0, [x20, #0x8]
               	mov	x0, #0x5                // =5
               	str	w0, [x20, #0xc]
               	mov	x0, #0xa                // =10
               	str	w0, [x20, #0x10]
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x10]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
