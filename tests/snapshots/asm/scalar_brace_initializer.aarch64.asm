
scalar_brace_initializer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x5                // =5
               	adrp	x1, <page>
               	add	x1, x1, #0xd8
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	mov	x3, #0x7                // =7
               	sxtw	x4, w2
               	add	x4, x0, x4
               	sxtw	x4, w4
               	sxtw	x4, w4
               	cmp	x4, #0xb
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, #0xd0
               	ldrsw	x4, [x4]
               	cmp	x4, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x1]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x5, #0x1                // =1
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x1]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x5, ne
               	b	<addr>
               	cbnz	x5, <addr>
               	ldrb	w0, [x1, #0x2]
               	cmp	x0, #0x0
               	cset	x5, ne
               	b	<addr>
               	cbz	x5, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w2
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x3, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldr	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
