
tail_call_args_from_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	movslq	%ecx, %rdi
               	movslq	%r11d, %r11
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	$0x3, %r10d
               	imulq	%r10, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	shlq	$0x2, %rdi
               	movslq	%edi, %rdi
               	addq	%rdi, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %r11
               	movslq	%r11d, %r9
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movq	%r11, %rdi
               	addq	$0x2, %rdi
               	movslq	%edi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%r11, %rsi
               	addq	$0x3, %rsi
               	movslq	%esi, %rsi
               	movq	%r11, %rdx
               	addq	$0x4, %rdx
               	movslq	%edx, %rdx
               	movq	%r11, %rcx
               	addq	$0x5, %rcx
               	movslq	%ecx, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	%r11, %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movq	%r11, %r15
               	addq	$0x7, %r15
               	movslq	%r15d, %r15
               	movq	%r11, %r14
               	addq	$0x8, %r14
               	movslq	%r14d, %r14
               	movq	%r11, %r12
               	addq	$0x9, %r12
               	movslq	%r12d, %r10
               	movq	%r10, 0x48(%rsp)
               	movq	%r11, %rbx
               	addq	$0xa, %rbx
               	movslq	%ebx, %rbx
               	movq	%r11, %r12
               	addq	$0xb, %r12
               	movslq	%r12d, %r12
               	movq	%r11, %rcx
               	addq	$0xc, %rcx
               	movslq	%ecx, %rcx
               	movq	%r11, %rdi
               	addq	$0xd, %rdi
               	movslq	%edi, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%r11, %rdi
               	addq	$0xe, %rdi
               	movslq	%edi, %r10
               	movq	%r10, 0x28(%rsp)
               	addq	$0xf, %r11
               	movslq	%r11d, %r11
               	movslq	%r9d, %r9
               	movslq	%r8d, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movslq	%esi, %rsi
               	addq	%rsi, %r9
               	movslq	%r9d, %r9
               	movslq	%edx, %rdx
               	addq	%rdx, %r9
               	movslq	%r9d, %r9
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movslq	%r15d, %r15
               	addq	%r15, %r9
               	movslq	%r9d, %r9
               	movslq	%r14d, %r14
               	addq	%r14, %r9
               	movslq	%r9d, %r9
               	movq	0x48(%rsp), %r14
               	movslq	%r14d, %r14
               	addq	%r14, %r9
               	movslq	%r9d, %r9
               	movslq	%ebx, %rbx
               	addq	%rbx, %r9
               	movslq	%r9d, %r9
               	movslq	%r12d, %r12
               	addq	%r12, %r9
               	movslq	%r9d, %r9
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	movq	0x28(%rsp), %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r9
               	movslq	%r9d, %r9
               	movq	0x40(%rsp), %rax
               	movslq	%eax, %rax
               	movq	0x48(%rsp), %rcx
               	movslq	%ecx, %rcx
               	movq	0x30(%rsp), %r12
               	movslq	%r12d, %r12
               	movslq	%r9d, %r9
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movl	$0x3, %r11d
               	imulq	%r11, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%r12, %r9
               	movslq	%r9d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rbx
               	cmpq	$0xbf, %rbx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
