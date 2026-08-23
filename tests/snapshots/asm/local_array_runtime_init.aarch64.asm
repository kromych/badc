
local_array_runtime_init.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1234             // =4660
               	strh	w0, [x1, #0xa]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x5678             // =22136
               	strh	w0, [x2, #0xa]
               	sub	x0, x29, #0x8
               	mov	x3, #0x0                // =0
               	str	w3, [x0]
               	ldrh	w1, [x1, #0xa]
               	strh	w1, [x0]
               	ldrh	w1, [x2, #0xa]
               	strh	w1, [x0, #0x2]
               	ldrh	w1, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	ldrh	w2, [x0, #0x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	mov	x17, #0x7198            // =29080
               	movk	x17, #0x47, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w3, [x0]
               	mov	x1, #0x63               // =99
               	strb	w1, [x0]
               	mov	x1, #0x62               // =98
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x64               // =100
               	strb	w1, [x0, #0x3]
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	add	x1, x1, #0x0
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrb	w0, [x0, #0x3]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
