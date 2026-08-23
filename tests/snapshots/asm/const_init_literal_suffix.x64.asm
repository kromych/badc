
const_init_literal_suffix.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addss	%xmm15, %xmm0
               	movabsq	$0x3fb999999999999a, %rcx # imm = 0x3FB999999999999A
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm1
               	addsd	%xmm15, %xmm1
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x218711a00, %r11      # imm = 0x218711A00
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	movabsq	$0x200000000, %r11      # imm = 0x200000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm2
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rcx
               	movsd	(%rcx,%riz), %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	jmp	<addr>
