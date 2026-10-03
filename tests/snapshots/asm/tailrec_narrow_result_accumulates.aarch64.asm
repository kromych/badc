
tailrec_narrow_result_accumulates.aarch64:	file format elf64-littleaarch64

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

<fib_int>:
               	cmp	w0, #0x2
               	b.lt	<addr>
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, #0x0               // =0
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x20, x20, #0x2
               	add	x21, x21, x0
               	cmp	w20, #0x2
               	b.ge	<addr>
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sxtw	x0, w0
               	ret

<golden_sum>:
               	mov	x1, #0x64               // =100
               	mov	x2, #0x79b9             // =31161
               	movk	x2, #0x9e37, lsl #16
               	mov	x0, #0x0                // =0
               	sub	x1, x1, #0x1
               	add	x0, x0, x2
               	cbnz	w1, <addr>
               	ret

<down_long>:
               	mov	x0, #0xa                // =10
               	mov	x1, #0x0                // =0
               	sub	x0, x0, #0x1
               	sub	x1, x1, #0x3
               	cbnz	w0, <addr>
               	add	x0, x1, #0x64
               	ret

<times3_short>:
               	mov	x1, #0xc                // =12
               	mov	x2, #0x3                // =3
               	mov	x0, #0x1                // =1
               	sub	x1, x1, #0x1
               	mul	x0, x0, x2
               	sxth	x0, w0
               	cbnz	w1, <addr>
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x79b9             // =31161
               	movk	x1, #0x9e37, lsl #16
               	mov	x20, x0
               	add	x20, x20, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x64
               	b.lt	<addr>
               	mov	x0, #0x18               // =24
               	bl	<addr>
               	mov	x17, #0xb520            // =46368
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	cmp	w0, w20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	cmp	x0, #0x46
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xc                // =12
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #0x1bf1            // =7153
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
