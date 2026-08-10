
local_array_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<probe_char>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x0, #0x63               // =99
               	sub	x2, x29, #0x8
               	strb	w0, [x2]
               	mov	x2, #0x62               // =98
               	sub	x0, x29, #0x8
               	strb	w2, [x0, #0x1]
               	mov	x2, #0x3                // =3
               	sub	x0, x29, #0x8
               	strb	w2, [x0, #0x2]
               	mov	x2, #0x64               // =100
               	sub	x0, x29, #0x8
               	strb	w2, [x0, #0x3]
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	add	x0, x0, #0x0
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x2]
               	add	x0, x0, x1
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1, #0x3]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0xa]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5678             // =22136
               	strh	w2, [x1, #0xa]
               	ldrh	w0, [x0, #0xa]
               	ldrh	w1, [x1, #0xa]
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x7198            // =29080
               	movk	x17, #0x47, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
