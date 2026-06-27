
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	mov	x0, #0x20               // =32
               	add	x0, x0, x20
               	asr	x0, x0, #2
               	cmp	x0, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x1               // =1
               	mov	x0, #0x18               // =24
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x18               // =24
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	mov	x0, #0x40               // =64
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x3               // =3
               	mov	x0, #0x40               // =64
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x40               // =64
               	mov	x20, #0x4               // =4
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x18               // =24
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x18               // =24
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	mov	x0, #0x20               // =32
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x20               // =32
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x6               // =6
               	mov	x0, #0x18               // =24
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	asr	x0, x0, #2
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x18               // =24
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	sxtw	x0, w20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
