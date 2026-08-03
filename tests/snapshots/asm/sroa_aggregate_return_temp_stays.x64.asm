
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
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movl	(%rax), %eax
               	shlq	$0x2, %rax
               	movl	%eax, %ecx
               	leaq	-0x38(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shrq	$0x1e, %rax
               	orq	%rax, %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shlq	$0x2, %rax
               	movl	%eax, %eax
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, (%rcx)
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x38(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movl	%edx, %ecx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %esi
               	leaq	-0x40(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, %esi
               	leaq	-0x18(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%esi, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	movl	%eax, %eax
               	cmpq	%rax, %rcx
               	jae	<addr>
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x50, %rsp
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
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rax
               	movl	(%rax), %eax
               	shlq	$0x3, %rax
               	movl	%eax, %ecx
               	leaq	-0x38(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shrq	$0x1d, %rax
               	orq	%rax, %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shlq	$0x3, %rax
               	movl	%eax, %eax
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%eax, %eax
               	movl	%edx, (%rcx)
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x38(%rbp), %rdi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	movl	%edx, %ecx
               	leaq	-0x40(%rbp), %rdx
               	movl	(%rdx), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %esi
               	leaq	-0x40(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, %esi
               	leaq	-0x18(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movl	%esi, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x48(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	movl	%eax, %eax
               	cmpq	%rax, %rcx
               	jae	<addr>
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x50, %rsp
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
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	shlq	$0x7, %rax
               	movl	%eax, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shrq	$0x19, %rax
               	orq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	movq	%rax, %rdx
               	shrq	$0x19, %rdx
               	leaq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rdx, %rax
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x8(%rbx), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	shlq	$0x11, %rax
               	movl	%eax, %ecx
               	leaq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shrq	$0xf, %rax
               	orq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	shlq	$0x11, %rax
               	movl	%eax, %eax
               	movl	%ecx, %ecx
               	movl	%eax, %edx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x38(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	0x10(%rbx), %rax
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rax
               	movq	(%rbx), %rax
               	movq	%rax, (%rsi)
               	popq	%rax
               	movl	(%rax), %esi
               	leaq	-0x30(%rbp), %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %edi
               	leaq	-0x30(%rbp), %rsi
               	movl	0x4(%rsi), %esi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	leaq	0x8(%rbx), %rsi
               	leaq	-0x30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movl	(%rax), %esi
               	leaq	-0x30(%rbp), %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %edi
               	leaq	-0x30(%rbp), %rsi
               	movl	0x4(%rsi), %esi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	leaq	0x10(%rbx), %rsi
               	leaq	-0x30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movl	(%rax), %esi
               	leaq	-0x30(%rbp), %rdi
               	movl	(%rdi), %edi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %edi
               	leaq	-0x30(%rbp), %rsi
               	movl	0x4(%rsi), %esi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	leaq	-0x30(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movl	(%rbx), %eax
               	leaq	-0x30(%rbp), %rsi
               	movl	(%rsi), %esi
               	xorq	%rsi, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %esi
               	leaq	-0x30(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	%rsi, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
               	popq	%rax
               	movq	%rdi, %rsi
               	movl	(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x13, %rdx
               	leaq	-0x30(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	orq	%rcx, %rdx
               	leaq	-0x30(%rbp), %rcx
               	movl	(%rcx), %ecx
               	shlq	$0xd, %rcx
               	movl	%ecx, %esi
               	leaq	-0x30(%rbp), %rcx
               	movl	0x4(%rcx), %ecx
               	shrq	$0x13, %rcx
               	orq	%rsi, %rcx
               	movl	%edx, %edx
               	movl	%ecx, %esi
               	leaq	-0x28(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x28(%rbp), %rcx
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
