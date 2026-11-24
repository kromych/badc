
compound_literal_addr_call_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<take16>:
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rsi), %rax
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	0x8(%rsi), %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	%rsi, (%rdx)
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x98, %rsp
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x18(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x8(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	leaq	0x10(%rsp), %rdx
               	movq	%rdx, <rip> # <addr>
               	leaq	0x28(%rsp), %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rcx)
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, 0x10(%rsp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x8(%rsp), %rdx
               	leaq	0x30(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rsi
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, 0x10(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x40(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movabsq	$0x4444444444444444, %r11 # imm = 0x4444444444444444
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, 0x10(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x8(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x10(%rsp), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x98, %rsp
               	retq
               	cmpq	$0x0, 0x10(%rsp)
               	jne	<addr>
               	movl	$0x11, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x8(%rsp), %rdx
               	leaq	0x68(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rsi
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, 0x10(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x13, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x78(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rsi
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rax, 0x10(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x15, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x80(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x10(%rsp), %rdx
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x98, %rsp
               	retq
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rcx, 0x10(%rsp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x17, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x8(%rsp), %rcx
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	%rcx, 0x10(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	leaq	0x18(%rsp), %rax
               	leaq	0x10(%rsp), %rdx
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	0x18(%rsp), %rcx
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	0x20(%rsp), %rcx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	%rax, 0x10(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, 0x10(%rsp)
               	leaq	0x8(%rsp), %rsi
               	leaq	<rip>, %rcx # <addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%rcx, 0x10(%rsp)
               	addq	$0x98, %rsp
               	retq
