
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
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	ldrb	w0, [x0, #0x2]
               	orr	x0, x1, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x11               // =17
               	sturb	w0, [x29, #-0x10]
               	mov	x0, #0x22               // =34
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0x33               // =51
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0x44               // =68
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0x55               // =85
               	sturb	w0, [x29, #-0xc]
               	mov	x0, #0x66               // =102
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #0x77               // =119
               	sturb	w0, [x29, #-0xa]
               	mov	x0, #0x88               // =136
               	sturb	w0, [x29, #-0x9]
               	mov	x0, #0x99               // =153
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0xaa               // =170
               	sturb	w0, [x29, #-0x7]
               	mov	x0, #0xbb               // =187
               	sturb	w0, [x29, #-0x6]
               	mov	x0, #0xcc               // =204
               	sturb	w0, [x29, #-0x5]
               	mov	x0, #0xdd               // =221
               	sturb	w0, [x29, #-0x4]
               	mov	x0, #0xee               // =238
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x2]
               	mov	x0, #0x10               // =16
               	sturb	w0, [x29, #-0x1]
               	sub	x0, x29, #0x10
               	ldr	w1, [x0]
               	rev	w1, w1
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w1, [x0]
               	mov	x17, #0x2211            // =8721
               	movk	x17, #0x4433, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x1]
               	rev	w1, w1
               	mov	x17, #0x4455            // =17493
               	movk	x17, #0x2233, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w1, [x0, #0x3]
               	mov	x17, #0x5544            // =21828
               	movk	x17, #0x7766, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	rev	x1, x1
               	mov	x17, #0x7788            // =30600
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x0, #0x1]
               	rev	x1, x1
               	mov	x17, #0x8899            // =34969
               	movk	x17, #0x6677, lsl #16
               	movk	x17, #0x4455, lsl #32
               	movk	x17, #0x2233, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurh	w0, [x0, #0x5]
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
