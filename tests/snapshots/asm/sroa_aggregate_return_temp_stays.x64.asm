
sroa_aggregate_return_temp_stays.x64:	file format elf64-x86-64

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

<shl>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movslq	%esi, %rsi
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %r11
               	movq	%rsi, %rcx
               	shlq	%cl, %r11
               	movq	%r11, %rcx
               	movl	%ecx, %edi
               	movl	0x4(%rax), %ecx
               	movl	$0x20, %edx
               	subq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	orq	%rdi, %rdx
               	movq	%rcx, %rax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	movl	%eax, %ecx
               	leaq	-0x8(%rbp), %rax
               	movl	%edx, %edx
               	movl	%edx, (%rax)
               	movl	%ecx, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<xorinto>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, -0x8(%rbp)
               	movl	(%rdi), %ecx
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, (%rdi)
               	movl	0x4(%rdi), %ecx
               	movl	0x4(%rax), %eax
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rdi)
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<add>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	(%rcx), %edx
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %esi
               	addq	%rsi, %rdx
               	movl	%edx, %esi
               	movl	0x4(%rcx), %edx
               	movl	0x4(%rax), %eax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movl	%esi, %esi
               	movl	%esi, (%rdx)
               	movl	%eax, %eax
               	movl	%eax, 0x4(%rdx)
               	leaq	-0x8(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movl	0x4(%rax), %edx
               	movl	0x4(%rcx), %ecx
               	cmpl	%ecx, %edx
               	jae	<addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<times5>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x2, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0x1e, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x2, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %eax
               	movl	%edx, %edx
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%esi, %esi
               	movl	%eax, %edi
               	movl	%esi, %eax
               	movl	%edi, %esi
               	movl	%esi, %edi
               	cmpl	%edx, %edi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%esi, %edx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<times9>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x3, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0x1d, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, %ecx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %eax
               	movl	%edx, %edx
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movl	%eax, %eax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%esi, %esi
               	movl	%eax, %edi
               	movl	%esi, %eax
               	movl	%edi, %esi
               	movl	%esi, %edi
               	cmpl	%edx, %edi
               	jae	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, %eax
               	movl	%esi, %edx
               	movl	%eax, (%rcx)
               	movl	%edx, 0x4(%rcx)
               	movq	(%rcx), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<rot>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	shlq	$0x7, %rdx
               	movl	%edx, %edx
               	movl	0x4(%rax), %esi
               	shrq	$0x19, %rsi
               	orq	%rsi, %rdx
               	shrq	$0x19, %rcx
               	movl	0x4(%rax), %eax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rax, %rcx
               	leaq	-0x8(%rbp), %rax
               	movl	%edx, %edx
               	movl	%edx, (%rax)
               	movl	%ecx, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<rot_hi>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %ecx
               	movq	%rcx, %rdx
               	shrq	$0x13, %rdx
               	movl	0x4(%rax), %esi
               	shlq	$0xd, %rsi
               	movl	%esi, %esi
               	orq	%rsi, %rdx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movl	0x4(%rax), %eax
               	shrq	$0x13, %rax
               	orq	%rax, %rcx
               	leaq	-0x8(%rbp), %rax
               	movl	%edx, %edx
               	movl	%edx, (%rax)
               	movl	%ecx, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x38(%rbp), %rax
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0x3ef, %edx            # imm = 0x3EF
               	movl	%edx, 0x4(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rdx
               	leaq	0x8(%rcx), %rdx
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x38(%rbp), %rax
               	movl	$0xff, %esi
               	movl	%esi, 0x4(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	leaq	-0x30(%rbp), %rdx
               	leaq	0x10(%rdx), %rsi
               	movl	%ecx, (%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	addq	$0x18, %rdx
               	movl	%ecx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x38(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rax
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x2, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rax
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x2, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rax
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x2, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rax
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x2, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rax
               	leaq	-0x60(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x2, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	-0x50(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x40(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	movq	(%rdi), %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	movq	%rax, -0x38(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	-0x78(%rbp), %rax
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	%edx, (%rax)
               	movl	%ecx, 0x4(%rax)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %edx
               	movl	0x4(%rax), %ecx
               	movl	%edx, %edx
               	shlq	$0x11, %rdx
               	movl	%edx, %esi
               	movl	%ecx, %edx
               	movq	%rdx, %rdi
               	shrq	$0xf, %rdi
               	orq	%rdi, %rsi
               	movq	%rdx, %rcx
               	shlq	$0x11, %rcx
               	movl	%ecx, %ecx
               	movl	%esi, %edx
               	movl	%ecx, %esi
               	leaq	-0x70(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	leaq	-0x90(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x10(%rbx), %rcx
               	movl	(%rbx), %edx
               	movl	0x4(%rbx), %esi
               	movl	(%rcx), %edi
               	movl	%edx, %edx
               	xorq	%rdi, %rdx
               	movl	%edx, (%rcx)
               	movl	0x4(%rcx), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, 0x4(%rcx)
               	leaq	0x18(%rbx), %rdx
               	movl	(%rax), %esi
               	movl	0x4(%rax), %edi
               	movl	(%rdx), %r12d
               	movl	%esi, %esi
               	xorq	%r12, %rsi
               	movl	%esi, (%rdx)
               	movl	0x4(%rdx), %esi
               	movl	%edi, %edi
               	xorq	%rdi, %rsi
               	movl	%esi, 0x4(%rdx)
               	movl	(%rcx), %esi
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %edi
               	movl	%esi, %esi
               	xorq	%rdi, %rsi
               	movl	%esi, (%rax)
               	movl	0x4(%rax), %esi
               	movl	%ecx, %ecx
               	xorq	%rsi, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	(%rdx), %eax
               	movl	0x4(%rdx), %ecx
               	movl	(%rbx), %edx
               	movl	%eax, %eax
               	xorq	%rdx, %rax
               	movl	%eax, (%rbx)
               	movl	0x4(%rbx), %eax
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, 0x4(%rbx)
               	leaq	0x10(%rbx), %rax
               	leaq	-0x90(%rbp), %rcx
               	movl	(%rcx), %edx
               	movl	0x4(%rcx), %ecx
               	movl	(%rax), %esi
               	movl	%edx, %edx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movl	0x4(%rax), %edx
               	movl	%ecx, %ecx
               	xorq	%rdx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x18(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	movl	%ecx, %esi
               	movq	%rsi, %rbx
               	shrq	$0x13, %rbx
               	movl	%edx, %edi
               	movq	%rdi, %r12
               	shlq	$0xd, %r12
               	movl	%r12d, %r12d
               	orq	%r12, %rbx
               	movq	%rsi, %rcx
               	shlq	$0xd, %rcx
               	movl	%ecx, %ecx
               	movq	%rdi, %rdx
               	shrq	$0x13, %rdx
               	orq	%rdx, %rcx
               	movl	%ebx, %edx
               	movl	%ecx, %esi
               	leaq	-0x68(%rbp), %rcx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edx, (%rcx)
               	movl	%esi, 0x4(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %edx
               	movq	%rdx, %rsi
               	shlq	$0x7, %rsi
               	movl	%esi, %edi
               	movl	%eax, %esi
               	movq	%rsi, %r8
               	shrq	$0x19, %r8
               	orq	%r8, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x19, %rcx
               	movq	%rsi, %rax
               	shlq	$0x7, %rax
               	movl	%eax, %eax
               	orq	%rcx, %rax
               	movl	%edi, %ecx
               	movl	%eax, %edx
               	leaq	-0x80(%rbp), %rdi
               	movl	%ecx, %eax
               	movl	%edx, %ecx
               	movl	%eax, (%rdi)
               	movl	%ecx, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %eax
               	movl	%ecx, %ecx
               	shlq	$0x11, %rcx
               	movl	%ecx, %edx
               	movl	%eax, %ecx
               	movq	%rcx, %rsi
               	shrq	$0xf, %rsi
               	orq	%rsi, %rdx
               	movq	%rcx, %rax
               	shlq	$0x11, %rax
               	movl	%eax, %eax
               	movl	%edx, %ecx
               	movl	%eax, %edx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%ecx, (%rax)
               	movl	%edx, 0x4(%rax)
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x10(%rbx), %rdi
               	movq	%rbx, %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rdi
               	leaq	0x8(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x8(%rbx), %rdi
               	leaq	0x10(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rsi
               	movq	%rbx, %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x18, %rbx
               	movl	$0x2d, %esi
               	movq	%rbx, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	movl	$0x7, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rdi
               	movl	$0x11, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x10(%rbx), %rdi
               	movq	%rbx, %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rdi
               	leaq	0x8(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x8(%rbx), %rdi
               	leaq	0x10(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rsi
               	movq	%rbx, %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x18, %rbx
               	movl	$0x2d, %esi
               	movq	%rbx, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	movl	$0x7, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rdi
               	movl	$0x11, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x10(%rbx), %rdi
               	movq	%rbx, %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rdi
               	leaq	0x8(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x8(%rbx), %rdi
               	leaq	0x10(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rsi
               	movq	%rbx, %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x18, %rbx
               	movl	$0x2d, %esi
               	movq	%rbx, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	movl	$0x7, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	0x8(%rbx), %rdi
               	movl	$0x11, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x10(%rbx), %rdi
               	movq	%rbx, %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rdi
               	leaq	0x8(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x8(%rbx), %rdi
               	leaq	0x10(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rsi
               	movq	%rbx, %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x18, %rbx
               	movl	$0x2d, %esi
               	movq	%rbx, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x30(%rbp), %rbx
               	leaq	0x8(%rbx), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x88(%rbp)
               	leaq	-0x88(%rbp), %rdi
               	movl	$0x7, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x78(%rbp)
               	leaq	-0x78(%rbp), %rax
               	movl	(%rax), %r12d
               	movl	0x4(%rax), %r13d
               	leaq	0x8(%rbx), %rdi
               	movl	$0x11, %esi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x70(%rbp)
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x10(%rbx), %rdi
               	movq	%rbx, %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rdi
               	leaq	0x8(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x8(%rbx), %rdi
               	leaq	0x10(%rbx), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x18(%rbx), %rsi
               	movq	%rbx, %rdi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x10(%rbx), %rdi
               	leaq	-0x90(%rbp), %rsi
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x18, %rbx
               	movl	$0x2d, %esi
               	movq	%rbx, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	movl	%r12d, %eax
               	movl	%r13d, %ecx
               	movl	%eax, %eax
               	shlq	$0x1f, %rax
               	shlq	%rax
               	movl	%ecx, %ecx
               	orq	%rcx, %rax
               	movabsq	$0x7a7040a5a323c9d6, %r11 # imm = 0x7A7040A5A323C9D6
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %ecx
               	shlq	$0x1f, %rcx
               	shlq	%rcx
               	movl	0x4(%rax), %edx
               	orq	%rdx, %rcx
               	movabsq	$0xba18b516cb227f9, %r11 # imm = 0xBA18B516CB227F9
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
