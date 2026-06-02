
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
               	movslq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %r9d
               	movl	%r9d, (%r11)
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movl	$0x2a, %r9d
               	movl	%r9d, (%rax)
               	movslq	(%r11), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rdi
               	subq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x2a, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movslq	(%r11), %rdi
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%r11)
               	movslq	(%r11), %r11
               	cmpq	$0x31, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	popq	%rbp
               	retq
