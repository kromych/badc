
fn_ptr_struct_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x230, %esi            # imm = 0x230
               	callq	<addr>
               	ud2

<finder_impl>:
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %r11
               	callq	*%r11
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
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
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
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
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
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
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%r12, %r11
               	callq	*%r11
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
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
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
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
               	addb	%al, (%rax)
