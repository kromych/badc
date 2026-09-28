
computed_goto_static_table.x64:	file format elf64-x86-64

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

<interp>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	movl	$0x1, %ecx
               	movzbq	(%rdi), %r8
               	leaq	<rip>, %rsi
               	movq	(%rdx,%r8,8), %rdx
               	jmpq	*%rdx
               	leaq	0x1(%rcx), %rdx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	leaq	0x1(%rcx), %rdx
               	movzbq	(%rdi,%rcx), %rcx
               	subq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	addq	%rax, %rax
               	leaq	0x1(%rcx), %r8
               	movzbq	(%rdi,%rcx), %rcx
               	movq	(%rsi,%rcx,8), %rdx
               	movq	%r8, %rcx
               	jmpq	*%rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
