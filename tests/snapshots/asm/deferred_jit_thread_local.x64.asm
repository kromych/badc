
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x7, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movq	%fs:0x0, %rbx
               	subq	$0x10, %rbx
               	movslq	(%rbx), %r8
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rax)
               	movq	%fs:0x0, %rdi
               	subq	$0x10, %rdi
               	movslq	(%rdi), %r8
               	cmpq	$0x4, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
