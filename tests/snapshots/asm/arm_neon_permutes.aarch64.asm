
arm_neon_permutes.aarch64:	file format elf64-littleaarch64

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

<check_s8q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x42c2             // =17090
               	sturh	w0, [x29, #-0x20]
               	sturh	w1, [x29, #-0x10]
               	mov	x0, #0x4fe              // =1278
               	mov	x1, #0xcf3              // =3315
               	sturh	w0, [x29, #-0x1e]
               	sturh	w1, [x29, #-0xe]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x8778             // =34680
               	sturh	w0, [x29, #-0x1c]
               	sturh	w1, [x29, #-0xc]
               	mov	x0, #0x37ff             // =14335
               	mov	x1, #0x6f8              // =1784
               	sturh	w0, [x29, #-0x1a]
               	sturh	w1, [x29, #-0xa]
               	mov	x0, #0xfb9d             // =64413
               	mov	x1, #0x545c             // =21596
               	sturh	w0, [x29, #-0x18]
               	sturh	w1, [x29, #-0x8]
               	mov	x0, #0x7b84             // =31620
               	mov	x1, #0x2ab              // =683
               	sturh	w0, [x29, #-0x16]
               	sturh	w1, [x29, #-0x6]
               	mov	x0, #0xf807             // =63495
               	mov	x1, #0xfd07             // =64775
               	sturh	w0, [x29, #-0x14]
               	sturh	w1, [x29, #-0x4]
               	mov	x0, #0x41c1             // =16833
               	mov	x1, #0x827d             // =33405
               	sturh	w0, [x29, #-0x12]
               	sturh	w1, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x80]
               	zip2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x50]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrsb	x4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x8
               	ldrsb	x5, [x5, x1]
               	cmp	w3, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrsb	x6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrsb	x3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrsb	x7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsb	x2, [x1, x0]
               	sub	x1, x29, #0x80
               	ldrsb	x8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrsb	x3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrsb	x2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrsb	x7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x10
               	ldrsb	x3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x10
               	ldrsb	x6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x8
               	ldrsb	x5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrsb	x4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u8q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x42c2             // =17090
               	sturh	w0, [x29, #-0x20]
               	sturh	w1, [x29, #-0x10]
               	mov	x0, #0x4fe              // =1278
               	mov	x1, #0xcf3              // =3315
               	sturh	w0, [x29, #-0x1e]
               	sturh	w1, [x29, #-0xe]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x8778             // =34680
               	sturh	w0, [x29, #-0x1c]
               	sturh	w1, [x29, #-0xc]
               	mov	x0, #0x37ff             // =14335
               	mov	x1, #0x6f8              // =1784
               	sturh	w0, [x29, #-0x1a]
               	sturh	w1, [x29, #-0xa]
               	mov	x0, #0xfb9d             // =64413
               	mov	x1, #0x545c             // =21596
               	sturh	w0, [x29, #-0x18]
               	sturh	w1, [x29, #-0x8]
               	mov	x0, #0x7b84             // =31620
               	mov	x1, #0x2ab              // =683
               	sturh	w0, [x29, #-0x16]
               	sturh	w1, [x29, #-0x6]
               	mov	x0, #0xf807             // =63495
               	mov	x1, #0xfd07             // =64775
               	sturh	w0, [x29, #-0x14]
               	sturh	w1, [x29, #-0x4]
               	mov	x0, #0x41c1             // =16833
               	mov	x1, #0x827d             // =33405
               	sturh	w0, [x29, #-0x12]
               	sturh	w1, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x80]
               	zip2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x50]
               	trn1	v2.16b, v0.16b, v1.16b
               	stur	q2, [x29, #-0x40]
               	trn2	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrb	w4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x8
               	ldrb	w5, [x5, x1]
               	cmp	w3, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrb	w6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrb	w3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrb	w7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrb	w2, [x1, x0]
               	sub	x1, x29, #0x80
               	ldrb	w8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrb	w4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrb	w4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrb	w4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrb	w3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrb	w1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrb	w2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrb	w7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x10
               	ldrb	w3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x10
               	ldrb	w6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x8
               	ldrb	w5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrb	w4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x40]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x38]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x3e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0x36]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x3c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0x34]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x3a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0x32]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x30]
               	zip2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x18]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x38
               	ldrsh	x4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x38
               	add	x1, x1, #0x2
               	ldrsh	x5, [x5, x1, lsl #1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	ldrsh	x6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	ldrsh	x3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	sub	x7, x0, #0x1
               	ldrsh	x7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	ldrsh	x2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x30
               	ldrsh	x8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrsh	x3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x2, x0, #0x1
               	ldrsh	x2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrsh	x7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x38
               	sub	x1, x1, #0x4
               	ldrsh	x3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x38
               	sub	x6, x3, #0x4
               	ldrsh	x6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x40
               	add	x1, x1, #0x2
               	ldrsh	x5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x40
               	ldrsh	x4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x1e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x1c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x1a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x18]
               	mov	x0, #0x278              // =632
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x100              // =256
               	sturh	w0, [x29, #-0x16]
               	mov	x0, #0x287              // =647
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x1ff              // =511
               	sturh	w0, [x29, #-0x14]
               	mov	x0, #0x4f8              // =1272
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x37               // =55
               	sturh	w0, [x29, #-0x12]
               	mov	x0, #0x106              // =262
               	sturh	w0, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x80]
               	zip2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x50]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrsh	x4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x4
               	ldrsh	x5, [x5, x1, lsl #1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrsh	x6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrsh	x3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrsh	x7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsh	x2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x80
               	ldrsh	x8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrsh	x3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrsh	x2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrsh	x7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x8
               	ldrsh	x3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x8
               	ldrsh	x6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x4
               	ldrsh	x5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrsh	x4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x40]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x38]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x3e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0x36]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x3c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0x34]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x3a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0x32]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x30]
               	zip2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x18]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x10]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x38
               	ldrh	w4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x38
               	add	x1, x1, #0x2
               	ldrh	w5, [x5, x1, lsl #1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	ldrh	w6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	ldrh	w3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	sub	x7, x0, #0x1
               	ldrh	w7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	ldrh	w2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x30
               	ldrh	w8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x2, x0, #0x1
               	ldrh	w2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrh	w7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x38
               	sub	x1, x1, #0x4
               	ldrh	w3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x38
               	sub	x6, x3, #0x4
               	ldrh	w6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x40
               	add	x1, x1, #0x2
               	ldrh	w5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x40
               	ldrh	w4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	sturh	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	sturh	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	sturh	w0, [x29, #-0x1e]
               	mov	x0, #0x142              // =322
               	sturh	w0, [x29, #-0xe]
               	mov	x0, #0x2fe              // =766
               	sturh	w0, [x29, #-0x1c]
               	mov	x0, #0x4f3              // =1267
               	sturh	w0, [x29, #-0xc]
               	mov	x0, #0x4                // =4
               	sturh	w0, [x29, #-0x1a]
               	mov	x0, #0xc                // =12
               	sturh	w0, [x29, #-0xa]
               	mov	x0, #0x1                // =1
               	sturh	w0, [x29, #-0x18]
               	mov	x0, #0x278              // =632
               	sturh	w0, [x29, #-0x8]
               	mov	x0, #0x100              // =256
               	sturh	w0, [x29, #-0x16]
               	mov	x0, #0x287              // =647
               	sturh	w0, [x29, #-0x6]
               	mov	x0, #0x1ff              // =511
               	sturh	w0, [x29, #-0x14]
               	mov	x0, #0x4f8              // =1272
               	sturh	w0, [x29, #-0x4]
               	mov	x0, #0x37               // =55
               	sturh	w0, [x29, #-0x12]
               	mov	x0, #0x106              // =262
               	sturh	w0, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x80]
               	zip2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x50]
               	trn1	v2.8h, v0.8h, v1.8h
               	stur	q2, [x29, #-0x40]
               	trn2	v0.8h, v0.8h, v1.8h
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldrh	w4, [x4, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x4
               	ldrh	w5, [x5, x1, lsl #1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldrh	w6, [x1, x3, lsl #1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldrh	w3, [x3, x1, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldrh	w7, [x1, x7, lsl #1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrh	w2, [x1, x0, lsl #1]
               	sub	x1, x29, #0x80
               	ldrh	w8, [x1, x0, lsl #1]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldrh	w3, [x3, x0, lsl #1]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldrh	w2, [x1, x2, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldrh	w7, [x1, x0, lsl #1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x8
               	ldrh	w3, [x3, x1, lsl #1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x8
               	ldrh	w6, [x1, x6, lsl #1]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x4
               	ldrh	w5, [x5, x1, lsl #1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldrh	w4, [x4, x1, lsl #1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x181              // =385
               	movk	x0, #0x17e, lsl #32
               	mov	x1, #0x3c2              // =962
               	movk	x1, #0x142, lsl #32
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	zip2	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x18]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x10]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldursw	x3, [x29, #-0x38]
               	cbz	x1, <addr>
               	ldursw	x4, [x29, #-0x34]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x40
               	ldrsw	x5, [x5, x2, lsl #2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldursw	x2, [x29, #-0x3c]
               	cbz	x1, <addr>
               	sub	x6, x29, #0x38
               	sub	x7, x0, #0x1
               	ldrsw	x6, [x6, x7, lsl #2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x38
               	ldrsw	x7, [x1, x0, lsl #2]
               	sub	x1, x29, #0x30
               	ldrsw	x8, [x1, x0, lsl #2]
               	cmp	w8, w3
               	b.ne	<addr>
               	add	x3, x1, #0x8
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w5
               	b.ne	<addr>
               	add	x3, x1, #0x18
               	ldrsw	x3, [x3, x0, lsl #2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x2, x1, #0x20
               	ldrsw	x2, [x2, x0, lsl #2]
               	cmp	w2, w6
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w7
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x7, x0, #0x1
               	ldrsw	x7, [x1, x7, lsl #2]
               	b	<addr>
               	sub	x6, x29, #0x40
               	ldrsw	x6, [x6, x0, lsl #2]
               	b	<addr>
               	sub	x6, x29, #0x38
               	sub	x2, x2, #0x2
               	ldrsw	x2, [x6, x2, lsl #2]
               	b	<addr>
               	ldursw	x5, [x29, #-0x38]
               	b	<addr>
               	ldursw	x4, [x29, #-0x3c]
               	b	<addr>
               	ldursw	x3, [x29, #-0x40]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u32q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	stur	w0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	stur	w0, [x29, #-0x1c]
               	mov	x0, #0x142              // =322
               	stur	w0, [x29, #-0xc]
               	mov	x0, #0x2fe              // =766
               	stur	w0, [x29, #-0x18]
               	mov	x0, #0x4f3              // =1267
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x14]
               	mov	x0, #0xc                // =12
               	stur	w0, [x29, #-0x4]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x80]
               	zip2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x50]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	ldr	w4, [x4, x1, lsl #2]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x10
               	add	x1, x1, #0x2
               	ldr	w5, [x5, x1, lsl #2]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	ldr	w6, [x1, x3, lsl #2]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	ldr	w3, [x3, x1, lsl #2]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x7, x0, #0x1
               	ldr	w7, [x1, x7, lsl #2]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldr	w2, [x1, x0, lsl #2]
               	sub	x1, x29, #0x80
               	ldr	w8, [x1, x0, lsl #2]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x20
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x30
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	ldr	w3, [x3, x0, lsl #2]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	ldr	w2, [x1, x2, lsl #2]
               	b	<addr>
               	sub	x1, x29, #0x20
               	ldr	w7, [x1, x0, lsl #2]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x4
               	ldr	w3, [x3, x1, lsl #2]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x6, x3, #0x4
               	ldr	w6, [x1, x6, lsl #2]
               	b	<addr>
               	sub	x5, x29, #0x20
               	add	x1, x1, #0x2
               	ldr	w5, [x5, x1, lsl #2]
               	b	<addr>
               	sub	x4, x29, #0x20
               	ldr	w4, [x4, x1, lsl #2]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x78]
               	stur	s0, [x29, #-0x40]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x7c]
               	stur	s0, [x29, #-0x38]
               	mov	x16, #0x43bf0000        // =1136590848
               	fmov	s0, w16
               	stur	s0, [x29, #-0x3c]
               	mov	x16, #0x43a10000        // =1134624768
               	fmov	s0, w16
               	stur	s0, [x29, #-0x34]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x30]
               	zip2	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x18]
               	trn1	v2.2s, v0.2s, v1.2s
               	stur	d2, [x29, #-0x10]
               	trn2	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	s0, [x29, #-0x38]
               	cbz	x1, <addr>
               	ldur	s1, [x29, #-0x34]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	add	x3, x3, x2, lsl #2
               	ldr	s2, [x3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	s3, [x29, #-0x3c]
               	cbz	x1, <addr>
               	sub	x2, x29, #0x38
               	sub	x3, x0, #0x1
               	add	x2, x2, x3, lsl #2
               	ldr	s4, [x2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x38
               	add	x1, x1, x0, lsl #2
               	ldr	s5, [x1]
               	sub	x1, x29, #0x30
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	ldr	s6, [x3]
               	fcmp	s6, s0
               	b.ne	<addr>
               	add	x3, x1, #0x8
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s2
               	b.ne	<addr>
               	add	x3, x1, #0x18
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s4
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	add	x1, x1, x2
               	ldr	s0, [x1]
               	fcmp	s0, s5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #2
               	ldr	s5, [x1]
               	b	<addr>
               	sub	x2, x29, #0x40
               	add	x2, x2, x0, lsl #2
               	ldr	s4, [x2]
               	b	<addr>
               	sub	x3, x29, #0x38
               	sub	x2, x2, #0x2
               	add	x2, x3, x2, lsl #2
               	ldr	s3, [x2]
               	b	<addr>
               	ldur	s2, [x29, #-0x38]
               	b	<addr>
               	ldur	s1, [x29, #-0x3c]
               	b	<addr>
               	ldur	s0, [x29, #-0x40]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x78]
               	stur	s0, [x29, #-0x20]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x7c]
               	stur	s0, [x29, #-0x10]
               	mov	x16, #0x43bf0000        // =1136590848
               	fmov	s0, w16
               	stur	s0, [x29, #-0x1c]
               	mov	x16, #0x43a10000        // =1134624768
               	fmov	s0, w16
               	stur	s0, [x29, #-0xc]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x80]
               	stur	s0, [x29, #-0x18]
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x84]
               	stur	s0, [x29, #-0x8]
               	fmov	s0, #4.00000000
               	stur	s0, [x29, #-0x14]
               	fmov	s0, #12.00000000
               	stur	s0, [x29, #-0x4]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x80]
               	zip2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x50]
               	trn1	v2.4s, v0.4s, v1.4s
               	stur	q2, [x29, #-0x40]
               	trn2	v0.4s, v0.4s, v1.4s
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	add	x4, x4, x1, lsl #2
               	ldr	s0, [x4]
               	cbz	x2, <addr>
               	sub	x4, x29, #0x10
               	add	x1, x1, #0x2
               	add	x1, x4, x1, lsl #2
               	ldr	s1, [x1]
               	cmp	w3, #0x4
               	b.ge	<addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, x3, lsl #2
               	ldr	s2, [x1]
               	add	x1, x3, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	add	x1, x3, x1, lsl #2
               	ldr	s3, [x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	sub	x3, x0, #0x1
               	add	x1, x1, x3, lsl #2
               	ldr	s4, [x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, x0, lsl #2
               	ldr	s5, [x1]
               	sub	x1, x29, #0x80
               	lsl	x2, x0, #2
               	add	x3, x1, x2
               	ldr	s6, [x3]
               	fcmp	s6, s0
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s1
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s2
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	add	x3, x3, x2
               	ldr	s0, [x3]
               	fcmp	s0, s4
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	add	x1, x1, x2
               	ldr	s0, [x1]
               	fcmp	s0, s5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #2
               	ldr	s5, [x1]
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, x0, lsl #2
               	ldr	s4, [x1]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x1, x1, #0x4
               	add	x1, x3, x1, lsl #2
               	ldr	s3, [x1]
               	b	<addr>
               	sub	x1, x29, #0x10
               	sub	x4, x3, #0x4
               	add	x1, x1, x4, lsl #2
               	ldr	s2, [x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	add	x1, x1, #0x2
               	add	x1, x4, x1, lsl #2
               	ldr	s1, [x1]
               	b	<addr>
               	sub	x4, x29, #0x20
               	add	x4, x4, x1, lsl #2
               	ldr	s0, [x4]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s64q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x181              // =385
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x3c2              // =962
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x17e              // =382
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x142              // =322
               	stur	x0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x80]
               	zip2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x50]
               	trn1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x40]
               	trn2	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	x3, [x29, #-0x10]
               	cbz	x1, <addr>
               	ldur	x4, [x29, #-0x8]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x20
               	ldr	x5, [x5, x2, lsl #3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	x2, [x29, #-0x18]
               	cbz	x1, <addr>
               	sub	x6, x29, #0x10
               	sub	x7, x0, #0x1
               	ldr	x6, [x6, x7, lsl #3]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x10
               	ldr	x7, [x1, x0, lsl #3]
               	sub	x1, x29, #0x80
               	ldr	x8, [x1, x0, lsl #3]
               	cmp	x8, x3
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x5
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	ldr	x3, [x3, x0, lsl #3]
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x2, x1, #0x40
               	ldr	x2, [x2, x0, lsl #3]
               	cmp	x2, x6
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x7
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x7, x0, #0x1
               	ldr	x7, [x1, x7, lsl #3]
               	b	<addr>
               	sub	x6, x29, #0x20
               	ldr	x6, [x6, x0, lsl #3]
               	b	<addr>
               	sub	x6, x29, #0x10
               	sub	x2, x2, #0x2
               	ldr	x2, [x6, x2, lsl #3]
               	b	<addr>
               	ldur	x5, [x29, #-0x10]
               	b	<addr>
               	ldur	x4, [x29, #-0x18]
               	b	<addr>
               	ldur	x3, [x29, #-0x20]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f64q>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x58]
               	stur	d0, [x29, #-0x20]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x60]
               	stur	d0, [x29, #-0x10]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x68]
               	stur	d0, [x29, #-0x18]
               	adrp	x16, <addr>
               	ldr	d0, [x16, #0x70]
               	stur	d0, [x29, #-0x8]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	zip1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x80]
               	zip2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x70]
               	uzp1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x60]
               	uzp2	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x50]
               	trn1	v2.2d, v0.2d, v1.2d
               	stur	q2, [x29, #-0x40]
               	trn2	v0.2d, v0.2d, v1.2d
               	stur	q0, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	and	x1, x0, #0x1
               	lsl	x2, x0, #1
               	cbz	x1, <addr>
               	ldur	d0, [x29, #-0x10]
               	cbz	x1, <addr>
               	ldur	d1, [x29, #-0x8]
               	cmp	w2, #0x2
               	b.ge	<addr>
               	sub	x3, x29, #0x20
               	add	x3, x3, x2, lsl #3
               	ldr	d2, [x3]
               	add	x2, x2, #0x1
               	cmp	w2, #0x2
               	b.ge	<addr>
               	ldur	d3, [x29, #-0x18]
               	cbz	x1, <addr>
               	sub	x2, x29, #0x10
               	sub	x3, x0, #0x1
               	add	x2, x2, x3, lsl #3
               	ldr	d4, [x2]
               	cbz	x1, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, x0, lsl #3
               	ldr	d5, [x1]
               	sub	x1, x29, #0x80
               	lsl	x2, x0, #3
               	add	x3, x1, x2
               	ldr	d6, [x3]
               	fcmp	d6, d0
               	b.ne	<addr>
               	add	x3, x1, #0x10
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d1
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d2
               	b.ne	<addr>
               	add	x3, x1, #0x30
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d3
               	b.ne	<addr>
               	add	x3, x1, #0x40
               	add	x3, x3, x2
               	ldr	d0, [x3]
               	fcmp	d0, d4
               	b.ne	<addr>
               	add	x1, x1, #0x50
               	add	x1, x1, x2
               	ldr	d0, [x1]
               	fcmp	d0, d5
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x20
               	add	x2, x0, #0x1
               	add	x1, x1, x2, lsl #3
               	ldr	d5, [x1]
               	b	<addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, x0, lsl #3
               	ldr	d4, [x2]
               	b	<addr>
               	sub	x3, x29, #0x10
               	sub	x2, x2, #0x2
               	add	x2, x3, x2, lsl #3
               	ldr	d3, [x2]
               	b	<addr>
               	ldur	d2, [x29, #-0x10]
               	b	<addr>
               	ldur	d1, [x29, #-0x18]
               	b	<addr>
               	ldur	d0, [x29, #-0x20]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_pairs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x10]
               	adrp	x0, <addr>
               	ldr	d1, [x0, #0x18]
               	zip1	v2.4h, v0.4h, v1.4h
               	zip2	v3.4h, v0.4h, v1.4h
               	sub	x1, x29, #0x90
               	stur	d2, [x29, #-0x90]
               	stur	d3, [x29, #-0x88]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v3.4h, v0.4h, v1.4h
               	sub	x2, x29, #0x80
               	stur	d2, [x29, #-0x80]
               	stur	d3, [x29, #-0x78]
               	trn1	v2.4h, v0.4h, v1.4h
               	trn2	v3.4h, v0.4h, v1.4h
               	sub	x3, x29, #0x70
               	stur	d2, [x29, #-0x70]
               	stur	d3, [x29, #-0x68]
               	zip1	v2.4h, v0.4h, v1.4h
               	sub	x5, x29, #0x60
               	stur	d2, [x29, #-0x60]
               	zip2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x58]
               	uzp1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x50]
               	uzp2	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x48]
               	trn1	v2.4h, v0.4h, v1.4h
               	stur	d2, [x29, #-0x40]
               	trn2	v0.4h, v0.4h, v1.4h
               	stur	d0, [x29, #-0x38]
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x30
               	ldr	x16, [x1]
               	str	x16, [x4]
               	add	x1, x1, #0x8
               	add	x6, x4, #0x8
               	ldr	x16, [x1]
               	str	x16, [x6]
               	add	x1, x4, #0x10
               	ldr	x16, [x2]
               	str	x16, [x1]
               	add	x1, x2, #0x8
               	add	x2, x4, #0x18
               	ldr	x16, [x1]
               	str	x16, [x2]
               	add	x1, x4, #0x20
               	ldr	x16, [x3]
               	str	x16, [x1]
               	add	x1, x3, #0x8
               	add	x2, x4, #0x28
               	ldr	x16, [x1]
               	str	x16, [x2]
               	lsl	x2, x0, #3
               	add	x1, x4, x2
               	ldrsh	x6, [x1]
               	add	x3, x5, x2
               	ldrsh	x7, [x3]
               	cmp	w6, w7
               	b.ne	<addr>
               	ldrsh	x6, [x1, #0x2]
               	ldrsh	x7, [x3, #0x2]
               	cmp	w6, w7
               	b.ne	<addr>
               	ldrsh	x6, [x1, #0x4]
               	ldrsh	x3, [x3, #0x4]
               	cmp	w6, w3
               	b.ne	<addr>
               	ldrsh	x1, [x1, #0x6]
               	sub	x3, x29, #0x60
               	add	x2, x3, x2
               	ldrsh	x2, [x2, #0x6]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x6
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_ext>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x7f80             // =32640
               	mov	x1, #0x8081             // =32897
               	sturh	w0, [x29, #-0x20]
               	sturh	w1, [x29, #-0x10]
               	mov	x0, #0x1ff              // =511
               	mov	x1, #0x200              // =512
               	sturh	w0, [x29, #-0x1e]
               	sturh	w1, [x29, #-0xe]
               	mov	x0, #0x5500             // =21760
               	mov	x1, #0x5601             // =22017
               	sturh	w0, [x29, #-0x1c]
               	sturh	w1, [x29, #-0xc]
               	mov	x0, #0x12aa             // =4778
               	mov	x1, #0x13ab             // =5035
               	sturh	w0, [x29, #-0x1a]
               	sturh	w1, [x29, #-0xa]
               	mov	x0, #0xfe34             // =65076
               	mov	x1, #0xff35             // =65333
               	sturh	w0, [x29, #-0x18]
               	sturh	w1, [x29, #-0x8]
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x7f82             // =32642
               	sturh	w0, [x29, #-0x16]
               	sturh	w1, [x29, #-0x6]
               	mov	x0, #0xfd02             // =64770
               	mov	x1, #0xfe03             // =65027
               	sturh	w0, [x29, #-0x14]
               	sturh	w1, [x29, #-0x4]
               	mov	x0, #0xc040             // =49216
               	mov	x1, #0xc141             // =49473
               	sturh	w0, [x29, #-0x12]
               	sturh	w1, [x29, #-0x2]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x10]
               	mov	d2, v0.d[0]
               	mov	d3, v1.d[0]
               	mov	d4, v0.d[0]
               	mov	d5, v1.d[0]
               	ext	v0.16b, v0.16b, v1.16b, #0x5
               	sub	x5, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	ext	v0.8b, v2.8b, v3.8b, #0x3
               	sub	x6, x29, #0x40
               	stur	d0, [x29, #-0x40]
               	ext	v0.8b, v4.8b, v5.8b, #0x6
               	sub	x7, x29, #0x38
               	stur	d0, [x29, #-0x38]
               	sub	x0, x29, #0x30
               	sub	x2, x29, #0x20
               	ldr	x16, [x2]
               	str	x16, [x0]
               	sub	x4, x29, #0x28
               	sub	x3, x29, #0x10
               	ldr	x16, [x3]
               	str	x16, [x4]
               	mov	x0, #0x0                // =0
               	ldrb	w8, [x5, x0]
               	add	x1, x0, #0x5
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x1]
               	cmp	w8, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0xb
               	ldrb	w1, [x3, x1]
               	cmp	w8, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x6, x0]
               	add	x1, x0, #0x3
               	cmp	w1, #0x8
               	b.ge	<addr>
               	ldrb	w1, [x2, x1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0x5
               	ldrb	w1, [x3, x1]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldursh	x2, [x29, #-0x2a]
               	ldrsh	x3, [x7, x0, lsl #1]
               	add	x1, x0, #0x3
               	cmp	w1, #0x4
               	b.ge	<addr>
               	mov	x1, x2
               	cmp	w3, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x0, #0x1
               	ldrsh	x1, [x4, x1, lsl #1]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	ext	v0.16b, v0.16b, v1.16b, #0x8
               	mov	d1, v0.d[0]
               	fmov	d2, #2.50000000
               	fcmp	d1, d2
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	cset	x0, ne
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_dup>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	d1, [x0]
               	ldr	q0, [x0]
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	dup	v2.8b, v1.b[5]
               	sub	x1, x29, #0x20
               	stur	d2, [x29, #-0x20]
               	dup	v2.8b, v0.b[13]
               	sub	x2, x29, #0x18
               	stur	d2, [x29, #-0x18]
               	dup	v1.16b, v1.b[7]
               	sub	x3, x29, #0x60
               	stur	q1, [x29, #-0x60]
               	dup	v1.16b, v0.b[15]
               	sub	x4, x29, #0x50
               	stur	q1, [x29, #-0x50]
               	dup	v1.4h, v0.h[6]
               	sub	x5, x29, #0x8
               	stur	d1, [x29, #-0x8]
               	dup	v0.8h, v0.h[3]
               	sub	x6, x29, #0x40
               	stur	q0, [x29, #-0x40]
               	adrp	x0, <addr>
               	ldr	d0, [x0, #0x40]
               	dup	v0.4s, v0.s[1]
               	sub	x7, x29, #0x30
               	stur	q0, [x29, #-0x30]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	dup	v2.2d, v0.d[1]
               	mov	x0, #0x0                // =0
               	mov	x8, #0x12aa             // =4778
               	mov	x9, #0xfd02             // =64770
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrsb	x10, [x1, x0]
               	cmp	w10, #0x55
               	b.ne	<addr>
               	ldrsb	x10, [x2, x0]
               	cmn	w10, #0x3
               	b.ne	<addr>
               	ldrsb	x10, [x3, x0]
               	cmp	w10, #0x12
               	b.ne	<addr>
               	ldrsb	x10, [x4, x0]
               	cmn	w10, #0x40
               	b.ne	<addr>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	ldrh	w10, [x5, x0, lsl #1]
               	cmp	w10, w9
               	b.ne	<addr>
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrh	w10, [x6, x0, lsl #1]
               	cmp	w10, w8
               	b.ne	<addr>
               	cmp	w0, #0x4
               	b.ge	<addr>
               	add	x10, x7, x0, lsl #2
               	ldr	s0, [x10]
               	fmov	s1, #-2.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, v2.d[0]
               	cmn	x0, #0x9
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	mov	x0, v2.d[1]
               	cmn	x0, #0x9
               	cset	x0, ne
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_tbl>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #0x7f80             // =32640
               	mov	x1, #0x700              // =1792
               	mov	x2, #0xc9c8             // =51656
               	sturh	w0, [x29, #-0x30]
               	sturh	w1, [x29, #-0x20]
               	sturh	w2, [x29, #-0x10]
               	mov	x0, #0x1ff              // =511
               	mov	x1, #0x150e             // =5390
               	mov	x2, #0xcbca             // =52170
               	sturh	w0, [x29, #-0x2e]
               	sturh	w1, [x29, #-0x1e]
               	sturh	w2, [x29, #-0xe]
               	mov	x0, #0x5500             // =21760
               	mov	x1, #0xc05              // =3077
               	mov	x2, #0xcdcc             // =52684
               	sturh	w0, [x29, #-0x2c]
               	sturh	w1, [x29, #-0x1c]
               	sturh	w2, [x29, #-0xc]
               	mov	x0, #0x12aa             // =4778
               	mov	x1, #0x313              // =787
               	mov	x2, #0xcfce             // =53198
               	sturh	w0, [x29, #-0x2a]
               	sturh	w1, [x29, #-0x1a]
               	sturh	w2, [x29, #-0xa]
               	mov	x0, #0xfe34             // =65076
               	mov	x1, #0x110a             // =4362
               	mov	x2, #0xd1d0             // =53712
               	sturh	w0, [x29, #-0x28]
               	sturh	w1, [x29, #-0x18]
               	sturh	w2, [x29, #-0x8]
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x801              // =2049
               	mov	x2, #0xd3d2             // =54226
               	sturh	w0, [x29, #-0x26]
               	sturh	w1, [x29, #-0x16]
               	sturh	w2, [x29, #-0x6]
               	mov	x0, #0xfd02             // =64770
               	mov	x1, #0x160f             // =5647
               	mov	x2, #0xd5d4             // =54740
               	sturh	w0, [x29, #-0x24]
               	sturh	w1, [x29, #-0x14]
               	sturh	w2, [x29, #-0x4]
               	sub	x6, x29, #0x30
               	mov	x0, #0xc040             // =49216
               	sub	x2, x29, #0x20
               	mov	x1, #0xd06              // =3334
               	sub	x3, x29, #0x10
               	mov	x4, #0xd7d6             // =55254
               	sturh	w0, [x29, #-0x22]
               	sturh	w1, [x29, #-0x12]
               	sturh	w4, [x29, #-0x2]
               	ldur	q0, [x29, #-0x30]
               	ldur	q1, [x29, #-0x20]
               	ldur	q3, [x29, #-0x10]
               	mov	d2, v1.d[0]
               	mov	d4, v3.d[0]
               	tbl	v5.16b, { v0.16b }, v1.16b
               	sub	x7, x29, #0x70
               	stur	q5, [x29, #-0x70]
               	mov	v16.16b, v3.16b
               	tbx	v16.16b, { v0.16b }, v1.16b
               	mov	v1.16b, v16.16b
               	sub	x8, x29, #0x60
               	stur	q1, [x29, #-0x60]
               	tbl	v1.8b, { v0.16b }, v2.8b
               	sub	x9, x29, #0x48
               	stur	d1, [x29, #-0x48]
               	mov	v1.16b, v4.16b
               	tbx	v1.8b, { v0.16b }, v2.8b
               	sub	x10, x29, #0x40
               	stur	d1, [x29, #-0x40]
               	tbl	v0.8b, { v0.16b }, v2.8b
               	sub	x11, x29, #0x38
               	stur	d0, [x29, #-0x38]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x6, x1]
               	ldrb	w5, [x7, x0]
               	cmp	w5, w1
               	b.ne	<addr>
               	ldrb	w12, [x8, x0]
               	ldrb	w5, [x2, x0]
               	cmp	w5, #0x10
               	b.ge	<addr>
               	mov	x5, x1
               	cmp	w12, w5
               	b.ne	<addr>
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrb	w5, [x9, x0]
               	cmp	w5, w1
               	b.ne	<addr>
               	ldrb	w12, [x10, x0]
               	ldrb	w5, [x2, x0]
               	cmp	w5, #0x10
               	b.ge	<addr>
               	mov	x5, x1
               	cmp	w12, w5
               	b.ne	<addr>
               	ldrsb	x5, [x11, x0]
               	sxtb	x1, w1
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	ldrb	w5, [x3, x0]
               	b	<addr>
               	ldrb	w5, [x3, x0]
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x42c2             // =17090
               	sturh	w0, [x29, #-0x40]
               	sturh	w1, [x29, #-0x38]
               	mov	x0, #0x4fe              // =1278
               	mov	x1, #0xcf3              // =3315
               	sturh	w0, [x29, #-0x3e]
               	sturh	w1, [x29, #-0x36]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x8778             // =34680
               	mov	x0, #0x0                // =0
               	sturh	w1, [x29, #-0x3c]
               	sturh	w2, [x29, #-0x34]
               	mov	x1, #0x37ff             // =14335
               	mov	x2, #0x6f8              // =1784
               	sturh	w1, [x29, #-0x3a]
               	sturh	w2, [x29, #-0x32]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x30]
               	zip2	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x18]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x10]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x38
               	ldrsb	x4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x38
               	add	x1, x1, #0x4
               	ldrsb	x5, [x5, x1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	ldrsb	x6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	ldrsb	x3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	sub	x7, x0, #0x1
               	ldrsb	x7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	ldrsb	x2, [x1, x0]
               	sub	x1, x29, #0x30
               	ldrsb	x8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrsb	x3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x2, x0, #0x1
               	ldrsb	x2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrsb	x7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x38
               	sub	x1, x1, #0x8
               	ldrsb	x3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x38
               	sub	x6, x3, #0x8
               	ldrsb	x6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x40
               	add	x1, x1, #0x4
               	ldrsb	x5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x40
               	ldrsb	x4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	orr	x9, x20, x0, lsl #1
               	mov	x0, #0x7e81             // =32385
               	mov	x1, #0x42c2             // =17090
               	sturh	w0, [x29, #-0x40]
               	sturh	w1, [x29, #-0x38]
               	mov	x0, #0x4fe              // =1278
               	mov	x1, #0xcf3              // =3315
               	sturh	w0, [x29, #-0x3e]
               	sturh	w1, [x29, #-0x36]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x8778             // =34680
               	mov	x0, #0x0                // =0
               	sturh	w1, [x29, #-0x3c]
               	sturh	w2, [x29, #-0x34]
               	mov	x1, #0x37ff             // =14335
               	mov	x2, #0x6f8              // =1784
               	sturh	w1, [x29, #-0x3a]
               	sturh	w2, [x29, #-0x32]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	zip1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x30]
               	zip2	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x28]
               	uzp1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x20]
               	uzp2	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x18]
               	trn1	v2.8b, v0.8b, v1.8b
               	stur	d2, [x29, #-0x10]
               	trn2	v0.8b, v0.8b, v1.8b
               	stur	d0, [x29, #-0x8]
               	lsr	x1, x0, #1
               	and	x2, x0, #0x1
               	lsl	x3, x0, #1
               	cbz	x2, <addr>
               	sub	x4, x29, #0x38
               	ldrb	w4, [x4, x1]
               	cbz	x2, <addr>
               	sub	x5, x29, #0x38
               	add	x1, x1, #0x4
               	ldrb	w5, [x5, x1]
               	cmp	w3, #0x8
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	ldrb	w6, [x1, x3]
               	add	x1, x3, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x40
               	ldrb	w3, [x3, x1]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	sub	x7, x0, #0x1
               	ldrb	w7, [x1, x7]
               	cbz	x2, <addr>
               	sub	x1, x29, #0x38
               	ldrb	w2, [x1, x0]
               	sub	x1, x29, #0x30
               	ldrb	w8, [x1, x0]
               	cmp	w8, w4
               	b.ne	<addr>
               	add	x4, x1, #0x8
               	ldrb	w4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x1, #0x10
               	ldrb	w4, [x4, x0]
               	cmp	w4, w6
               	b.ne	<addr>
               	add	x4, x1, #0x18
               	ldrb	w4, [x4, x0]
               	cmp	w4, w3
               	b.ne	<addr>
               	add	x3, x1, #0x20
               	ldrb	w3, [x3, x0]
               	cmp	w3, w7
               	b.ne	<addr>
               	add	x1, x1, #0x28
               	ldrb	w1, [x1, x0]
               	cmp	w1, w2
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	add	x2, x0, #0x1
               	ldrb	w2, [x1, x2]
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrb	w7, [x1, x0]
               	b	<addr>
               	sub	x3, x29, #0x38
               	sub	x1, x1, #0x8
               	ldrb	w3, [x3, x1]
               	b	<addr>
               	sub	x1, x29, #0x38
               	sub	x6, x3, #0x8
               	ldrb	w6, [x1, x6]
               	b	<addr>
               	sub	x5, x29, #0x40
               	add	x1, x1, #0x4
               	ldrb	w5, [x5, x1]
               	b	<addr>
               	sub	x4, x29, #0x40
               	ldrb	w4, [x4, x1]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	orr	x20, x9, x0, lsl #2
               	bl	<addr>
               	orr	x20, x20, x0, lsl #3
               	bl	<addr>
               	orr	x20, x20, x0, lsl #4
               	bl	<addr>
               	orr	x20, x20, x0, lsl #5
               	bl	<addr>
               	orr	x20, x20, x0, lsl #6
               	bl	<addr>
               	orr	x20, x20, x0, lsl #7
               	bl	<addr>
               	orr	x20, x20, x0, lsl #8
               	bl	<addr>
               	orr	x20, x20, x0, lsl #9
               	bl	<addr>
               	orr	x20, x20, x0, lsl #10
               	bl	<addr>
               	orr	x20, x20, x0, lsl #11
               	bl	<addr>
               	orr	x20, x20, x0, lsl #12
               	bl	<addr>
               	orr	x20, x20, x0, lsl #13
               	bl	<addr>
               	orr	x20, x20, x0, lsl #14
               	bl	<addr>
               	orr	x20, x20, x0, lsl #15
               	bl	<addr>
               	orr	x20, x20, x0, lsl #16
               	bl	<addr>
               	orr	x0, x20, x0, lsl #17
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
