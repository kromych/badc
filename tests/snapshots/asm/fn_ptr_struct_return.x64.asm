
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
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r9
               	movq	(%r9), %r9
               	movq	%r9, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rdi
               	xorq	%r8, %r8
               	movq	%rdi, %r11
               	movq	%r8, %rdi
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
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
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rbx       # <addr>
               	xorq	%rdi, %rdi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x4, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x5, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	xorq	%rdi, %rdi
               	movq	%rax, %r11
               	callq	*%r11
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movl	$0x6, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
