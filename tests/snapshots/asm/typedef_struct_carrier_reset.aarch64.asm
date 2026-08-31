
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
               	add	x2, x0, #0x0
               	str	w1, [x2]
               	add	x1, x0, #0x28
               	add	x3, x1, #0x0
               	mov	x2, #0x1                // =1
               	str	w2, [x3]
               	str	w2, [x0, #0x4]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x4]
               	str	w2, [x0, #0x8]
               	mov	x2, #0x3                // =3
               	str	w2, [x1, #0x8]
               	str	w2, [x0, #0xc]
               	mov	x2, #0x4                // =4
               	str	w2, [x1, #0xc]
               	str	w2, [x0, #0x10]
               	mov	x2, #0x5                // =5
               	str	w2, [x1, #0x10]
               	str	w2, [x0, #0x14]
               	mov	x2, #0x6                // =6
               	str	w2, [x1, #0x14]
               	str	w2, [x0, #0x18]
               	mov	x2, #0x7                // =7
               	str	w2, [x1, #0x18]
               	str	w2, [x0, #0x1c]
               	mov	x2, #0x8                // =8
               	str	w2, [x1, #0x1c]
               	str	w2, [x0, #0x20]
               	add	x1, x0, #0x28
               	mov	x2, #0x9                // =9
               	str	w2, [x1, #0x20]
               	str	w2, [x0, #0x24]
               	mov	x2, #0xa                // =10
               	str	w2, [x1, #0x24]
               	mov	x1, #0x64               // =100
               	str	w1, [x0, #0xa0]
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x3c]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0xa0]
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
