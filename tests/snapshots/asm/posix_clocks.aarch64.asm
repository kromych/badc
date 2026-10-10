
posix_clocks.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	sub	x0, x29, #0x80
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	ldrsw	x0, [x21, x20, lsl #2]
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0xb0]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0xa8]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0xa8]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	ldrsw	x0, [x21, x20, lsl #2]
               	sub	x1, x29, #0x90
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x90]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x88]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x88]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	ldur	x0, [x29, #-0x90]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x88]
               	cbz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	stur	x20, [x29, #-0xb8]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0xb0]
               	sub	x1, x20, #0x5
               	cmp	x0, x1
               	b.lt	<addr>
               	ldur	x0, [x29, #-0xb0]
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x70]
               	sub	x1, x20, #0x5
               	cmp	x0, x1
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x70]
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldur	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x68]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xa0
               	bl	<addr>
               	sub	x2, x29, #0xa0
               	ldur	x0, [x29, #-0xa0]
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x0, x17
               	ldur	x1, [x29, #-0x98]
               	mov	x0, #0x34db             // =13531
               	movk	x0, #0xd7b6, lsl #16
               	movk	x0, #0xde82, lsl #32
               	movk	x0, #0x431b, lsl #48
               	smulh	x1, x1, x0
               	asr	x1, x1, #18
               	lsr	x4, x1, #63
               	add	x1, x1, x4
               	add	x1, x3, x1
               	sub	x3, x29, #0xb0
               	ldur	x4, [x29, #-0xb0]
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	ldur	x5, [x29, #-0xa8]
               	smulh	x0, x5, x0
               	asr	x0, x0, #18
               	lsr	x5, x0, #63
               	add	x0, x0, x5
               	add	x0, x4, x0
               	sub	x0, x1, x0
               	cmp	x0, #0x14
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x3]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x2, x29, #0xa0
               	ldur	x0, [x29, #-0x98]
               	mov	x17, #0xc380            // =50048
               	movk	x17, #0x1c9, lsl #16
               	add	x0, x0, x17
               	stur	x0, [x29, #-0x98]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x98]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	sub	x0, x0, x17
               	stur	x0, [x29, #-0x98]
               	ldur	x0, [x29, #-0xa0]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0xa0]
               	mov	x0, #0x1                // =1
               	mov	x3, #0x0                // =0
               	mov	x1, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	ldur	x0, [x29, #-0xb0]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x0, x17
               	ldur	x1, [x29, #-0xa8]
               	mov	x0, #0x34db             // =13531
               	movk	x0, #0xd7b6, lsl #16
               	movk	x0, #0xde82, lsl #32
               	movk	x0, #0x431b, lsl #48
               	smulh	x1, x1, x0
               	asr	x1, x1, #18
               	lsr	x3, x1, #63
               	add	x1, x1, x3
               	add	x1, x2, x1
               	ldur	x2, [x29, #-0xa0]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	ldur	x3, [x29, #-0x98]
               	smulh	x0, x3, x0
               	asr	x0, x0, #18
               	lsr	x3, x0, #63
               	add	x0, x0, x3
               	add	x0, x2, x0
               	cmp	x1, x0
               	b.ge	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #-0x1               // =-1
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x80
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x80
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldur	w1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x8]
               	add	x0, x0, #0x1
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	cmp	w0, w17
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	sub	x1, x29, #0xa0
               	bl	<addr>
               	ldur	x0, [x29, #-0xa0]
               	ldur	x1, [x29, #-0xb0]
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x98]
               	ldur	x1, [x29, #-0xa8]
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x90
               	bl	<addr>
               	ldur	x0, [x29, #-0x90]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x0, x17
               	ldur	x1, [x29, #-0x88]
               	mov	x0, #0x34db             // =13531
               	movk	x0, #0xd7b6, lsl #16
               	movk	x0, #0xde82, lsl #32
               	movk	x0, #0x431b, lsl #48
               	smulh	x1, x1, x0
               	asr	x1, x1, #18
               	lsr	x3, x1, #63
               	add	x1, x1, x3
               	add	x1, x2, x1
               	ldur	x2, [x29, #-0x80]
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	ldur	x3, [x29, #-0x78]
               	smulh	x0, x3, x0
               	asr	x0, x0, #18
               	lsr	x3, x0, #63
               	add	x0, x0, x3
               	add	x0, x2, x0
               	sub	x0, x1, x0
               	mov	x17, #0x1388            // =5000
               	cmp	x0, x17
               	b.le	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	bl	<addr>
               	str	wzr, [x0]
               	mov	x0, #-0x1               // =-1
               	sub	x1, x29, #0xb0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	stur	xzr, [x29, #-0x80]
               	mov	x0, #0xca00             // =51712
               	movk	x0, #0x3b9a, lsl #16
               	stur	x0, [x29, #-0x78]
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	sub	x0, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	bl	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x3380             // =13184
               	movk	x0, #0x1e1, lsl #16
               	stur	x0, [x29, #-0xb8]
               	sub	x0, x29, #0xb8
               	sub	x1, x29, #0x40
               	bl	<addr>
               	cbz	x0, <addr>
               	ldursw	x0, [x29, #-0x2c]
               	cmp	w0, #0x47
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x30]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x34]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldursw	x0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	ldursw	x0, [x29, #-0x24]
               	cbz	w0, <addr>
               	mov	x0, #0x33               // =51
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0xb8]
               	sub	x0, x29, #0xb8
               	sub	x1, x29, #0x40
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x34               // =52
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x0, x29, #0xb8
               	bl	<addr>
               	ldr	w1, [x0]
               	ldr	w2, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x14]
               	ldr	w0, [x0, #0x20]
               	ldursw	x6, [x29, #-0x40]
               	cmp	w6, w1
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x3c]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x38]
               	cmp	w1, w3
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	ldursw	x1, [x29, #-0x34]
               	cmp	w1, w4
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x2c]
               	cmp	w1, w5
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x20]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x36               // =54
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	sub	x0, x29, #0xb8
               	sub	x1, x29, #0x60
               	bl	<addr>
               	cbz	x0, <addr>
               	sub	x0, x29, #0xb8
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x37               // =55
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	add	x0, x20, #0x1e
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	add	x0, x20, #0x14
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	add	x0, x20, #0xa
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
