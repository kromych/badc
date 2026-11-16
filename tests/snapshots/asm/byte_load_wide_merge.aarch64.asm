
byte_load_wide_merge.aarch64:	file format elf64-littleaarch64

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

<load_be32>:
               	ldr	w0, [x0]
               	rev	w0, w0
               	ret

<load_le32>:
               	ldr	w0, [x0]
               	ret

<load_be64>:
               	ldr	x0, [x0]
               	rev	x0, x0
               	ret

<load_le16>:
               	ldrh	w0, [x0]
               	ret

<load_be24>:
               	ldrb	w1, [x0]
               	lsl	x1, x1, #16
               	ldrb	w2, [x0, #0x1]
               	orr	x1, x1, x2, lsl #8
               	ldrb	w0, [x0, #0x2]
               	orr	x0, x1, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2211             // =8721
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x4433             // =17459
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x6655             // =26197
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x8877             // =34935
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0xaa99             // =43673
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0xccbb             // =52411
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0xeedd             // =61149
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x10ff             // =4351
               	sturh	w0, [x29, #-0x2]
               	ldur	w0, [x29, #-0x10]
               	rev	w1, w0
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x2211            // =8721
               	movk	x17, #0x4433, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0xf]
               	rev	w0, w0
               	mov	x17, #0x4455            // =17493
               	movk	x17, #0x2233, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0xd]
               	mov	x17, #0x5544            // =21828
               	movk	x17, #0x7766, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	rev	x0, x0
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0xf]
               	rev	x0, x0
               	mov	x17, #0x8899            // =34969
               	movk	x17, #0x6677, lsl #16
               	movk	x17, #0x4455, lsl #32
               	movk	x17, #0x2233, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x29, #-0xb]
               	mov	x17, #0x7766            // =30566
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
