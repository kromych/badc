
int128_overflow_builtin.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	mov	x1, #0x7b               // =123
               	str	w1, [x0]
               	ldur	w1, [x29, #-0x8]
               	cmp	w1, #0x7b
               	b.eq	<addr>
               	mov	x1, #0x38               // =56
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x2, #-0x2               // =-2
               	str	w2, [x0]
               	ldursw	x2, [x29, #-0x8]
               	asr	x3, x2, #63
               	mov	x17, #-0x2              // =-2
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x2, #0x3e               // =62
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w1, [x0]
               	mov	x2, #-0x1               // =-1
               	str	x2, [x0]
               	ldur	x2, [x29, #-0x8]
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x44               // =68
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0xf               // =-15
               	str	x2, [x0]
               	ldur	x2, [x29, #-0x8]
               	asr	x3, x2, #63
               	mov	x17, #-0xf              // =-15
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x47               // =71
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	str	x2, [x0]
               	ldur	x0, [x29, #-0x8]
               	asr	x2, x0, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #-0x1              // =-1
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x4b               // =75
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x2, #0x48               // =72
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x2, #0x3f               // =63
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
