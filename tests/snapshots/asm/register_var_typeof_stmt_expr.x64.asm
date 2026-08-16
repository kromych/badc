
register_var_typeof_stmt_expr.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x2a, %eax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%r10, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %r10
               	movq	%r10, %rax
               	movq	-0x20(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %r10
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
