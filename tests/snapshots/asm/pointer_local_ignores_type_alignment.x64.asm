
pointer_local_ignores_type_alignment.x64:	file format elf64-x86-64

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

<via_struct_pointer>:
               	movl	(%rdi), %eax
               	movl	0x4(%rdi), %ecx
               	addq	%rcx, %rax
               	retq

<via_scalar_pointer>:
               	movl	(%rdi), %eax
               	movl	0xc(%rdi), %ecx
               	addq	%rcx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
