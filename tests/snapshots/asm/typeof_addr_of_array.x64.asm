
typeof_addr_of_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x28, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	0x4(%rax), %ecx
               	cmpl	$0x14, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1e, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x28, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
