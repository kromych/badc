
pthread_lifecycle.aarch64:	file format elf64-littleaarch64

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

<returns>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<exits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, #0x2
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<detached>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x1
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<deep>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x800
               	sxtw	x0, w0
               	sub	x1, x29, #0x800
               	and	x2, x0, #0xff
               	strb	w2, [x1]
               	strb	w2, [x1, #0x7ff]
               	cbz	x0, <addr>
               	sub	x0, x0, #0x1
               	bl	<addr>
               	sub	x1, x29, #0x800
               	ldrb	w2, [x1]
               	add	x0, x0, x2
               	ldrb	w1, [x1, #0x7ff]
               	sub	x0, x0, x1
               	add	sp, sp, #0x800
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<uses_stack>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	w0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x41               // =65
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x42               // =66
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x70]
               	sub	x1, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x43               // =67
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x60]
               	sub	x1, x29, #0x48
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x44               // =68
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldur	x1, [x29, #-0x70]
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x45               // =69
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x46               // =70
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x22, x29, #0x70
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x48
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x47               // =71
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x70]
               	sub	x1, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x48               // =72
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x60]
               	sub	x1, x29, #0x48
               	add	x1, x1, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x1, x29, #0x60
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x23
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4d               // =77
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x23, x29, #0x40
               	mov	x1, #0x1                // =1
               	mov	x0, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4e               // =78
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x22
               	mov	x3, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x51               // =81
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x52               // =82
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x70]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x53               // =83
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5a               // =90
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x1000000          // =16777216
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5b               // =91
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x58
               	sub	x2, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5c               // =92
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #0x1000000         // =16777216
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5d               // =93
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5e               // =94
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x50]
               	cmp	x0, #0x0
               	b.hi	<addr>
               	mov	x0, #0x5f               // =95
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1388             // =5000
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x60               // =96
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x70]
               	sub	x1, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x60]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x62               // =98
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	cmp	w20, w21
               	b.le	<addr>
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x69               // =105
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6a               // =106
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6b               // =107
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6c               // =108
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6d               // =109
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x1, x29, #0x68
               	add	x0, x20, x21
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	asr	x0, x0, #1
               	str	w0, [x1]
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6f               // =111
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x1, x29, #0x68
               	sub	x0, x20, #0x1
               	str	w0, [x1]
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x71               // =113
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldursw	x1, [x29, #-0x68]
               	add	x0, x20, x21
               	sxtw	x0, w0
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	asr	x0, x0, #1
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x72               // =114
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x73               // =115
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x70]
               	sub	x1, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x74               // =116
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x60]
               	sub	x1, x29, #0x48
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x75               // =117
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x76               // =118
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x50               // =80
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
