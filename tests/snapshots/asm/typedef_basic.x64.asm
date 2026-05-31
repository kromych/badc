
typedef_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x64, %r11d
               	movl	$0x41, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x499602d2, %r12d      # imm = 0x499602D2
               	leaq	<rip>, %r14
               	leaq	-0x30(%rbp), %rsi
               	movl	$0x7, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x30(%rbp), %rcx
               	addq	$0x8, %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	-0x38(%rbp), %rsi
               	movl	$0xb, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x38(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	$0x16, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	%edx, (%rsi)
               	leaq	-0x48(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	leaq	-0x48(%rbp), %rsi
               	addq	$0x8, %rsi
               	movl	$0x3, %edx
               	movl	%edx, (%rsi)
               	movslq	%r11d, %r15
               	movq	0x28(%rsp), %rbx
               	andq	$0xff, %rbx
               	movq	%r15, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0xa5, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%r14), %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %r14
               	cmpq	$0x7, %r14
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %r14
               	movslq	(%r14), %rax
               	leaq	-0x38(%rbp), %r14
               	addq	$0x4, %r14
               	movslq	(%r14), %rbx
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rbx
               	leaq	-0x48(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r14
               	addq	%r14, %rbx
               	movslq	%ebx, %rbx
               	leaq	-0x48(%rbp), %r14
               	addq	$0x8, %r14
               	movslq	(%r14), %rax
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x6, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x499602d2, %r12       # imm = 0x499602D2
               	je	<addr>
               	movl	$0x6, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %r12
               	andq	$0xff, %r12
               	cmpq	$0x41, %r12
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x8, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x9, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
