
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

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

<zero_and_sum>:
               	mov	x1, #0x0                // =0
               	add	x3, x0, #0x0
               	str	w1, [x3]
               	add	x1, x0, #0x28
               	add	x4, x1, #0x0
               	mov	x2, #0x1                // =1
               	str	w2, [x4]
               	ldrsw	x3, [x3]
               	sxtw	x4, w2
               	add	x3, x3, x4
               	add	x3, x3, #0x0
               	str	w2, [x0, #0x4]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x4]
               	ldrsw	x4, [x0, #0x4]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x8]
               	mov	x2, #0x3                // =3
               	str	w2, [x1, #0x8]
               	ldrsw	x4, [x0, #0x8]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0xc]
               	mov	x2, #0x4                // =4
               	str	w2, [x1, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x10]
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0x10]
               	ldrsw	x4, [x0, #0x10]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x14]
               	mov	x2, #0x6                // =6
               	str	w2, [x1, #0x14]
               	ldrsw	x4, [x0, #0x14]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x18]
               	mov	x2, #0x7                // =7
               	str	w2, [x1, #0x18]
               	ldrsw	x4, [x0, #0x18]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x1c]
               	mov	x2, #0x8                // =8
               	str	w2, [x1, #0x1c]
               	ldrsw	x4, [x0, #0x1c]
               	sxtw	x1, w2
               	add	x1, x4, x1
               	add	x3, x3, x1
               	str	w2, [x0, #0x20]
               	add	x1, x0, #0x28
               	mov	x2, #0x9                // =9
               	str	w2, [x1, #0x20]
               	ldrsw	x4, [x0, #0x20]
               	sxtw	x5, w2
               	add	x4, x4, x5
               	add	x3, x3, x4
               	str	w2, [x0, #0x24]
               	mov	x2, #0xa                // =10
               	str	w2, [x1, #0x24]
               	ldrsw	x4, [x0, #0x24]
               	sxtw	x1, w2
               	add	x1, x4, x1
               	add	x1, x3, x1
               	str	w1, [x0, #0xa0]
               	sxtw	x0, w1
               	ret

<main>:
               	str	x20, [sp, #-0xd0]!
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	sub	x20, x29, #0xa8
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	ldrsw	x0, [x20, #0x14]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	ldrsw	x0, [x20, #0x3c]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	ldrsw	x0, [x20, #0xa0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x20, [sp], #0xd0
               	ret
