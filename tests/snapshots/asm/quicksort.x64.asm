
quicksort.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	(%rdi), %rax
               	movslq	(%rsi), %rcx
               	movl	%ecx, (%rdi)
               	movl	%eax, (%rsi)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r12
               	movq	%rsi, %r15
               	movslq	%r15d, %r15
               	movslq	%r12d, %r12
               	movq	%r12, %rax
               	shlq	$0x2, %rax
               	addq	%rbx, %rax
               	movslq	(%rax), %r14
               	movq	%r15, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %r10
               	movq	%r10, 0x28(%rsp)
               	jmp	<addr>
               	movslq	%r15d, %rax
               	cmpq	%r12, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r15d, %rax
               	movq	%rax, %r15
               	addq	$0x1, %r15
               	jmp	<addr>
               	movslq	%r15d, %rax
               	shlq	$0x2, %rax
               	addq	%rbx, %rax
               	movslq	(%rax), %rax
               	cmpq	%r14, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movq	%rbx, %rdi
               	addq	%rax, %rdi
               	movq	%r12, %rax
               	shlq	$0x2, %rax
               	movq	%rbx, %rsi
               	addq	%rax, %rsi
               	callq	<addr>
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	addq	$0x1, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x28(%rsp), %rax
               	movslq	%eax, %rax
               	shlq	$0x2, %rax
               	movq	%rbx, %rdi
               	addq	%rax, %rdi
               	movslq	%r15d, %rax
               	shlq	$0x2, %rax
               	movq	%rbx, %rsi
               	addq	%rax, %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	movslq	%r14d, %r14
               	cmpq	%r14, %r12
               	jge	<addr>
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %r15
               	movslq	%r15d, %rax
               	subq	$0x1, %rax
               	movslq	%eax, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%r15d, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x14, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorq	%rsi, %rsi
               	movl	$0xc, %eax
               	movl	%eax, (%rbx)
               	movl	$0x4, %edx
               	movq	%rbx, %rax
               	addq	$0x4, %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movl	$0xf, %ecx
               	movl	%ecx, (%rax)
               	movq	%rbx, %rax
               	addq	$0xc, %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movl	$0xa, %ecx
               	movl	%ecx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
