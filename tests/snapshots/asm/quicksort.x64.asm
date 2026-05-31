
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	(%r11), %r8
               	movslq	(%r9), %rdi
               	movl	%edi, (%r11)
               	movslq	%r8d, %r8
               	movl	%r8d, (%r9)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x28(%rsp)
               	movslq	%esi, %r9
               	movslq	%edx, %r12
               	movq	%r12, %rdi
               	shlq	$0x2, %rdi
               	movq	%rdi, %r10
               	movq	0x28(%rsp), %rdi
               	addq	%r10, %rdi
               	movslq	(%rdi), %r14
               	movq	%r9, %rdi
               	subq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r9
               	cmpq	%r12, %r9
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdx
               	movslq	(%rdx), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdx)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r9
               	shlq	$0x2, %r9
               	movq	%r9, %r10
               	movq	0x28(%rsp), %r9
               	addq	%r10, %r9
               	movslq	(%r9), %r9
               	movslq	%r14d, %rdi
               	cmpq	%rdi, %r9
               	jg	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rbx
               	addq	$0x1, %rbx
               	movslq	%ebx, %rbx
               	shlq	$0x2, %rbx
               	movq	%rbx, %r10
               	movq	0x28(%rsp), %rbx
               	addq	%r10, %rbx
               	shlq	$0x2, %r12
               	movq	0x28(%rsp), %r15
               	addq	%r12, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	movslq	-0x10(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %r15
               	addq	%rdx, %r15
               	movslq	-0x18(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	0x28(%rsp), %rbx
               	addq	%rdx, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movslq	%edx, %r14
               	cmpq	%r14, %r12
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	subq	$0x1, %rdi
               	movslq	%edi, %r15
               	movq	%rbx, %rdi
               	movq	%r15, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r12
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0x14, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	xorq	%r14, %r14
               	movl	$0xc, %r8d
               	movl	%r8d, (%r12)
               	movl	$0x4, %ebx
               	movq	%r12, %r8
               	addq	$0x4, %r8
               	movl	$0x7, %esi
               	movl	%esi, (%r8)
               	movq	%r12, %rdx
               	addq	$0x8, %rdx
               	movl	$0xf, %esi
               	movl	%esi, (%rdx)
               	movq	%r12, %r8
               	addq	$0xc, %r8
               	movl	$0x5, %esi
               	movl	%esi, (%r8)
               	movq	%r12, %rdx
               	addq	$0x10, %rdx
               	movl	$0xa, %esi
               	movl	%esi, (%rdx)
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%r14, %rsi
               	callq	<addr>
               	movslq	(%r12), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %r12
               	movslq	(%r12), %r12
               	cmpq	$0xf, %r12
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
