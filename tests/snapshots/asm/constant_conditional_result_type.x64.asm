
constant_conditional_result_type.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	movabsq	$0x4170000000000000, %rax # imm = 0x4170000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movsd	(%rcx), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movsd	(%rcx), %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	movabsq	$0x3fd3333340000000, %rax # imm = 0x3FD3333340000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movsd	(%rax), %xmm0
               	movl	$0x3dcccccd, %eax       # imm = 0x3DCCCCCD
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
