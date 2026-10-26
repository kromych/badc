
unknown_size_array_takes_whole_rows.x64:	file format elf64-x86-64

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

<file_scope>:
               	leaq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movsbq	0x7(%rax), %rcx
               	cmpl	$0x66, %ecx
               	jne	<addr>
               	cmpb	$0x0, 0x9(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x14(%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq

<block_scope>:
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0xc(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	jmp	<addr>
