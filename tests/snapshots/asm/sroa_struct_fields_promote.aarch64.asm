
sroa_struct_fields_promote.aarch64:	file format elf64-littleaarch64

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

<t_mixed>:
               	mov	x17, #0x5               // =5
               	mul	x2, x0, x17
               	add	x1, x0, #0x1
               	lsl	x3, x0, #1
               	add	x3, x2, x3
               	add	x2, x0, #0x7
               	sxth	x2, w2
               	mov	x17, #0xff              // =255
               	and	x4, x0, x17
               	mov	x17, #0x7a              // =122
               	eor	x4, x4, x17
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	add	x5, x1, x1
               	lsl	x0, x1, #1
               	add	x3, x3, x0
               	add	x0, x2, x1
               	sxth	x0, w0
               	mov	x17, #0xff              // =255
               	and	x2, x4, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	sxtw	x2, w5
               	add	x2, x2, x3
               	add	x0, x2, x0
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	add	x0, x0, x1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	asr	x0, x20, #1
               	lsl	x0, x0, #4
               	add	x0, x20, x0
               	sxtw	x0, w0
               	add	x0, x0, x20
               	lsl	x0, x0, #1
               	add	x0, x1, x0
               	mov	x17, #0x7               // =7
               	mul	x1, x20, x17
               	add	x1, x1, #0x9
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	add	x5, x0, x1
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x4, x2
               	b	<addr>
               	add	x4, x4, x0
               	cmp	w3, #0x2
               	b.lo	<addr>
               	mov	x1, x2
               	mov	x3, x2
               	b	<addr>
               	add	x0, x0, x20
               	mov	x1, #0x2                // =2
               	mov	x3, x2
               	b	<addr>
               	mov	w3, w1
               	cbnz	x3, <addr>
               	mov	x17, #0x5               // =5
               	mul	x0, x4, x17
               	add	x21, x5, x0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	asr	x0, x20, #1
               	lsl	x0, x0, #4
               	add	x0, x20, x0
               	sxtw	x0, w0
               	add	x0, x0, x20
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x7               // =7
               	mul	x0, x20, x17
               	add	x0, x0, #0x9
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x2, #0x0                // =0
               	mov	x1, #0x1                // =1
               	mov	x0, #0x5                // =5
               	mov	x4, x2
               	b	<addr>
               	add	x4, x4, x0
               	cmp	w3, #0x2
               	b.lo	<addr>
               	mov	x1, x2
               	mov	x3, x2
               	b	<addr>
               	add	x0, x0, x20
               	mov	x1, #0x2                // =2
               	mov	x3, x2
               	b	<addr>
               	mov	w3, w1
               	cbnz	x3, <addr>
               	cmp	x4, #0xd
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	cmp	x21, #0x177
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
