
anonymous_aggregates.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x30
               	mov	x1, #0xcdef             // =52719
               	movk	x1, #0x90ab, lsl #16
               	movk	x1, #0x5678, lsl #32
               	movk	x1, #0x1234, lsl #48
               	str	x1, [x0]
               	ldr	w1, [x0]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xbabe             // =47806
               	movk	x1, #0xcafe, lsl #16
               	str	w1, [x0]
               	mov	x1, #0xf00d             // =61453
               	movk	x1, #0xbad, lsl #16
               	str	w1, [x0, #0x4]
               	ldr	x0, [x0]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x4]
               	mov	x1, #0x5678             // =22136
               	strh	w1, [x0, #0x6]
               	mov	x1, #0x9                // =9
               	str	w1, [x0, #0x8]
               	ldrsw	x0, [x0, #0x4]
               	mov	w0, w0
               	mov	x17, #0x1234            // =4660
               	movk	x17, #0x5678, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
