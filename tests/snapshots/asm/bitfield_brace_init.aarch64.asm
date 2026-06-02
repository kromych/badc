
bitfield_brace_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x14, <page>
               	add	x14, x14, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x8
               	ldrb	w15, [x15]
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrb	w15, [x15]
               	asr	x15, x15, #2
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrb	w15, [x15]
               	asr	x15, x15, #4
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrb	w15, [x15]
               	asr	x15, x15, #6
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0xd1
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x15]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x15, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	cmp	x15, #0xab
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #8
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x10
               	ldr	w15, [x15]
               	asr	x15, x15, #9
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7f, lsl #16
               	and	x15, x15, x17
               	mov	x17, #0x2345            // =9029
               	movk	x17, #0x1, lsl #16
               	cmp	x15, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, #0xd5
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x18
               	ldrb	w15, [x15]
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldrb	w15, [x15]
               	asr	x15, x15, #3
               	mov	x17, #0x7               // =7
               	and	x15, x15, x17
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	ldrb	w15, [x15]
               	asr	x15, x15, #6
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, #0xd6
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x20
               	ldrb	w15, [x15]
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	ldrb	w15, [x15]
               	asr	x15, x15, #2
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	ldrb	w15, [x15]
               	asr	x15, x15, #4
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x20
               	ldrb	w15, [x15]
               	asr	x15, x15, #6
               	mov	x17, #0x3               // =3
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
