
block_extern_shadows_file_scope_name.x64:	file format elf64-x86-64

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

<body_scope_extern>:
               	xorl	%eax, %eax
               	retq

<nested_scope_extern>:
               	xorl	%eax, %eax
               	retq

<main>:
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	0x8(%rax), %eax
               	addq	%rcx, %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
