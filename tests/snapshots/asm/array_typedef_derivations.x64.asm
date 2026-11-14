
array_typedef_derivations.x64:	file format elf64-x86-64

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

<get>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	callq	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movl	0x8(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
