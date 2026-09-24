
forward_enum_tag_redeclaration.x64:	file format elf64-x86-64

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

<get_subrequest>:
               	movq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	incq	%rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	retq

<trace_size>:
               	movl	$0x1, %eax
               	retq

<scale>:
               	leaq	(%rdi,%rdi,2), %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
