
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
               	ldr	w1, [x0]
               	rev	w0, w1
               	mov	w0, w0
               	ret

<load_le32>:
               	ldr	w0, [x0]
               	mov	w0, w0
               	ret

<load_be64>:
               	ldr	x1, [x0]
               	rev	x0, x1
               	ret

<load_le16>:
               	ldrh	w0, [x0]
               	mov	w0, w0
               	ret

<load_be24>:
               	ldrb	w1, [x0]
               	lsl	x1, x1, #16
               	mov	w1, w1
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #8
               	mov	w2, w2
               	orr	x1, x1, x2
               	ldrb	w0, [x0, #0x2]
               	orr	x0, x1, x0
               	mov	w0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x0
               	mov	x1, #0x11               // =17
               	strb	w1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x22               // =34
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x10
               	mov	x1, #0x33               // =51
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x10
               	mov	x1, #0x44               // =68
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x10
               	mov	x1, #0x55               // =85
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x10
               	mov	x1, #0x66               // =102
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x10
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x10
               	mov	x1, #0x88               // =136
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x10
               	mov	x1, #0x99               // =153
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x1, #0xaa               // =170
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x10
               	mov	x1, #0xbb               // =187
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x10
               	mov	x1, #0xcc               // =204
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x10
               	mov	x1, #0xdd               // =221
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x10
               	mov	x1, #0xee               // =238
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x10
               	mov	x1, #0xff               // =255
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x10
               	mov	x1, #0x10               // =16
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	rev	w0, w1
               	mov	w0, w0
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x2211            // =8721
               	movk	x17, #0x4433, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x1
               	ldr	w1, [x0]
               	rev	w0, w1
               	mov	w0, w0
               	mov	x17, #0x4455            // =17493
               	movk	x17, #0x2233, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x3
               	ldr	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x5544            // =21828
               	movk	x17, #0x7766, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	bl	<addr>
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
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x1
               	bl	<addr>
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
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x5
               	ldrh	w0, [x0]
               	mov	w0, w0
               	mov	x17, #0x7766            // =30566
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x2
               	ldrb	w1, [x0]
               	lsl	x1, x1, #16
               	mov	w1, w1
               	ldrb	w2, [x0, #0x1]
               	lsl	x2, x2, #8
               	mov	w2, w2
               	orr	x1, x1, x2
               	ldrb	w0, [x0, #0x2]
               	orr	x0, x1, x0
               	mov	w0, w0
               	mov	x17, #0x4455            // =17493
               	movk	x17, #0x33, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
