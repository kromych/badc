
sroa_aggregate_return_temp_stays.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<times5>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x2, %rcx
               	movl	%ecx, %edx
               	movl	0x4(%rax), %ecx
               	movq	%rcx, %rsi
               	shrq	$0x1e, %rsi
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	shlq	$0x2, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %esi
               	movl	%eax, %ecx
               	leaq	-0x40(%rbp), %rax
               	movl	%esi, %esi
               	movl	(%rax), %edi
               	addq	%rdi, %rsi
               	movl	%esi, %esi
               	movl	%ecx, %edi
               	movl	0x4(%rax), %eax
               	addq	%rdi, %rax
               	movl	%eax, %edi
               	leaq	-0x18(%rbp), %rax
               	movl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, %esi
               	movl	%esi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x28(%rbp), %rax
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<times9>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rdi, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x3, %rcx
               	movl	%ecx, %edx
               	movl	0x4(%rax), %ecx
               	movq	%rcx, %rsi
               	shrq	$0x1d, %rsi
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %esi
               	movl	%eax, %ecx
               	leaq	-0x40(%rbp), %rax
               	movl	%esi, %esi
               	movl	(%rax), %edi
               	addq	%rdi, %rsi
               	movl	%esi, %esi
               	movl	%ecx, %edi
               	movl	0x4(%rax), %eax
               	addq	%rdi, %rax
               	movl	%eax, %edi
               	leaq	-0x18(%rbp), %rax
               	movl	%esi, %esi
               	movl	%esi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, %esi
               	movl	%esi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x28(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x28(%rbp), %rax
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	shlq	$0x7, %rdx
               	movl	%edx, %esi
               	movl	0x4(%rax), %edx
               	movq	%rdx, %rdi
               	shrq	$0x19, %rdi
               	orq	%rdi, %rsi
               	shrq	$0x19, %rcx
               	movq	%rdx, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%esi, %ecx
               	movl	%eax, %edx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %ecx
               	shlq	$0x11, %rcx
               	movl	%ecx, %edx
               	movl	0x4(%rax), %ecx
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	shlq	$0x11, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	movl	%eax, %eax
               	movl	%ecx, %edx
               	movl	%eax, %esi
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	(%rbx), %edi
               	xorq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	movl	0x4(%rbx), %edi
               	xorq	%rdi, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	leaq	0x8(%rbx), %rcx
               	movl	(%rax), %edi
               	movl	(%rcx), %r8d
               	xorq	%r8, %rdi
               	movl	%edi, (%rax)
               	movl	0x4(%rax), %edi
               	movl	0x4(%rcx), %ecx
               	xorq	%rdi, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	leaq	0x10(%rbx), %rcx
               	movl	(%rax), %edi
               	movl	(%rcx), %r8d
               	xorq	%r8, %rdi
               	movl	%edi, (%rax)
               	movl	0x4(%rax), %edi
               	movl	0x4(%rcx), %ecx
               	xorq	%rdi, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rbx), %ecx
               	movl	(%rax), %edi
               	xorq	%rdi, %rcx
               	movl	%ecx, (%rbx)
               	movl	0x4(%rbx), %ecx
               	movl	0x4(%rax), %eax
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	movl	(%rax), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%esi, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rsi
               	shrq	$0x13, %rsi
               	movl	0x4(%rax), %edx
               	movq	%rdx, %rdi
               	shlq	$0xd, %rdi
               	movl	%edi, %edi
               	orq	%rdi, %rsi
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x30(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	(%rcx), %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x58(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%edx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x58(%rbp), %rax
               	leaq	0x8(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xff, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x58(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x58(%rbp), %rax
               	leaq	0x18(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x28(%rbp), %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	addq	$0x18, %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %eax
               	orq	%rcx, %rax
               	movabsq	$0x194f95cf3210cb5a, %r11 # imm = 0x194F95CF3210CB5A
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
