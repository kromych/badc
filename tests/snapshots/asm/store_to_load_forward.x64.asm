
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
               	subq	$0x30, %rsp
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	leaq	(%rcx,%rcx), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, (%rax)
               	leaq	(%rcx,%rcx), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rdx,%rcx), %rax
               	cmpq	$0x1b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
