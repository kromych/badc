
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
               	sub	sp, sp, #0x10
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x90ab, lsl #16
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	stur	x0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xbabe             // =47806
               	movk	x0, #0xcafe, lsl #16
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xf00d             // =61453
               	movk	x0, #0xbad, lsl #16
               	stur	w0, [x29, #-0x4]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x1234             // =4660
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x5678             // =22136
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0xc]
               	mov	x17, #0x1234            // =4660
               	movk	x17, #0x5678, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
