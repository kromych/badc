
pthread_mutex_cond.aarch64:	file format elf64-littleaarch64

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

<try_lock>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x20, x0
               	cbnz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<unlock>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<from_thread>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<consume>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x21, #0x0               // =0
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
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x3e8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<wait_go>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
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
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<ms_since>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldr	x1, [x20]
               	sub	x0, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x0, x17
               	ldur	x0, [x29, #-0x8]
               	ldr	x2, [x20, #0x8]
               	sub	x0, x0, x2
               	mov	x2, #0x34db             // =13531
               	movk	x2, #0xd7b6, lsl #16
               	movk	x2, #0xde82, lsl #32
               	movk	x2, #0x431b, lsl #48
               	smulh	x0, x0, x2
               	asr	x0, x0, #18
               	lsr	x2, x0, #63
               	add	x0, x0, x2
               	add	x0, x1, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<times_out>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, x0
               	mov	x20, x1
               	sub	x1, x29, #0x20
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xf080            // =61568
               	movk	x17, #0x2fa, lsl #16
               	add	x1, x0, x17
               	stur	x1, [x29, #-0x8]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x1, x17
               	b.lt	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	sub	x0, x0, x17
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x10
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w21, #0x6e
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	sub	x1, x29, #0x20
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x32
               	cset	x0, ge
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x61               // =97
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x62               // =98
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x64               // =100
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x65               // =101
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x66               // =102
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x69               // =105
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6a               // =106
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x6b               // =107
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6c               // =108
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x6d               // =109
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6e               // =110
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x70               // =112
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x71               // =113
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x72               // =114
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x73               // =115
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x75               // =117
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x76               // =118
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x77               // =119
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x23
               	b.eq	<addr>
               	mov	x0, #0x78               // =120
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7a               // =122
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7b               // =123
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7c               // =124
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7d               // =125
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x70
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7e               // =126
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x80               // =128
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x81               // =129
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x82               // =130
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x83               // =131
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x84               // =132
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x85               // =133
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x88               // =136
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x1               // =1
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
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w21, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x3e8
               	b.le	<addr>
               	sub	x22, x29, #0x50
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x92               // =146
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0xa314            // =41748
               	movk	x17, #0x7, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x93               // =147
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	lsl	x0, x20, #3
               	add	x0, x22, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x21
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	ldr	x0, [x22, x20, lsl #3]
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9d               // =157
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x60
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x6e
               	b.eq	<addr>
               	mov	x0, #0xa0               // =160
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x2, x29, #0x60
               	mov	x0, #0xca00             // =51712
               	movk	x0, #0x3b9a, lsl #16
               	stur	x0, [x29, #-0x58]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0xa2               // =162
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xa4               // =164
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x68
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa9               // =169
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x68
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xaa               // =170
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x68
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xab               // =171
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x68
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xac               // =172
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0xad               // =173
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x30
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xae               // =174
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x9c               // =156
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x96               // =150
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
