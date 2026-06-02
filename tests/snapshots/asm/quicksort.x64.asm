
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r9
               	movslq	%edx, %r12
               	movq	%r12, %rdi
               	shlq	$0x2, %rdi
               	addq	%rbx, %rdi
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
               	addq	%rbx, %r9
               	movslq	(%r9), %r9
               	movslq	%r14d, %rdi
               	cmpq	%rdi, %r9
               	jg	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	movq	%rbx, %rdi
               	addq	%rsi, %rdi
               	shlq	$0x2, %r12
               	movq	%rbx, %rsi
               	addq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r9
               	addq	$0x1, %r9
               	movl	%r9d, (%rdi)
               	movslq	-0x10(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	%rbx, %rdi
               	addq	%rdx, %rdi
               	movslq	-0x18(%rbp), %rdx
               	shlq	$0x2, %rdx
               	movq	%rbx, %rsi
               	addq	%rdx, %rsi
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
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
               	movslq	%edi, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
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
               	movl	$0xc, %r8d
               	movl	%r8d, (%rbx)
               	movl	$0x4, %edx
               	movq	%rbx, %r8
               	addq	$0x4, %r8
               	movl	$0x7, %edi
               	movl	%edi, (%r8)
               	movq	%rbx, %r11
               	addq	$0x8, %r11
               	movl	$0xf, %edi
               	movl	%edi, (%r11)
               	movq	%rbx, %r8
               	addq	$0xc, %r8
               	movl	$0x5, %edi
               	movl	%edi, (%r8)
               	movq	%rbx, %r11
               	addq	$0x10, %r11
               	movl	$0xa, %edi
               	movl	%edi, (%r11)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
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
               	movl	$0x2, %edx
               	movq	%rdx, %rcx
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
               	movl	$0x3, %edx
               	movq	%rdx, %rcx
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
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %rbx
               	movslq	(%rbx), %rbx
               	cmpq	$0xf, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
