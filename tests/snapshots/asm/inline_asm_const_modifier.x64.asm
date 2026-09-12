
inline_asm_const_modifier.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<get_seven>:
               	movl	$0x7, %eax
               	retq

<read_directive_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x2a, %edx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x18(%rbp), %r10
               	movl	%ebx, (%r10)
               	movslq	-0x8(%rbp), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

<address_modifier>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	leave
               	retq

<call_modifier>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	callq	<addr>
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x2a, %edx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	jmp	<addr>
               	subb	(%rax), %al
               	addb	%al, (%rax)
               	leaq	-<rip>, %rax        # <addr>
               	movl	(%rax), %ebx
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x18(%rbp), %r10
               	movl	%ebx, (%r10)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rax
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx      # <addr>
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	callq	<addr>
               	movq	-0x20(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	movslq	%eax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
