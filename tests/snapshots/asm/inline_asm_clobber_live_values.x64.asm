
inline_asm_clobber_live_values.x64:	file format elf64-x86-64

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

<spread>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	0x1(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0x2(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0x3(%rdi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0x4(%rdi), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x5(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x6(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0x7(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0x8(%rdi), %r10
               	movq	%r10, 0x30(%rsp)
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	%rbx, -0x70(%rbp)
               	movq	%r12, -0x68(%rbp)
               	movq	%r13, -0x60(%rbp)
               	movq	%r14, -0x58(%rbp)
               	movq	%r15, -0x50(%rbp)
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	-0x70(%rbp), %rbx
               	movq	-0x68(%rbp), %r12
               	movq	-0x60(%rbp), %r13
               	movq	-0x58(%rbp), %r14
               	movq	-0x50(%rbp), %r15
               	movq	0x60(%rsp), %rax
               	shlq	%rax
               	movq	%rax, %r10
               	movq	0x68(%rsp), %rax
               	addq	%r10, %rax
               	movq	0x58(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	shlq	$0x6, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	shlq	$0x7, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<branchy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	%rbx, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	movq	%r13, -0x30(%rbp)
               	movq	%r14, -0x28(%rbp)
               	movq	%r15, -0x20(%rbp)
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	-0x40(%rbp), %rbx
               	movq	-0x38(%rbp), %r12
               	movq	-0x30(%rbp), %r13
               	movq	-0x28(%rbp), %r14
               	movq	-0x20(%rbp), %r15
               	movq	0x38(%rsp), %rax
               	leave
               	retq

<carried>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %r13
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	addq	%rax, %r12
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	incq	%rbx
               	cmpq	%r13, %rbx
               	jl	<addr>
               	movq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<jumped>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r12, (%rsp)
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rdi,4), %rax
               	leaq	0x3(%rax), %r12
               	movq	%rbx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	-0x10(%rbp), %rbx
               	jmp	<addr>
               	movq	-0x10(%rbp), %rbx
               	jmp	<addr>
               	movq	%r12, %rax
               	movq	(%rsp), %r12
               	leave
               	retq
               	leaq	0x1(%r12), %rax
               	movq	(%rsp), %r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	%r13, -0x20(%rbp)
               	movq	%r14, -0x18(%rbp)
               	movq	%r15, -0x10(%rbp)
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	-0x20(%rbp), %r13
               	movq	-0x18(%rbp), %r14
               	movq	-0x10(%rbp), %r15
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	movq	%r13, -0x20(%rbp)
               	movq	%r14, -0x18(%rbp)
               	movq	%r15, -0x10(%rbp)
               	xorl	%ebx, %ebx
               	xorq	%r12, %r12
               	xorq	%r13, %r13
               	xorq	%r14, %r14
               	xorq	%r15, %r15
               	movq	-0x20(%rbp), %r13
               	movq	-0x18(%rbp), %r14
               	movq	-0x10(%rbp), %r15
               	xorq	%rbx, %rbx
               	movq	%rbx, %rax
               	movq	%rbx, %r12
               	jmp	<addr>
               	movq	%rbx, %rax
               	imulq	%rbx, %rax
               	addq	%rax, %r12
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	incq	%rbx
               	cmpq	$0xa, %rbx
               	jl	<addr>
               	cmpq	$0x11d, %r12            # imm = 0x11D
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	$0x17, %r12d
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	cmpq	$0x17, %r12
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x17, %r12d
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rbx
               	testl	%ebx, %ebx
               	je	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	jmp	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	xorl	%edx, %edx
               	xorl	%esi, %esi
               	xorl	%edi, %edi
               	xorq	%r8, %r8
               	xorq	%r9, %r9
               	xorq	%r10, %r10
               	xorq	%r11, %r11
               	cmpq	$0x18, %r12
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movl	$0x18, %r12d
               	jmp	<addr>
               	movl	$0x18, %r12d
               	jmp	<addr>
