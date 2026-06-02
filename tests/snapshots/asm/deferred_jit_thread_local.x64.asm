
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	leaq	<rip>, %r9
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	addq	%r9, %r8
               	movl	%r11d, (%r8)
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	movslq	(%r9), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rdi
               	cmpq	$0x7, %rdi
               	je	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rdi
               	subq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$-0x3, %rdi
               	je	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movslq	(%rax), %rdi
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rax)
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
