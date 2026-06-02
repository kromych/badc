
fn_ptr_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	leaq	<rip>, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %r8
               	movq	%r8, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	xorq	%rdi, %rdi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %r8
               	xorq	%rdi, %rdi
               	movq	%r8, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %r12       # <addr>
               	xorq	%rdi, %rdi
               	movq	%r12, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%r12, %r11
               	movq	%rax, %rdi
               	callq	*%r11
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rbx
               	xorq	%rdi, %rdi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
