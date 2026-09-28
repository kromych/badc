
variadic_hidden_result_pointer.x64:	file format elf64-x86-64

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

<vpair>:
               	movq	%rsi, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movq	%xmm0, 0x10(%rdi)
               	movslq	%ecx, %rcx
               	addq	%r8, %rcx
               	movzbl	%al, %eax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rax, %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	%rdi, %rax
               	retq

<vquad>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xc0(%rbp)
               	movups	%xmm1, -0xb0(%rbp)
               	movups	%xmm2, -0xa0(%rbp)
               	movups	%xmm3, -0x90(%rbp)
               	movups	%xmm4, -0x80(%rbp)
               	movups	%xmm5, -0x70(%rbp)
               	movups	%xmm6, -0x60(%rbp)
               	movups	%xmm7, -0x50(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x38(%rbp), %rax
               	leaq	-0xe8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x30(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %r11
               	movq	0x8(%r11), %r10
               	addq	$0x20, 0x8(%r11)
               	movq	%r10, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	imulq	$0xa, %r8, %r8
               	addq	%r8, %rcx
               	movq	0x8(%rax), %r8
               	imulq	$0xa, %r8, %r8
               	addq	%r8, %rdx
               	movq	0x10(%rax), %r8
               	imulq	$0xa, %r8, %r8
               	addq	%r8, %rsi
               	movq	0x18(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	%rdi, %rax
               	movslq	-0xe8(%rbp), %rdi
               	addq	%rax, %rdi
               	movq	-0xf0(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	leaq	-0xa0(%rbp), %rdi
               	movl	$0x3, %ecx
               	movl	$0x28, %r8d
               	movq	%rax, %xmm0
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	leaq	-0xa0(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x16, %rcx
               	jne	<addr>
               	movsd	-0xa8(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x413, %rax            # imm = 0x413
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rsi
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movl	$0x5, %ecx
               	movl	$0x32, %r8d
               	leaq	-0x40(%rbp), %rdi
               	movq	%rax, %xmm0
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0xa8(%rbp), %rdi
               	leaq	-0xa0(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x16, %rcx
               	jne	<addr>
               	movsd	-0xa8(%rbp), %xmm0
               	movabsq	$0x4012000000000000, %rcx # imm = 0x4012000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x41f, %rax            # imm = 0x41F
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movl	$0x9, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0xf, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x1a, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpq	$0x25, %rcx
               	jne	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x39, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
