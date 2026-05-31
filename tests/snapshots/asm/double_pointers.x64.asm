
double_pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r11
               	movq	(%r11), %r9
               	movl	$0x2a, %r11d
               	movl	%r11d, (%r9)
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x2a, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r8
               	movslq	(%r8), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x4, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	movq	(%r12), %r14
               	movl	$0x7b, %eax
               	movl	%eax, (%r14)
               	movq	(%r12), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%r12), %rax
               	movslq	(%rax), %r12
               	cmpq	$0x7b, %r12
               	je	<addr>
               	movl	$0x4, %eax
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
               	addb	%al, 0x41(%rdx)
