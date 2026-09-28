
inline_asm_a64_sve_counts.aarch64:	file format elf64-littleaarch64

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

<sve_get_vl>:
               	rdvl	x0, #0x1
               	ret

<sve_words>:
               	rdvl	x0, #0x1
               	addvl	sp, sp, #-0x2
               	addpl	x0, x1, #-0x20
               	cntb	x0
               	cnth	x1, vl256, mul #0x4
               	cntd	x3, mul4, mul #0x2
               	incb	x0, all, mul #0x10
               	decw	x6, vl64
               	sqincb	x0, w0, all, mul #0x3
               	sqdecd	x7, vl5
               	uqincw	w2, vl3
               	uqdech	x5
               	cntb	x0, #0xe
               	cntb	x0, all, mul #0x2
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldr	w2, [x1]
               	mov	x17, #0x5020            // =20512
               	movk	x17, #0x4bf, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	add	x0, x0, #0x1
               	ret
               	mov	x2, #0x1                // =1
               	ldr	w3, [x1, #0x4]
               	mov	x17, #0x57df            // =22495
               	movk	x17, #0x43f, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x2                // =2
               	ldr	w3, [x1, #0x8]
               	mov	x17, #0x5400            // =21504
               	movk	x17, #0x461, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x3                // =3
               	ldr	w3, [x1, #0xc]
               	mov	x17, #0xe3e0            // =58336
               	movk	x17, #0x420, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x4                // =4
               	ldr	w3, [x1, #0x10]
               	mov	x17, #0xe1a1            // =57761
               	movk	x17, #0x463, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x5                // =5
               	ldr	w3, [x1, #0x14]
               	mov	x17, #0xe3a3            // =58275
               	movk	x17, #0x4e1, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x6                // =6
               	ldr	w3, [x1, #0x18]
               	mov	x17, #0xe3e0            // =58336
               	movk	x17, #0x43f, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x7                // =7
               	ldr	w3, [x1, #0x1c]
               	mov	x17, #0xe566            // =58726
               	movk	x17, #0x4b0, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x8                // =8
               	ldr	w3, [x1, #0x20]
               	mov	x17, #0xf3e0            // =62432
               	movk	x17, #0x422, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0x9                // =9
               	ldr	w3, [x1, #0x24]
               	mov	x17, #0xf8a7            // =63655
               	movk	x17, #0x4f0, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xa                // =10
               	ldr	w3, [x1, #0x28]
               	mov	x17, #0xf462            // =62562
               	movk	x17, #0x4a0, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xb                // =11
               	ldr	w3, [x1, #0x2c]
               	mov	x17, #0xffe5            // =65509
               	movk	x17, #0x470, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xc                // =12
               	ldr	w3, [x1, #0x30]
               	mov	x17, #0xe1c0            // =57792
               	movk	x17, #0x420, lsl #16
               	cmp	w3, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x2, #0xd                // =13
               	ldr	w1, [x1, #0x34]
               	mov	x17, #0xe3e0            // =58336
               	movk	x17, #0x421, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, x2
               	b	<addr>
               	ret
