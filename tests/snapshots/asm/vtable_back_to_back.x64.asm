
vtable_back_to_back.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	%edx, %r8
               	movslq	%ecx, %rdi
               	leaq	<rip>, %r9
               	movq	%r9, (%r11)
               	addq	$0x8, %r11
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%r11)
               	xorq	%rax, %rax
               	retq
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	movslq	%edx, %rax
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	movl	%r11d, (%r9)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x10(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	popq	%rax
               	leaq	<rip>, %r11
               	movq	(%r11), %r11
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	movl	$0x8, %ecx
               	callq	*%r11
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x1, %edx
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movslq	-0x40(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x40(%rbp), %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
