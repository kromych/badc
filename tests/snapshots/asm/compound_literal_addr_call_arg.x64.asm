
compound_literal_addr_call_arg.x64:	file format elf64-x86-64

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

<take16>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rdx
               	leaq	-0x88(%rbp), %rsi
               	movq	%rsi, (%rdx)
               	leaq	<rip>, %rdi
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, (%rdi)
               	leaq	-0x68(%rbp), %rcx
               	leaq	<rip>, %r8
               	movq	(%r8), %r10
               	movq	%r10, (%rcx)
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	(%rdi), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x60(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %rdi
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rdx), %r10
               	movq	%r10, 0x10(%rcx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movabsq	$0x4444444444444444, %r11 # imm = 0x4444444444444444
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x80(%rbp), %rdx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rsi
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	cmpq	%r8, %rsi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rax
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rcx, %r8
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movq	(%rdi), %rdx
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movabsq	$0x1111111111111111, %r11 # imm = 0x1111111111111111
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movq	%rcx, (%rax)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movsd	(%rax), %xmm0
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, (%rcx)
               	cmpq	$0x0, -0x80(%rbp)
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdx
               	leaq	<rip>, %r8
               	movq	(%r8), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movq	(%rdi), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	%rdx, (%rcx)
               	movq	-0x80(%rbp), %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movq	$0x0, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	movq	(%r8), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rdx
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	(%rax), %rdx
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%rax, (%rcx)
               	movq	-0x80(%rbp), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, -0x80(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	leaq	<rip>, %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	cmpq	%r8, %rdi
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	movq	%rax, %rsi
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	(%rax), %rsi
               	movabsq	$0x2222222222222222, %r11 # imm = 0x2222222222222222
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	0x8(%rax), %rsi
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movq	%rax, (%rcx)
               	movq	-0x80(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movq	%rdx, %rax
               	leave
               	retq
