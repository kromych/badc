
thread_local_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %r11
               	subq	$0x10, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movl	$0x7, %r9d
               	movl	%r9d, (%rax)
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movl	$0x2a, %r9d
               	movl	%r9d, (%r8)
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movslq	(%r9), %r8
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movslq	(%r9), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rax)
               	movq	%fs:0x0, %rdi
               	subq	$0x10, %rdi
               	movslq	(%rdi), %r8
               	cmpq	$0x31, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	popq	%rbp
               	retq
