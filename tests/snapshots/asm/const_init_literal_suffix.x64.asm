
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addss	%xmm15, %xmm0
               	movabsq	$0x3fb999999999999a, %rax # imm = 0x3FB999999999999A
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm1
               	addsd	%xmm15, %xmm1
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x218711a00, %r11      # imm = 0x218711A00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	0x8(%rax), %rax
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	movabsq	$0x200000000, %r11      # imm = 0x200000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm2
               	cvtss2sd	%xmm0, %xmm0
               	ucomisd	%xmm0, %xmm2
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0xe77934880, %r11      # imm = 0xE77934880
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	testl	%eax, %eax
               	je	<addr>
               	retq
               	movq	%rcx, %rax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movabsq	$0x10000000000, %r11    # imm = 0x10000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
