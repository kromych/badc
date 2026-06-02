
memory_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xa, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x41, %r15d
               	movl	$0x9, %r14d
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x20(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x20(%rsp), %rax
               	addq	$0x9, %rax
               	xorq	%r12, %r12
               	movb	%r12b, (%rax)
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x28(%rsp), %rax
               	addq	$0x9, %rax
               	movb	%r12b, (%rax)
               	movq	%rbx, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rax
               	addq	$0x5, %rax
               	movl	$0x42, %r15d
               	movb	%r15b, (%rax)
               	movl	$0xa, %edx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x2, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
