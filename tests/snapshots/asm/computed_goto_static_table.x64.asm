
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
               	movzbq	(%rdi), %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	jmpq	*%rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movzbq	(%rdi,%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rsi
               	movslq	%edx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movzbq	(%rdi,%rcx), %rcx
               	subq	%rcx, %rax
               	leaq	<rip>, %rsi
               	movslq	%edx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	addq	%rax, %rax
               	leaq	<rip>, %rsi
               	movslq	%ecx, %rdx
               	leaq	0x1(%rdx), %rcx
               	movzbq	(%rdi,%rdx), %rdx
               	movq	(%rsi,%rdx,8), %rdx
               	jmpq	*%rdx
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
