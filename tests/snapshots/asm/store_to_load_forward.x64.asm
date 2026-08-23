
store_to_load_forward.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorq	%rdx, %rdx
               	movq	%rdx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	addq	%rcx, %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movl	$0x9, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, (%rax)
               	leaq	(%rcx,%rcx), %rsi
               	addq	$0x0, %rsi
               	leaq	(%rsi,%rcx), %rax
               	cmpq	$0x1b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
