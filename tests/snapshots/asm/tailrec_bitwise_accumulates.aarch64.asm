
tailrec_bitwise_accumulates.aarch64:	file format elf64-littleaarch64

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

<load_le32>:
               	mov	x1, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	ldrb	w3, [x1, x0]
               	lsl	x4, x0, #3
               	lsl	x3, x3, x4
               	add	x0, x0, #0x1
               	orr	x2, x2, x3
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<mix>:
               	mov	x0, #0x64               // =100
               	mov	x2, #0x79b9             // =31161
               	movk	x2, #0x9e37, lsl #16
               	mov	x1, #0x0                // =0
               	mul	x3, x0, x2
               	sub	x0, x0, #0x1
               	eor	x1, x1, x3
               	cbnz	w0, <addr>
               	mov	x17, #0x5a5a            // =23130
               	movk	x17, #0x5a5a, lsl #16
               	eor	x0, x1, x17
               	ret

<clear_down>:
               	mov	x0, #0x14               // =20
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x1                // =1
               	and	x3, x0, #0xf
               	lsl	x2, x2, x3
               	mvn	x2, x2
               	and	x2, x2, #0xffff
               	sub	x0, x0, #0x1
               	and	x1, x1, x2
               	cbnz	w0, <addr>
               	and	x0, x1, #0xffff
               	ret

<set_down>:
               	mov	x1, #0x9                // =9
               	mov	x2, #0x7                // =7
               	mov	x3, #0x4925             // =18725
               	movk	x3, #0x2492, lsl #16
               	mov	x0, #0x0                // =0
               	mov	x4, #0x1                // =1
               	mul	x5, x1, x3
               	lsr	x5, x5, #32
               	mul	x5, x5, x2
               	sub	x5, x1, x5
               	lsl	x4, x4, x5
               	sxtb	x4, w4
               	sub	x1, x1, #0x1
               	orr	x0, x0, x4
               	cmp	w1, #0x0
               	b.gt	<addr>
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0x5a5a            // =23130
               	movk	x20, #0x5a5a, lsl #16
               	mov	x0, #0x1                // =1
               	mov	x1, #0x79b9             // =31161
               	movk	x1, #0x9e37, lsl #16
               	mul	x2, x0, x1
               	eor	x20, x20, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x64
               	b.ls	<addr>
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	cmp	w0, w20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x20, #0xffff            // =65535
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	and	x2, x0, #0xf
               	lsl	x2, x1, x2
               	mvn	x2, x2
               	and	x2, x2, #0xffff
               	and	x20, x20, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x14
               	b.ls	<addr>
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	and	x0, x0, #0xffff
               	cmp	w0, w20
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	sxtb	x0, w0
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
